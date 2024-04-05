from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.dependencies.authentication import oauth2_scheme
from app.models.authentication import UserLogin as UserLoginModel

router = APIRouter()


@router.get("/information", dependencies=[Depends(oauth2_scheme)])
async def company(token: dict = Depends(oauth2_scheme), db: Session = Depends(get_db)):
    try:
        user_id = token.get("sub")
        user_db = db.query(UserLoginModel).filter(UserLoginModel.id == user_id).first()
        user_db.password = ""
        user_db.id = ""

        if not user_db:
            return {"result": None}

        print(user_db)

    except Exception as e:
        print(e)
        raise HTTPException(status_code=400, detail=str(e))

    return {"result": {"user": user_db}}
