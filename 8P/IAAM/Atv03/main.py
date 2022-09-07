from json import load
from  scipy.io import loadmat
import pandas as pd

def main():
    inputs = pd.DataFrame(loadmat('Inputs-1.mat')['Inputs'])
    targets = pd.DataFrame(loadmat('Targets-1.mat')['Targets'])
    print(inputs)
    print(targets)

if __name__ == "__main__":
    main()