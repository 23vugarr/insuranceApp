import bcrypt
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.core.database import get_db
from app.dependencies.authentication import CustomHTTPBearer
from app.models.authentication import UserLogin as UserLoginModel
from app.schemas.authentication import UserLogin, UserRegister

router = APIRouter()


@router.post("/register")
async def registration(user: UserRegister, db: Session = Depends(get_db)):
    try:
        salt = bcrypt.gensalt()
        user.password = user.password.encode("utf-8")
        user.password = bcrypt.hashpw(user.password, salt)
        db_user = (
            db.query(UserLoginModel)
            .filter(
                UserLoginModel.fin == user.fin
                and UserLoginModel.phoneNumber == user.phoneNumber
            )
            .first()
        )

        if db_user:
            db_user.password = user.password.decode("utf-8")
        else:
            return {"result": None}

        db.commit()
    except Exception as e:
        print(e)
        raise HTTPException(status_code=400, detail=str(e))
    return {"result": {"accessToken": CustomHTTPBearer.create_access_token(db_user)}}


@router.post("/login")
async def login(user: UserLogin, db: Session = Depends(get_db)):
    try:
        db_company = (
            db.query(UserLoginModel).filter(UserLoginModel.fin == user.fin).first()
        )
        if not bcrypt.checkpw(
            user.password.encode("utf-8"), db_company.password.encode("utf-8")
        ):
            raise HTTPException(status_code=400, detail="Invalid Password")
    except Exception as e:
        print(e)
        raise HTTPException(status_code=400, detail=str(e))

    return {
        "result": {"access_token": CustomHTTPBearer.create_access_token(db_company)}
    }
