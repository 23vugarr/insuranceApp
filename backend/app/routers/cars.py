from fastapi import APIRouter, HTTPException, Depends, UploadFile
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.dependencies.authentication import oauth2_scheme
from app.models.cars import CarDetails as CarDetailsModel
from fastapi.responses import StreamingResponse
import io
import requests



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



# @router.post("/report/{car_id}", dependencies=[Depends(oauth2_scheme)])
# async def report(file: UploadFile,
#                  car_id: int,
#                  token: dict = Depends(oauth2_scheme),
#                  db: Session = Depends(get_db)):
#     file_content = await file.read()
    
#     files = {"file": (file.filename, file_content, file.content_type)}
    
#     response = requests.post("http://44.193.152.88:7860/", files=files) 
#     print(response)

#     damaged_image = response.content
#     print(io.BytesIO(file_content))
#     print(file_content)
    
#     return StreamingResponse(io.BytesIO(file_content), media_type='image/jpeg')

@router.post("/report/{car_id}", dependencies=[Depends(oauth2_scheme)])
async def report(file: UploadFile,
                 car_id: int,
                 token: dict = Depends(oauth2_scheme),
                 db: Session = Depends(get_db)):
    file_content = await file.read()
    
    result_as_list = list(file_content)
    
    return result_as_list

