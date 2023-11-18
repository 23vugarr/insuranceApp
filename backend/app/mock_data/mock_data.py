from app.models.authentication import UserLogin
from app.core.database import get_db

db = get_db()

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

for i in range(len(mock_users)):
    user = UserLogin(
        name=mock_users[i].name,
        surname=mock_users[i].surname,
        fin=mock_users[i].fin,
        phoneNumber=mock_users[i].phoneNumber
    )
    db.add(user)

db.commit()
