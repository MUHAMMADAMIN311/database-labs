# SwiftRide Analytics Dashboard

A full-stack data analytics and machine learning dashboard built using Python and Streamlit for a fictional ride-sharing company **SwiftRide**.

This project demonstrates an end-to-end data science workflow including database design, data generation, analytics, visualization, and machine learning.

---

## Project Overview

SwiftRide Analytics is a **multi-page interactive dashboard** that provides insights into ride-sharing operations using a synthetic but realistic dataset stored in SQLite.

It includes:
- Executive business KPIs
- Trip behavior analysis
- Driver performance evaluation
- Machine learning-based fare prediction

---

##  Key Features

### 1. Executive Overview 📈
- Total Revenue, Trips, Completion Rate, Average Fare
- Monthly revenue trends
- City-wise trip distribution
- Fleet mix analysis (Bike, Rickshaw, Car, SUV)

---

### 2. Trip Analytics 🛣️
- Demand heatmap (Hour vs Day of Week)
- Fare vs Distance relationship analysis
- Peak vs Off-Peak fare comparison
- Rain impact on pricing and demand

---

### 3. Driver Performance 🚘
- Top 10 drivers leaderboard
- Driver ratings and earnings analysis
- Active drivers over time
- Rating distribution insights

---

### 4. ML Fare Predictor 🤖
- Random Forest Regressor model trained on trip data
- Predicts fare based on:
  - Distance
  - Duration
  - Vehicle type
  - Time of day
  - Weather conditions
- Model evaluation using:
  - R² Score
  - MAE (Mean Absolute Error)
  - RMSE (Root Mean Squared Error)
- Live fare prediction interface

---

## 🗄️ Database Schema

The project uses a **SQLite database (`swiftride.db`)** with 6 tables:

- cities
- drivers
- riders
- trips
- payments
- reviews

### Dataset Highlights:
- 7000+ trip records
- 150 drivers
- 800 riders
- Realistic Pakistani city distribution
- Seasonal and peak-hour patterns included

---

## 🛠️ Tech Stack

- **Python**
- **Streamlit** (Web App UI)
- **SQLite** (Database)
- **Pandas** (Data manipulation)
- **NumPy** (Numerical computations)
- **Plotly** (Interactive visualizations)
- **Scikit-learn** (Machine Learning)

---

## ▶️ How to Run Locally

```bash
# Clone repository
git clone https://github.com/your-username/swiftride-app.git

# Move into project folder
cd swiftride-app

# Create virtual environment
python -m venv venv
source venv/bin/activate   # (Linux/Mac)
venv\Scripts\activate      # (Windows)

# Install dependencies
pip install -r requirements.txt

# Run Streamlit app
streamlit run app.py
```

---

## 🎯 Project Purpose

This project was built as part of a **data science and database learning journey** to simulate a real-world ride-sharing analytics system.

It focuses on:
- Understanding relational databases
- Performing real-world data analysis
- Building interactive dashboards
- Applying machine learning to business problems

---

## 🚀 Future Improvements

- 🌐 Deploy on Streamlit Cloud or AWS
- 🔐 Add authentication system for users/admins
- 📡 Integrate real-time data streaming
- 📊 Improve ML model with hyperparameter tuning
- 📱 Make mobile responsive UI

---

## 👨‍💻 Author

**M Amin Mukhlis**

Data Science Student | Python | SQL | Machine Learning

---

## ⭐ Acknowledgements

- Built using open-source Python libraries
- Inspired by real-world ride-sharing analytics systems
- Designed for educational and portfolio purposes

