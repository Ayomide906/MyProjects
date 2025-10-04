import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
df = pd.read_csv('Datasets/homeprices_multivar.csv')
df.bedrooms.fillna(df['bedrooms'].median(), inplace=True)
print(df.head())


def gradient_descent(X, y):
    # Add bias term (column of 1s) to X
    X = np.column_stack([np.ones(X.shape[0]), X])
    # Initialize parameters (including intercept)
    theta = np.zeros(X.shape[1])
    iterations = 1000
    learning_rate = 0.01 # Much more reasonable learning rate
    for i in range(iterations):
        y_pred = X @ theta
        # Correct gradient calculation
        gradient = (1 / len(y)) * (X.T @ (y_pred - y))
        theta -= learning_rate * gradient
        cost = np.mean((y_pred - y) ** 2)
        print(f"Iteration {i + 1}: Cost = {cost}")
    return theta
if __name__ == '__main__':
    X = df.drop('price', axis=1).values
    y = df['price'].values
    scaler = StandardScaler()
    y_scaled =scaler.fit_transform(y.reshape(-1, 1)).flatten()
    x_scaled = scaler.fit_transform(X)
    theta = gradient_descent(x_scaled, y_scaled)
    y_pred_scaled = np.column_stack([np.ones(x_scaled.shape[0]), x_scaled]) @ theta
    y_pred =scaler.inverse_transform(y_pred_scaled.reshape(-1, 1)).flatten()
    print(y_pred)
    print("Final parameters:", theta)
    print(f"Intercept: {theta[0]}, Coefficients: {theta[1:]}")