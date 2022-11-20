from matplotlib import pyplot as plt
import pandas as pd

from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import confusion_matrix, classification_report


def generateDataFrame():
    files = ["test01", "test02", "test03", "test04", "test05",
             "test06", "test07", "test08", "test09", "test10"]
    df = pd.DataFrame()
    for file in files:
        df = df.append(pd.read_csv(file + ".csv"))
    df.columns = ["time", "delta_des", "delta_meas", "ofc_detected"]

    inputs = df[["delta_des", "delta_meas"]]
    outputs = df[["ofc_detected"]]

    inputs["delta_des_diff"] = inputs["delta_des"].diff()
    inputs["delta_meas_diff"] = inputs["delta_meas"].diff()

    inputs["residual"] = inputs["delta_des"] - inputs["delta_meas"]
    inputs["residual_diff"] = inputs["residual"].diff()

    inputs = inputs.fillna(0)

    return inputs, outputs


def trainTestSplit(inputs, outputs):
    x_train, x_test, y_train, y_test = train_test_split(
        inputs, outputs, test_size=0.4, random_state=42)
    return x_train, x_test, y_train, y_test



def predict(inputs, outputs):
    x_train, x_test, y_train, y_test = trainTestSplit(inputs, outputs)

    dtc = DecisionTreeClassifier()

    dtc.fit(x_train, y_train)

    y_predict = dtc.predict(x_test)

    print(confusion_matrix(y_test, y_predict))
    print("")
    print(classification_report(y_test, y_predict))

    fig = plt.figure()
    fig.patch.set_facecolor('#F8F6F2')
    plt.scatter(x_test["delta_des"], x_test["delta_meas"],
                c=y_predict, cmap="rainbow")
    plt.xlabel("delta_des")
    plt.ylabel("delta_meas")
    plt.show()


def main():
    inputs, outputs = generateDataFrame()

    print(inputs.describe())
    print("")
    print(outputs.value_counts())
    print("")

    predict(inputs, outputs)
    return 0


if __name__ == "__main__":
    main()
