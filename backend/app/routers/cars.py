from fastapi import APIRouter, HTTPException, Depends, UploadFile
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.dependencies.authentication import oauth2_scheme
from app.models.cars import CarDetails as CarDetailsModel
from datetime import date
import base64
import requests
import json
import numpy as np
import pickle as pk


router = APIRouter()

@router.get("/cars", dependencies=[Depends(oauth2_scheme)])
async def company(token: dict = Depends(oauth2_scheme),
                  db: Session = Depends(get_db)):
    try:
        user_id = token.get("sub")
        car_db = db.query(CarDetailsModel).filter(CarDetailsModel.user_id == user_id).all()

        if(not car_db):
            return {
                "result": None
            } 
        
        print(car_db)
        
    except Exception as e:
        print(e)
        raise HTTPException(status_code=400, detail=str(e))

    return {
        "result": {
            "cars": car_db
        }
    }


@router.post("/report/{car_id}", dependencies=[Depends(oauth2_scheme)])
async def report(file: UploadFile,
                 car_id: int,
                 token: dict = Depends(oauth2_scheme),
                 db: Session = Depends(get_db)):
    
    file_content = await file.read()
    base64_bytes = base64.b64encode(file_content)
    base64_string = "data:image/jpeg;base64,"+base64_bytes.decode()

    response = requests.post("https://23vugarr-car-parts-damage-detection.hf.space/run/predict", json={
          "data": [
            base64_string,
        ]
    }).json()
    
    damages = response["data"][0][21:]
    damages = base64.b64decode(damages)
    damages = list(damages)

    scratches = response["data"][1][21:]
    scratches = base64.b64decode(scratches)
    scratches = list(scratches)

    car_parts = response["data"][2][21:]
    car_parts = base64.b64decode(car_parts)
    car_parts = list(car_parts)

    damages_info_str = response["data"][3]

    overlayed_damage = response["data"][4][21:]
    overlayed_damage = base64.b64decode(overlayed_damage)
    overlayed_damage = list(overlayed_damage)
    
    return {
        "result": {
            "damages": damages,
            "scratches": scratches,
            "car_parts": car_parts,
            "damages_info_str": damages_info_str,
            "overlayed_damage": overlayed_damage,
            "date": date.today(),
            "car_id": car_id
        }
    }


@router.post("/validate/{car_id}", dependencies = [Depends(oauth2_scheme)], status_code=200)
async def validate(file: UploadFile,
                 car_id: int,
                 token: dict = Depends(oauth2_scheme),
                 db: Session = Depends(get_db)):
    state = 0
    if(not state):
        return {
            "testing": "request"
        }
    
    from keras.utils import get_file
    from keras.applications.imagenet_utils import preprocess_input
    from keras.preprocessing.image import img_to_array, load_img
    from keras.applications.vgg16 import VGG16
    
    with open('vgg16_cat_list.pk', 'rb') as f:
        cat_list = pk.load(f)
    model1 = VGG16(weights = 'imagenet')

    CLASS_INDEX = None
    CLASS_INDEX_PATH = 'https://s3.amazonaws.com/deep-learning-models/image-models/imagenet_class_index.json'

    def get_predictions(preds, top=5):
        global CLASS_INDEX
        if len(preds.shape) != 2 or preds.shape[1] != 1000:
            raise ValueError('`decode_predictions` expects a batch of predictions (i.e. a 2D array of shape (samples, 1000)). Found array with shape: ' + str(preds.shape))
        if CLASS_INDEX is None:
            fpath = get_file('imagenet_class_index.json',CLASS_INDEX_PATH,cache_subdir='models')
            CLASS_INDEX = json.load(open(fpath))
        results = []
        for pred in preds:
            top_indices = pred.argsort()[-top:][::-1]
            result = [tuple(CLASS_INDEX[str(i)]) + (pred[i],) for i in top_indices]
            result.sort(key=lambda x: x[2], reverse=True)
            results.append(result)
        return results
    
    def prepare_image_224(img_path):
        img = np.array(list(img))
        img = load_img('save.jpg', target_size=(224, 224))
        x = img_to_array(img)
        x = np.expand_dims(x, axis=0)
        x = preprocess_input(x)
        return x
    
    def pipe1(img_224, model):
        print("Ensuring entered picture is a car...")
        out = model.predict(img_224)
        preds = get_predictions(out, top=5)
        for pred in preds[0]:
            if pred[0:2] in cat_list:
                return True
        return False 
    
    return pipe1(prepare_image_224(file), model1)