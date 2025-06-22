import request
import os
import streamlit as st
import joblib
import pandas as pd
import request

from train_model import train_model

st.title("House price prediction")

st.markdown("---")

st.write("This dataset contains information about house prices and their various features.")
st.write("It includes four columns: size, number of rooms, garden, and orientation.")
st.write("The predicted column is the price column, which contains the predicted price of the house.")

st.markdown("---")

st.markdown("### Here is an overview of the dataset:")
df = pd.read_csv("../data/houses.csv").head(5)
st.dataframe(df)

st.markdown("---")


# Ask the user to input house details for prediction
st.markdown("### Predict the price of a house:")

size = st.number_input("Size (in m2)", min_value=0, max_value=1000, value=100)
nb_rooms = st.number_input(
    "Number of rooms", min_value=0, max_value=10, value=2)
garden = st.checkbox("Garden")
orientation = st.selectbox("Orientation", ["North", "South", "East", "West"])


if st.button("Predict"):
    try:
        y_pred = request.predict_request(size, nb_rooms, garden, orientation)
        st.write(f"Predicted price: {y_pred['y_pred']:.0f} €")
    except:
        st.write("Error: could not connect to the API")

st.markdown("---")

nb_samples = st.number_input(
    "Number of samples", min_value=10, max_value=10000, value=10)

if st.button("Retrain model"): # Retrain the model with new ficticious house data to improve predictions
    try:
        request.retrain_request(nb_samples)
        st.write("Model retrained")
    except:
        st.write("Error: could not connect to the API")


st.markdown("---")

st.markdown("### Data drift")
st.write("Here is the evolution of the AUC score of the model:")

if os.path.exists("datadrift_auc_train.csv"):
    drift_df = pd.read_csv("datadrift_auc_train.csv")["auc"]
    # Check last row of drift_df
    if len(drift_df) != 0 and drift_df.iloc[-1] > 0.5:
        st.warning("Data drift detected")

        if st.button("Reset model"): # Delete saved model and synthetic data to reset training from original dataset
            try:
                os.remove("model.joblib")
                os.remove("../data/new_houses.csv")
                df = pd.read_csv("../data/houses.csv")
                df["orientation"] = df["orientation"].map(
                    {"Nord": 0, "Est": 1, "Sud": 2, "Ouest": 3})
                train_model(df)
                st.write("Model reset")
            except:
                st.write("Error during model reset")

# Show how the model's prediction quality evolved               
if os.path.exists("datadrift_auc_train.csv"):
    drift_df = pd.read_csv("datadrift_auc_train.csv")[["auc"]]
    st.area_chart(drift_df)
else:
    st.area_chart(pd.DataFrame({"auc": [0]}))

st.markdown("---")

