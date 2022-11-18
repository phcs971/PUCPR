from sklearn.model_selection import train_test_split
import pandas as pd

def generateDataFrame():
    files = ["test01", "test02", "test03", "test04", "test05", "test06", "test07", "test08", "test09", "test10"]
    df = pd.DataFrame()
    for file in files:
        df = df.append(pd.read_csv(file + ".csv"))
    df.columns = ["time", "delta_des", "delta_meas", "ofc_detected"]
    return df

def splitDataFrame(df):
    inputs = df[["delta_des", "delta_meas"]]
    outputs = df[["ofc_detected"]]
    return inputs, outputs

def trainTestSplit(inputs, outputs):
    x_train, x_test, y_train, y_test = train_test_split(inputs, outputs, test_size=0.4, random_state=42)
    return x_train, x_test, y_train, y_test

def main():
    df = generateDataFrame()
    inputs, outputs = splitDataFrame(df)
    x_train, x_test, y_train, y_test = trainTestSplit(inputs, outputs)
    return 0

if __name__ == "__main__":
    main()