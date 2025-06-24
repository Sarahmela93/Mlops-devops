# Projet DevOps / MLOps – Prédiction des prix immobilier

## Réalisé par

- Mohamed ELHAFA
- Gaowen LI
- Sarah MELAIKIA

#### Ceci est un projet d'études
---

## Notre projet:

L’idée est de construire une application complète qui prédit le prix d’une maison en combinant plusieurs technos de DevOps et MLOps.  
On part d’un dataset CSV puis on entraîne un modèle avec `LightGBM`, on le traque avec `MLflow` et on expose tout via une API FastAPI.  
Tout est containerisé avec Docker et le déploiement se fait sur AWS grâce à Terraform.

---
## Prérequis

- Terraform (>= 1.0)  
- Ansible (>= 2.9)  
- Docker & Docker Compose  
- Python 3.8+  
- AWS CLI configuré  
- certbot (pour SSL)

---
## Architecture globale

- **Terraform / OpenTofu** : pour créer automatiquement deux machines EC2 
- **Ansible** : pour les futures configurations automatiques  
- **Docker / Docker Compose** : pour lancer les services facilement
- **MLflow** : pour suivre l'entraînement, log des metrics, et stockage du modèle
- **FastAPI** : pour interagir avec le modèle via des endpoints (`/predict`, `/retrain`)
- **Pandas et LightGBM** : pour l'entraînement

---

## L'arborescence du projet

```bash
├── data/                  
├── docker/                
│   ├── api/Dockerfile
│   ├── mlflow/Dockerfile
│   └── front/Dockerfile
├── infrastructure/        
│   └── terraform/
├── src/                   
│   ├── api.py             
│   ├── data_generator.py  
│   └── train_model.py     
├── compose.yml            
└── requirements.txt
```

## Le fonctionnement de notre API
L’API a deux routes principales :

GET /predict
- Donne une estimation du prix d'une maison en fonction de sa taille, son nombre de pièces, s’il y a un jardin, et son orientation.

GET /retrain
- Permet de réentraîner le modèle à partir du fichier CSV.

## Entraînement et MLflow
On a utilisé MLflow pour suivre les expériences d'entraînement :
logs des hyperparamètres, métriques (RMSE, MAE, R2) et stockage du modèle dans mlruns/.

## Installation
Cloner le repo avec:
git clone https://github.com/Sarahmela93/Mlops-devops-main.git

Installer les dépendances Python:
``` pip install -r requirements.txt ```

## Lancement du projet en local avec Docker
Pré-requis : Avoir Docker installé et lancé sur votre machine.

Lancer tous les services avec:
```docker-compose up -d --build```

Après le demarrage des conteneurs, accédez à:

**Streamlit front-end** : http://localhost:8501 <br />
**MLflow UI** : http://localhost:5000 <br />
**API FastAPI** : http://localhost:8000/docs <br />

Pour stopper les conteneurs:
``` docker-compose down -v ```

## Entrainement du modèle sans Docker
```bash
cd src
python train_model.py 
mlflow ui
uvicorn api:app --reload
streamlit run model_app.py
```


Pour tester l’API :
Accédez à http://localhost:8000/docs pour utiliser l’interface Swagger auto-générée 

## Le déploiement AWS
```bash
cd infrastructure/terraform
terraform init
terraform apply -auto-approve
```

On a utilisé Terraform pour déployer 2 instances EC2 :

Une pour héberger l’API

Une pour entraîner le modèle et faire tourner MLflow

## Technologies utilisées
### Catégorie et Outils
- Infra : Terraform  
- Cloud: AWS EC2    
- Container: Docker, Docker Compose  
- Front: Streamlit  
- Machine Learning: Python, LightGBM, MLflow
- API : FastAPI  
- Suivi: MLflow UI  
