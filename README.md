# Protectors

## Who we are and what is the project?

### Team Members
- Vugar Abdulaliyev (Software and Data Engineer)
- Elvin Sadikhov (Mobile Developer)
- Murad Taghiyev (Front-end Developer)

### The Project
Our topic revolves around **Insurtech Innovations**, focusing on automating claims during emergency situations for Pasha Insurance Customers, primarily in the case of car accidents.

### Example Use Case of Our Application
Pasha Insurance Claim automation is helpful when customers face car-related emergencies. The process involves:
1. Customer **opens the app**
2. **Selects the car**
3. **Clicks create report**
4. **Takes pictures of the car**
5. **AI analyzes images, detects scratches, damaged parts, and returns a claim report with estimated costs**
6. **User digitally signs the document, automatically sent to Pasha Insurance for review**
7. **Offers nearby car mechanics and evacuator service to the customer**

All these functionalities are available within our project.

## How to Run the Project

### Backend
We utilized **Python FastAPI** with the **Poetry** package manager. Find all dependencies in the `pyproject.toml` file. For database migration, we used **Alembic** and employed **Postgres** in a Docker container.
##### NOTE: Our app is deployed on cloud: [Protectors App](http://44.193.152.88/)

#### Running Locally
1. Navigate to the root of the backend folder and start the database and app:
    ```
    docker compose up -d --build
    ```
   Note: You can access Swagger for our application locally, but the mobile app functions with the deployed version on the cloud.
2. To configure migration files for your local Postgres and perform migrations in the root folder (backend):
    ```
    poetry install
    poetry run alembic revision --autogenerate -m "migrations"
    poetry run alembic upgrade head
    ```

### Mobile
We utilized **Flutter** for the mobile framework, interacting with the backend deployed on an AWS EC2 instance. To run the mobile app locally, navigate to the root of the mobile folder:
	`flutter run --release 
You can run apk version too, using the .apk file specified in our github repo.
You can also find our application in releases part.

#### After openning the app:
1. Register with predefined fin: AAABBBE, AAABBBV, AAABBBM (we are imitating ASAN Login)
2. Predefined numbers: 503534370, 102210104, 553600600 (in order with fin)
3. Click on any of your cars
4. Create report

## Feature Plans

One of the most exciting parts of our project is the DigiTwin of customers' cars. In insurance, the primary goal is to return the car to its pre-accident state. Therefore, we propose creating a 3D model of the car. When an accident occurs, a comparison between the before and after states will help select the most applicable car details.
