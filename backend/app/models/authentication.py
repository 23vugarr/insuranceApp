from sqlalchemy import Column, String, BigInteger, DateTime
from sqlalchemy.sql import func
from app.core.database import Base
import random

class UserLogin(Base):
    __tablename__ = "user_login"

    id = Column(BigInteger, primary_key=True, default=lambda: random.randint(10**8, 10**9 - 1), index=True, unique=True)
    name = Column(String(20), nullable=False)
    surname = Column(String(20), nullable=False)
    fin =   Column(String(7), unique=True, index=True, nullable=False)
    phoneNumber =  Column(String(9), unique=True, index=True, nullable=False)
    password = Column(String(255), nullable=True)
    created_at = Column(DateTime, default=func.now())