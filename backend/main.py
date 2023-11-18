from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from app.core.database import Base
from app.core.main import create_application
from fastapi.responses import RedirectResponse
from app.models.authentication import UserLogin
from app.core.config import settings

def create_mock():

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
            print(e)

    if case:
        try:
            db.commit()
        except Exception as e:
            print(e)
    
    return True


state = create_mock()
app = create_application()

@app.get("/")
def read_root():
    return RedirectResponse(url='/docs')