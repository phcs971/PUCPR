from asyncore import read
import pandas 
import numpy as np
from sklearn.neural_network import MLPRegressor
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestRegressor
from sklearn.svm import SVR
from sklearn.metrics import r2_score
from tqdm import tqdm
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.metrics import confusion_matrix, classification_report


def readData():
    df = pandas.read_csv("patients.csv")
    return cleanData(df)

def cleanData(df):
    df = df.drop(columns=['Number', 'Td1', 'kd1', 'EC501', 'y1', 'Gender'])
    # df = df.drop(columns=['Number', 'Td1', 'kd1', 'EC501', 'y1'])
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

    df["IMC"] = df["Weight"] / (df["Height"] * df["Height"]) * 10000

    df = df.dropna()

    df = df[["Age", "Weight", "Height", "IMC",  "k", "E50", "Td", "y", "E0",]]
    return df

def linearReg(inputs_train, inputs_test, targets_train):
    model_LR = LinearRegression()
    model_LR.fit(inputs_train, targets_train)
    return model_LR.predict(inputs_test)

def randomForest(inputs_train, inputs_test, targets_train):
    model_RF = RandomForestRegressor()
    model_RF.fit(inputs_train, targets_train)
    return model_RF.predict(inputs_test)
    

target_keys = ["E0", "Td", "E50", "y", "k"]
input_keys = ["Age", "Weight", "Height", "IMC"]

def main():
    df = readData()

    inputs = df[input_keys]
    targets = df[target_keys]

    print(df.describe())

    # sns.heatmap(df.corr(), cmap="YlGnBu", annot= True)
    # plt.show()

    # IMC -> k
    # k -> E50
    # E50, k -> Td
    # Age, Weight, Height -> y
    # y -> E0

    k_inputs = ["IMC"]
    y_inputs = ["Age", "Weight", "Height"]
    E0_inputs = ["y"]
    E50_inputs = ["k"]
    Td_inputs = ["E50", "k"]

    scores_lr_divided = []
    scores_rf_divided = []
    scores_lr = []
    scores_rf = []

    

    for i in tqdm(range(20)):
        results_lr = pandas.DataFrame()
        results_rf = pandas.DataFrame()

        inputs_train, inputs_test, targets_train, targets_test = train_test_split(inputs, targets, test_size=0.4)
        
        results_lr["k"] = linearReg(inputs_train[k_inputs], inputs_test[k_inputs], targets_train["k"])
        results_lr["y"] = linearReg(inputs_train[y_inputs], inputs_test[y_inputs], targets_train["y"])
        results_lr["E0"] = linearReg(targets_train[E0_inputs], results_lr[E0_inputs], targets_train["E0"])
        results_lr["E50"] = linearReg(targets_train[E50_inputs], results_lr[E50_inputs], targets_train["E50"])
        results_lr["Td"] = linearReg(targets_train[Td_inputs], results_lr[Td_inputs], targets_train["Td"])

        results_rf["k"] = randomForest(inputs_train[k_inputs], inputs_test[k_inputs], targets_train["k"])
        results_rf["y"] = randomForest(inputs_train[y_inputs], inputs_test[y_inputs], targets_train["y"])
        results_rf["E0"] = randomForest(targets_train[E0_inputs], results_rf[E0_inputs], targets_train["E0"])
        results_rf["E50"] = randomForest(targets_train[E50_inputs], results_rf[E50_inputs], targets_train["E50"])
        results_rf["Td"] = randomForest(targets_train[Td_inputs], results_rf[Td_inputs], targets_train["Td"])

        scores_lr_divided.append(r2_score(targets_test[target_keys], results_lr[target_keys]))
        scores_rf_divided.append(r2_score(targets_test[target_keys], results_rf[target_keys]))


        results_lr_normal = linearReg(inputs_train, inputs_test, targets_train)
        results_rf_normal = randomForest(inputs_train, inputs_test, targets_train)

        scores_lr.append(r2_score(targets_test, results_lr_normal))
        scores_rf.append(r2_score(targets_test, results_rf_normal))

        if i == 0:
            plt.scatter(targets_test["k"], results_lr["k"], label="Staggered Linear Regression")
            plt.scatter(targets_test["k"], results_rf["k"], label="Staggered Random Forest")
            plt.scatter(targets_test["k"], results_lr_normal[:, 4], label="Normal Linear Regression")
            plt.scatter(targets_test["k"], results_rf_normal[:, 4], label="Normal Random Forest")
            plt.plot([0, 1], [0, 1], transform=plt.gca().transAxes, ls="--", c=".3")
            plt.legend()
            plt.title("k")
            plt.show()

            plt.scatter(targets_test["E50"], results_lr["E50"], label="Staggered Linear Regression")
            plt.scatter(targets_test["E50"], results_rf["E50"], label="Staggered Random Forest")
            plt.scatter(targets_test["E50"], results_lr_normal[:, 2], label="Normal Linear Regression")
            plt.scatter(targets_test["E50"], results_rf_normal[:, 2], label="Normal Random Forest")
            plt.plot([0, 1], [0, 1], transform=plt.gca().transAxes, ls="--", c=".3")
            plt.legend()
            plt.title("E50")
            plt.show()

            plt.scatter(targets_test["Td"], results_lr["Td"], label="Staggered Linear Regression")
            plt.scatter(targets_test["Td"], results_rf["Td"], label="Staggered Random Forest")
            plt.scatter(targets_test["Td"], results_lr_normal[:, 1], label="Normal Linear Regression")
            plt.scatter(targets_test["Td"], results_rf_normal[:, 1], label="Normal Random Forest")
            plt.plot([0, 1], [0, 1], transform=plt.gca().transAxes, ls="--", c=".3")
            plt.legend()
            plt.title("Td")
            plt.show()

            plt.scatter(targets_test["y"], results_lr["y"], label="Staggered Linear Regression")
            plt.scatter(targets_test["y"], results_rf["y"], label="Staggered Random Forest")
            plt.scatter(targets_test["y"], results_lr_normal[:, 3], label="Normal Linear Regression")
            plt.scatter(targets_test["y"], results_rf_normal[:, 3], label="Normal Random Forest")
            plt.plot([0, 1], [0, 1], transform=plt.gca().transAxes, ls="--", c=".3")
            plt.legend()
            plt.title("y")
            plt.show()

            plt.scatter(targets_test["E0"], results_lr["E0"], label="Staggered Linear Regression")
            plt.scatter(targets_test["E0"], results_rf["E0"], label="Staggered Random Forest")
            plt.scatter(targets_test["E0"], results_lr_normal[:, 0], label="Normal Linear Regression")
            plt.scatter(targets_test["E0"], results_rf_normal[:, 0], label="Normal Random Forest")
            plt.plot([0, 1], [0, 1], transform=plt.gca().transAxes, ls="--", c=".3")
            plt.legend()
            plt.title("E0")
            plt.show()

    print("Linear Regression: ", np.mean(scores_lr))
    print("Linear Regression Staggered: ", np.mean(scores_lr_divided))
    print("Random Forest: ", np.mean(scores_rf))
    print("Random Forest Staggered: ", np.mean(scores_rf_divided))


    # plt.plt(targets_test["k"], results_lr[:, 4], label="Random Forest")
    # plt.show()

    return

if __name__ == "__main__":
    main()