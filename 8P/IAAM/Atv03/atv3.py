from calendar import month_name
from json import load
from modulefinder import IMPORT_NAME
from   import loadmat
import pandas as pd
from sklearn import tree
import cross_val_score



def main():
    inputs = pd.DataFrame(loadmat('Inputs-1.mat')['Inputs'])
    targets = pd.DataFrame(loadmat('Targets-1.mat')['Targets'])
    print(inputs)
    print(targets)
    
    #decision tree wiht the inputs and targets
    model = tree.DecisionTreeClassifier()
    model = model.fit(inputs, targets)
    print(model)

    #predict the inputs
    print(model.predict(inputs))
    print(targets)

    #cross validation
    scores = cross_val_score(model, inputs, targets, cv=5)
    print(scores)
    print("Accuracy: %0.2f (+/- %0.2f)" % (scores.mean(), scores.std() * 2))

    #decision tree wiht the inputs and targets
    model = tree.DecisionTreeClassifier()
    model = model.fit(inputs, targets)
    print(model)

    #predict the inputs
    print(model.predict(inputs))
    print(targets)

    #cross validation
    scores = cross_val_score(model, inputs, targets, cv=5)
    print(scores)
    print("Accuracy: %0.2f (+/- %0.2f)" % (scores.mean(), scores.std() * 2))

    #decision tree wiht the inputs and targets
    model = tree.DecisionTreeClassifier()
    model = model.fit(inputs, targets)
    print(model)

    #predict the inputs
    print(model.predict(inputs))
    print(targets)

    #cross validation
    scores = cross_val_score(model, inputs, targets, cv=5)
    print(scores)
    print("Accuracy: %0.2f (+/- %0.2f)" % (scores.mean(), scores.std() * 2))


if __name__ == '__main__':
    main()
    