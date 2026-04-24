# 🏠 House Price Prediction System

An end-to-end Machine Learning project that predicts house prices based on property features such as square footage, number of bedrooms, bathrooms, location, and area type.

This project demonstrates the **complete ML workflow**, from data preprocessing and model training to deploying the model through a **Flask API and an interactive web interface**.

---

## 🚀 Project Overview

The goal of this project is to build a machine learning model capable of estimating house prices based on user inputs.

Users can enter details such as:
- Total square footage
- Number of bedrooms (BHK)
- Number of bathrooms
- Area type
- Location

The trained model processes the inputs and returns an **estimated house price instantly** through a web interface.

---

## ⚙️ Technologies Used

- **Python**
- **NumPy**
- **Pandas**
- **Scikit-learn**
- **Matplotlib / Seaborn** (EDA & visualization)
- **Flask** (API backend)
- **HTML, CSS, JavaScript** (Frontend UI)
- **Jupyter Notebook** (Model development)

---

## 📊 Machine Learning Pipeline

1. **Data Cleaning**
   - Handling missing values
   - Removing irrelevant features

2. **Feature Engineering**
   - Converting categorical variables
   - Encoding locations
   - Handling outliers

3. **Model Training**
   - Linear Regression model
   - Train/Test split
   - Model evaluation

4. **Model Deployment**
   - Flask backend API
   - Interactive frontend interface
   - Real-time price prediction

---

## 📂 Project Structure
regression_proj/
```
├── model/
│ ├── banglore_home_prices_model.pickle
│ └── columns.json
│
├── server/
│ ├── server.py
│ └── util.py
│
├── client/
│ ├── app.html
│ ├── app.css
│ └── app.js
│
├── data/
│ └── banglore_home_prices.csv
│
├── model/
│ └── house_price_prediction.ipynb
│
└── README.md
```

## 📊 Model Development

The machine learning model was developed and analyzed in a Jupyter Notebook.

View the notebook here:

[House Price Prediction Notebook](model/house_price_prediction.ipynb)

## ⚙️ Backend API

The backend API is built using Flask.

Main server file:

[server.py](server/server.py)

Utility functions used for prediction:

[util.py](server/util.py)
## 🌐 Frontend Interface

The user interface allows users to input house details and receive predicted prices.

Frontend files:

- [app.html](client/app.html)
- [app.css](client/app.css)
- [app.js](client/app.js)

## 🎥 Demo

Currently the application runs on an amazon ecu instance.

Steps to test:

1. Start the backend server
2. Open the frontend page http://ec2-51-20-53-213.eu-north-1.compute.amazonaws.com/
3. Enter house details
4. Click **Predict Price**

The model will return an estimated property price.
## 📷 Application Preview

### Web Interface

![App UI](model/app_ui.png)

### Data Exploration

![EDA](model/eda.png)