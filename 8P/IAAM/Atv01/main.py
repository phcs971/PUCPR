from pyexpat import model
from sympy import E
import scipy.io
from sklearn.neighbors import KNeighborsClassifier 
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import r2_score

def main():
    inputs, targets = loadData()
    for n in [1,2,3]:
        inputs_train, inputs_test, targets_train, targets_test= shuffleData(inputs, targets)
        filePath = f"result{n}.csv";
        with open(filePath, 'w') as f:
            f.write("k;p;tp;tn;fp;fn\n")
        for p in [1,2]:
            for k in range(1, 100):
                model = knn(inputs_train, targets_train, k, p)
                (tp, tn, fp, fn) = knnPredict(model, inputs_test, targets_test)
                with open(filePath, 'a') as f:
                    f.write(f"{k};{p};{tp};{tn};{fp};{fn}\n")
    return

## Target = 0 -> Sem falha
## Target = 1 -> Com falha
def loadData():
    inputs = scipy.io.loadmat('Inputs.mat')["Inputs"]
    targets = scipy.io.loadmat('Targets.mat')["Targets"]
    fixed_targets = []
    for i in range(0, len(targets)):
        fixed_targets.append(targets[i][0])
    return (inputs, fixed_targets)

def shuffleData(inputs, targets):
    return train_test_split(inputs, targets, test_size=0.5)


def knn(inputs, targets, k, p=2):
    knn = KNeighborsClassifier(n_neighbors=k, p=p)
    knn.fit(inputs, targets)
    return knn

def knnPredict(knn, inputs, targets):
    result = knn.predict(inputs)
    tp,tn,fp,fn = calculateResults(result, targets)
    # print(f"\n\nAlgoritmo KNN com k = {knn.n_neighbors}")
    printResult(tp, tn, fp, fn, len(result))
    return (tp, tn, fp, fn)

def calculateResults(result, targets):
    tp,tn,fp,fn = (0,0,0,0)
    for i in range(0, len(result)):
        if result[i] != targets[i]:
            if result[i] == 0:
                fn += 1
            else:
                fp += 1
        else:
            if result[i] == 0:
                tn += 1
            else:
                tp += 1
    return (tp, tn, fp, fn)

def printResult(tp, tn, fp, fn, count):
    acc = (tp+tn)/count*100
    pre = tp/(tp+fp)*100
    rev = (tn)/(tn+fn)*100
    fm = (2*tp)/(2*tp+fp+fn)*100
    print(f"\nTestados: {count}")
    print(f"Acurácia: {round(acc, 2)} %")
    print(f"Precisão: {round(pre,2)} %")
    print(f"Revocação: {round(rev,2)} %")
    print(f"F-Measure: {round(fm,2)} %\n")
    print(f"|----------|-------|------------|")
    print(f"|          | Falso | Verdadeiro |")
    print(f"|----------|-------|------------|")
    print(f"| Positivo | {fp: >5} | {tp: >10} |")
    print(f"|----------|-------|------------|")
    print(f"| Negativo | {fn: >5} | {tn: >10} |")
    print(f"|----------|-------|------------|\n")
    return (acc, pre, rev, fm)

if __name__ == '__main__':
    main()