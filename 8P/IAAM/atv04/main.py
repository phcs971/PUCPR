import pandas as pd
from sklearn.svm import SVR
from sklearn.model_selection import train_test_split

def main():
    data = pd.read_csv('data.csv')
    inputs = data[['ts', 'vc']]
    targets = data[['hot', 'rad']]
    inputs_train, inputs_test, targets_train, targets_test = train_test_split(inputs,  targets, test_size=0.4)


if __name__ == '__main__':
    main()