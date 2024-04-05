from pydantic import BaseModel


class UserLogin(BaseModel):
    fin: str
    password: str

class UserRegister(UserLogin):
    fin: str
    phoneNumber: str
    password: str