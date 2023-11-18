from fastapi.security import HTTPBearer
from app.core.config import settings
from app.models.authentication import UserLogin as UserLoginModel
from fastapi import HTTPException, Request, Depends
from sqlalchemy.orm import Session
from app.core.database import get_db
from datetime import datetime, timedelta
import jwt


class CustomHTTPBearer(HTTPBearer):
    def __init__(self, auto_error: bool = True):
        super().__init__(auto_error=auto_error)
    

    async def __call__(self, request: Request, db: Session = Depends(get_db)):
        res = await super().__call__(request)
        try:
            payload = jwt.decode(res.credentials, settings.JWT_SECRET, algorithms=["HS256"])
            
            return payload
        except jwt.PyJWTError as e:
            print(e)
            raise HTTPException(status_code=403, detail=str(e))
        except Exception as e:
            print(e)
            raise HTTPException(status_code=403, detail=str(e))
        
        
    def create_access_token(User):
        try:
            payload = {
                "sub": User.id,
                "exp": datetime.utcnow() + timedelta(minutes=100000)
            }
            return jwt.encode(payload, settings.JWT_SECRET, algorithm="HS256")
        except Exception as e:
            print(e)
            raise HTTPException(status_code=400, detail=str(e))


oauth2_scheme = CustomHTTPBearer()