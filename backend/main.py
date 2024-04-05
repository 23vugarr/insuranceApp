from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker
from app.core.database import Base
from app.core.main import create_application
from fastapi.responses import RedirectResponse
from app.models.authentication import UserLogin
from app.models.cars import CarDetails
from app.core.config import settings
from string import ascii_uppercase, digits
from random import choice
from datetime import datetime



def create_mock_users():

    engine = create_engine(settings.DATABASE_URL)

    Base.metadata.bind = engine

    DBSession = sessionmaker(bind=engine)
    db = DBSession()

    mock_users = [

    {
        "name": "Vugar",
        "surname": "Abdulali",
        "fin": "AAABBBV",
        "phoneNumber": "102210104"
    },
    {
        "name": "Elvin",
        "surname": "Sadikhov",
        "fin": "AAABBBE",
        "phoneNumber": "503534370"
    },
    {
        "name": "Murad",
        "surname": "Taghiyev",
        "fin": "AAABBBM",
        "phoneNumber": "553600600"
    },
    {
        "name": "Gultaj",
        "surname": "Seyid",
        "fin": "AAABBBG",
        "phoneNumber": "774861049"
    }
    
]

    case = False

    for i in range(len(mock_users)):
        try:
            user = UserLogin(
                name=mock_users[i]["name"],
                surname=mock_users[i]["surname"],
                fin=mock_users[i]["fin"],
                phoneNumber=mock_users[i]["phoneNumber"]
            )
            db.add(user)
            case = True
        except Exception as e:
            return False
        
    if case:
        try:
            db.commit()
        except Exception as e:
            return False
    
    return True


def generate_plate_number():
    letters = ''.join(choice(ascii_uppercase) for _ in range(2))
    numbers = ''.join(choice(digits) for _ in range(3))
    return f"10-{letters}-{numbers}"

def create_mock_cars():
    engine = create_engine(settings.DATABASE_URL)
    Base.metadata.bind = engine
    DBSession = sessionmaker(bind=engine)
    db = DBSession()

    counter = db.execute(text('SELECT * FROM "database".public.car_details')).all()
    print(counter)
    if(not counter):
        user_ids = db.execute(text('SELECT id FROM "database".public.user_login')).all()

        mock_cars = [
            {"plateNumber": generate_plate_number(), "year": 2020, "model": "Model X", "color": "Red", "user_id": user_ids[2][0]},
            {"plateNumber": generate_plate_number(), "year": 2018, "model": "Model Y", "color": "Blue", "user_id": user_ids[1][0]},
            {"plateNumber": generate_plate_number(), "year": 2022, "model": "Model Z", "color": "Black", "user_id": user_ids[0][0]},
            {"plateNumber": generate_plate_number(), "year": 2019, "model": "Model A", "color": "White", "user_id": user_ids[1][0]},
            {"plateNumber": generate_plate_number(), "year": 2021, "model": "Model B", "color": "Silver", "user_id": user_ids[0][0]},
            {"plateNumber": generate_plate_number(), "year": 2017, "model": "Model C", "color": "Green", "user_id": user_ids[2][0]},
            {"plateNumber": generate_plate_number(), "year": 2023, "model": "Model D", "color": "Yellow", "user_id": user_ids[2][0]},
            {"plateNumber": generate_plate_number(), "year": 2020, "model": "Model E", "color": "Gray", "user_id": user_ids[1][0]},
            {"plateNumber": generate_plate_number(), "year": 2016, "model": "Model F", "color": "Brown", "user_id": user_ids[0][0]},
            {"plateNumber": generate_plate_number(), "year": 2018, "model": "Model G", "color": "Orange", "user_id": user_ids[1][0]},
            {"plateNumber": generate_plate_number(), "year": 2020, "model": "Porsche", "color": "Gray", "user_id": user_ids[3][0]},
            {"plateNumber": generate_plate_number(), "year": 2016, "model": "Ferrari", "color": "Brown", "user_id": user_ids[3][0]},

        ]

        case = False

        for car_data in mock_cars:
            try:
                car = CarDetails(
                    plateNumber=car_data["plateNumber"],
                    year=car_data["year"],
                    model=car_data["model"],
                    color=car_data["color"],
                    user_id=car_data["user_id"],
                    created_at=datetime.now()
                )
                db.add(car)
                case = True
            except Exception as e:
                print(e)
                return False

        if case:
            try:
                db.commit()
            except Exception as e:
                print(e)
                return False

        return True


mock_users = create_mock_users()
mock_cars = create_mock_cars()
app = create_application()

@app.get("/")
def read_root():
    return RedirectResponse(url='/docs')