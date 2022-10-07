from  scipy.io import loadmat
import pandas as pd
from sklearn.neural_network import MLPClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix, classification_report

def main():
    inputs = pd.DataFrame(loadmat('Inputs-1.mat')['Inputs']).fillna(method="bfill")
    targets = pd.DataFrame(loadmat('Targets-1.mat')['Targets'])

    inputs_train, inputs_test, targets_train, targets_test = train_test_split(inputs, targets, test_size=0.5)
    
    # MLPClassifier
    mlp = MLPClassifier(hidden_layer_sizes=(50, 50, 50), max_iter=1000, verbose=True)
    mlp.fit(inputs_train, targets_train.values.ravel())
    predictions = mlp.predict(inputs_test)
    print("MLPClassifier: ", mlp.score(inputs_test, targets_test))

    print(confusion_matrix(targets_test, predictions))
    print(classification_report(targets_test, predictions))





if __name__ == '__main__':
    main()
    