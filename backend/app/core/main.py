from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routers.authentication import router as AuthRouter
from app.routers.cars import router as CarsRouter

def create_application() -> FastAPI:
    application = FastAPI()
    
    application.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_methods=["*"],
        allow_headers=["*"],
        allow_credentials=True
    )

    application.include_router(AuthRouter, prefix="/authentication", tags=["Authentication for Company"])
    application.include_router(CarsRouter, prefix="/user", tags=["Get operations in db"])
    
    return application