from asyncore import read
import pandas 
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import r2_score
from tqdm import tqdm
import seaborn as sns
import matplotlib.pyplot as plt

def readData():
    df = pandas.read_csv("patients.csv")
    return cleanData(df)

def cleanData(df):
    df = df.drop(columns=['Number', 'Td1', 'kd1', 'EC501', 'y1', 'Gender'])
    #clean inputs
    df["Age"].replace('', np.nan, inplace=True)
    df["Weight"].replace('', np.nan, inplace=True)
    df["Height"].replace('', np.nan, inplace=True)
    # df["Gender"].replace('', np.nan, inplace=True)
    #clean outputs
    df["E0"].replace(0, np.nan, inplace=True)
    df["Td"].replace(0, np.nan, inplace=True)
    df["E50"].replace(0, np.nan, inplace=True)
    df["y"].replace(0, np.nan, inplace=True)
    df["k"].replace(0, np.nan, inplace=True)
    
    df = df.dropna()
    return df

def linearReg(inputs_train, inputs_test, targets_train, targets_test):
    model_LR = LinearRegression()
    model_LR.fit(inputs_train, targets_train)
    predict_LR = model_LR.predict(inputs_test)
    r2score_LR = r2_score(targets_test, predict_LR)
    return r2score_LR

def randomForest(inputs_train, inputs_test, targets_train, targets_test):
    model_RF = RandomForestRegressor()
    model_RF.fit(inputs_train, targets_train)
    predict_RF = model_RF.predict(inputs_test)
    r2score_RF = r2_score(targets_test, predict_RF)
    return r2score_RF

def main():
    df = readData()

    inputs = df[["Age", "Weight", "Height"]]
    targets = df[["E0", "Td", "E50", "y", "k"]]

    # sns.heatmap(df.corr(), cmap="YlGnBu", annot= True)
    # plt.show()

    for i in range(2, 8):
        results_LR = []    
        results_RF = []    
        test_size = i/10
        print(f"Test Size: {test_size}")
        for _ in tqdm(range(0, 60)):
            inputs_train, inputs_test, targets_train, targets_test = train_test_split(inputs,  targets, test_size=test_size)
            r2score_LR = linearReg(inputs_train, inputs_test, targets_train, targets_test)
            r2score_RF = randomForest(inputs_train, inputs_test, targets_train, targets_test)
            results_LR.append(r2score_LR)
            results_RF.append(r2score_RF)

        print("Linear Regression:")
        print(f"R2score: {np.mean(results_LR)}")
        print("Random Forest:")
        print(f"R2score: {np.mean(results_RF)}")
        print()

    return

if __name__ == "__main__":
    main()