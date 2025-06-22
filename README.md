# Projet DevOps / MLOps – Prédiction des prix immobilier

## Réalisé par

- Mohamed ELHAFA
- Gaowen LI
- Sarah MELAIKIA

#### Ceci est un projet d'études
---

## Notre projet:

L’idée est de construire une application complète qui prédit le prix d’une maison en combinant plusieurs technos de DevOps et MLOps.  
On part d’un dataset CSV puis on entraîne un modèle avec `LightGBM`, on le traque avec `MLflow`, et on expose tout via une API FastAPI.  
Tout est containerisé avec Docker et le déploiement se fait sur AWS grâce à Terraform.

---

## Architecture globale

- **Terraform / OpenTofu** : pour créer automatiquement deux machines EC2 (training + API)
- **Ansible** : pour les futures config auto 
- **Docker / Docker Compose** : pour lancer les services facilement
- **MLflow** : pour suivre l'entraînement, log des metrics, et stockage du modèle
- **FastAPI** : pour interagir avec le modèle via des endpoints (`/predict`, `/retrain`)
- **Pandas et LightGBM** : pour l'entraînement
- **Eurybia** : pour détecter le drift (changement de comportement dans les données)

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

Le fonctionnement de notre API
L’API a deux routes principales :

GET /predict
- Donne une estimation du prix d'une maison en fonction de sa taille, son nombre de pièces, s’il y a un jardin, et son orientation.

GET /retrain
- Permet de réentraîner le modèle à partir du fichier CSV.

## Entraînement et MLflow
On a utilisé MLflow pour suivre les expériences d'entraînement :
logs des hyperparamètres, métriques (RMSE, MAE, R2), et stockage du modèle dans mlruns/.

On a aussi intégré Eurybia pour détecter si de nouvelles données sont trop différentes de celles du passé.

## Lancement du projet en local (avec Docker)
Pré-requis : Avoir Docker installé et lancé sur votre machine.

Cloner le repo avec:
git clone https://github.com/ajout-de-votre-compte/Mlops-devops-main.git,

Lancer tous les services avec:
docker compose up --build

Pour tester l’API :
Accédez à http://localhost:8000/docs pour utiliser l’interface Swagger auto-générée 

## Le déploiement AWS
On a utilisé Terraform pour déployer 2 instances EC2 :

Une pour héberger l’API

Une pour entraîner le modèle et faire tourner MLflow

## Technologies utilisées
Catégorie et Outils
  Infra	Terraform, AWS EC2
  Config	Ansible
  Container	Docker, Docker Compose
  ML	Python, LightGBM, MLflow, Eurybia
  API	FastAPI
  Suivi	MLflow UI
