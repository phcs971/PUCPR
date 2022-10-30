from cProfile import label
import pandas as pd
from sklearn.svm import SVR
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score
import matplotlib.pyplot as plt

def main():
    data = pd.read_csv('data.csv')
    inputs = data[['ts', 'vc', 'vm']]
    targets = data[['hot', 'rad']]
    print(data.describe())
    print("")

    inputs_test, inputs_train, targets_test, targets_train = train_test_split(inputs,  targets, test_size=0.4)

    svr_hot = SVR()
    svr_hot.fit(inputs_train, targets_train['hot'])
    hot_predict = svr_hot.predict(inputs_test)

    print("Face Quente")
    print("R2 =", svr_hot.score(inputs_test, targets_test['hot']))
    hot_error = hot_predict - targets_test['hot']
    print("Erro Médio Absoluto =", abs(hot_error).mean(),"°C")

    svr_rad = SVR()
    svr_rad.fit(inputs_train, targets_train['rad'])
    rad_predict = svr_rad.predict(inputs_test)

    print("Radiador")
    print("R2 =", svr_rad.score(inputs_test, targets_test['rad']))
    rad_error = rad_predict - targets_test['rad']
    print("Erro Médio Absoluto =", abs(rad_error).mean(),"°C")


    plt.scatter(targets_test["hot"], hot_predict, s=1)
    plt.plot([0, 1], [0, 1], transform=plt.gca().transAxes, ls="--", c=".3")
    plt.title("Face Quente")
    plt.show()

    plt.plot(inputs['ts'], targets["hot"], 'g', label="Temperatura da Face Quente")
    plt.plot(inputs_test["ts"], hot_predict, 'ro', markersize=0.5, label="Temperatura da Face Quente Prevista")
    plt.legend()
    plt.show()

    plt.scatter(targets_test["rad"], rad_predict, s=1)
    plt.plot([0, 1], [0, 1], transform=plt.gca().transAxes, ls="--", c=".3")
    plt.title("Radiador")
    plt.show()

    plt.plot(inputs['ts'], targets["rad"], 'g', label="Temperatura do Radiador")
    plt.plot(inputs_test["ts"], rad_predict, 'ro', markersize=0.5, label="Temperatura do Radiador Prevista")
    plt.legend()
    plt.show()
    
    # plt.plot(inputs['ts'], inputs["vm"], 'g', label="Tensão")
    # plt.legend()
    # plt.show()

    # plt.plot(inputs['ts'], inputs["vc"], 'g', label="Temperatura da Face Fria")
    # plt.legend()
    # plt.show()


if __name__ == '__main__':
    main()