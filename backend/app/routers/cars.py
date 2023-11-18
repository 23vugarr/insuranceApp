from fastapi import APIRouter, HTTPException, Depends, UploadFile
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.dependencies.authentication import oauth2_scheme
from app.models.cars import CarDetails as CarDetailsModel


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
