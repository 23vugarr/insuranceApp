import base64
from datetime import date

import requests
from fastapi import APIRouter, Depends, HTTPException, UploadFile
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.dependencies.authentication import oauth2_scheme
from app.models.cars import CarDetails as CarDetailsModel

router = APIRouter()


@router.get("/cars", dependencies=[Depends(oauth2_scheme)])
async def company(token: dict = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    try:
        user_id = token.get("sub")
        car_db = (
            db.query(CarDetailsModel).filter(CarDetailsModel.user_id == user_id).all()
        )

        if not car_db:
            return {"result": None}

        print(car_db)

    except Exception as e:
        print(e)
        raise HTTPException(status_code=400, detail=str(e))

    return {"result": {"cars": car_db}}


@router.post("/report/{car_id}", dependencies=[Depends(oauth2_scheme)])
async def report(
    file: UploadFile,
    car_id: int,
    token: dict = Depends(oauth2_scheme),
):
    file_content = await file.read()
    base64_bytes = base64.b64encode(file_content)
    base64_string = "data:image/jpeg;base64," + base64_bytes.decode()
    print(base64_string)

    response = requests.post(
        "https://23vugarr-car-parts-damage-detection.hf.space/run/predict",
        json={
            "data": [
                base64_string,
            ]
        },
    ).json()

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
    print(damages)

    return {
        "result": {
            "damages": damages,
            "scratches": scratches,
            "car_parts": car_parts,
            "damages_info_str": damages_info_str,
            "overlayed_damage": overlayed_damage,
            "date": date.today(),
            "car_id": car_id,
        }
    }
