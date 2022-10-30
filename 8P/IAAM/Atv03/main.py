from scipy.io import loadmat
import pandas as pd
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import train_test_split
from sklearn.model_selection import GridSearchCV
from sklearn.metrics import confusion_matrix, classification_report


def main():
    inputs = pd.DataFrame(loadmat('Inputs-1.mat')
                          ['Inputs']).fillna(method="bfill")
    targets = pd.DataFrame(loadmat('Targets-1.mat')['Targets'])


    inputs.columns = ["Temp", "ClO2_1", "pH", "Redox",
                      "Conductivity", "Turbidity", "ClO2_2", "FR_1", "FR_2"]

    print(inputs.describe())
    print(targets.value_counts())

    # get inputs derivatives
    inputs['dTemp'] = inputs["Temp"].diff()
    inputs['dClO2_1'] = inputs["ClO2_1"].diff()
    inputs['dpH'] = inputs["pH"].diff()
    inputs['dRedox'] = inputs["Redox"].diff()
    inputs['dConductivity'] = inputs["Conductivity"].diff()
    inputs['dTurbidity'] = inputs["Turbidity"].diff()
    inputs['dClO2_2'] = inputs["ClO2_2"].diff()
    inputs['dFR_1'] = inputs["FR_1"].diff()
    inputs['dFR_2'] = inputs["FR_2"].diff()
    inputs = inputs.fillna(0)

    print(inputs[[
        'dTemp',
        'dClO2_1',
        'dpH',
        'dRedox',
        'dConductivity',
        'dTurbidity',
        'dClO2_2',
        'dFR_1',
        'dFR_2',
    ]].describe())
    # print(inputs)

    inputs_train, inputs_test, targets_train, targets_test = train_test_split(
        inputs, targets, test_size=0.5, random_state=11)

    # Grid Search

    # mlp = MLPClassifier(max_iter=1000, verbose=True)
    # parameter_space = {
    #     'hidden_layer_sizes': [(10,10,10), (20,20,20), (30,30,30), (40,40,40), (50,50,50), (60,60,60), (70,70,70), (80,80,80), (90,90,90), (100,100,100)],
    #     'activation': ['tanh', 'relu'],
    #     'solver': ['sgd', 'adam'],
    #     'alpha': [0.0001, 0.001, 0.01, 0.05],
    #     'learning_rate': ['constant','adaptive'],
    # }

    # clf = GridSearchCV(mlp, parameter_space, n_jobs=-1, cv=3)
    # clf.fit(inputs_train, targets_train)

    # Best paramete set
    # print('Best parameters found:\n', clf.best_params_)
    #  {'activation': 'relu', 'alpha': 0.0001, 'hidden_layer_sizes': (40, 40, 40), 'learning_rate': 'constant', 'solver': 'adam'}

    # MLPClassifier
    # for i in [30, 40, 50, 60]:
    #     for j in [0.01, 0.005, 0.001]:
    #         mlp = MLPClassifier(hidden_layer_sizes=(i, i, i), alpha=j, max_iter=1000, verbose=False, random_state=11)
    #         mlp.fit(inputs_train, targets_train.values.ravel())
    #         predictions = mlp.predict(inputs_test)
    #         print(f"MLPClassifier:\nHidden Layers: {i}\nalpha: {j}\nScore:", mlp.score(inputs_test, targets_test))

    #         print(confusion_matrix(targets_test, predictions))
    #         print(classification_report(targets_test, predictions))

    # mlp = MLPClassifier(
    #     hidden_layer_sizes=(30, 30, 30),
    #     alpha=0.001,
    #     max_iter=1000,
    #     verbose=False,
    #     random_state=11
    # )
    # mlp.fit(inputs_train, targets_train.values.ravel())
    # predictions = mlp.predict(inputs_test)
    # print(f"MLPClassifier:", mlp.score(inputs_test, targets_test))

    # print(confusion_matrix(targets_test, predictions))
    # print(classification_report(targets_test, predictions))


if __name__ == '__main__':
    main()
