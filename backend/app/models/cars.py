from sqlalchemy import Column, String, BigInteger, DateTime, ForeignKey, Integer
from sqlalchemy.sql import func
from app.core.database import Base
import random

class CarDetails(Base):
    __tablename__ = "car_details"

    id = Column(BigInteger, primary_key=True, default=lambda: random.randint(10**8, 10**9 - 1), index=True, unique=True)
    plateNumber = Column(String(20), unique=True, index=True, nullable=False)
    year = Column(Integer, nullable=False)
    model = Column(String(30),nullable=False)
    color = Column(String(10), nullable=True)
    user_id = Column(BigInteger, ForeignKey('user_login.id'))
    created_at = Column(DateTime, default=func.now())