import os

def main(numStates):

    dirName = "{stateNum:d}StateSize".format(stateNum=numStates)

    if not os.path.isdir(dirName):
        os.mkdir(dirName)

    for i in range(150, 151):
        with open(dirName + "/proto{numStates:d}x{numVectors:d}States.txt".format(numStates=numStates, numVectors=i), 'w+') as file:
            file.write("<BeginHMM>\n")
            file.write("<NumStates> {numStates:d} <VecSize> {numVectors:d} <MFCC> <nullD> <diagC>\n".format(numStates=numStates, numVectors=i))

            for j in range(numStates - 2):
                file.write("<State> {stateNum:d} <NumMixes> 1\n".format(stateNum=(j+2)))
                file.write("<Mixture> 1 1.0\n")
                file.write("<Mean> {numVectors:d}\n".format(numVectors=i))
                file.write((" 0.0" * i) + "\n")
                file.write("<Variance> {numVectors:d}\n".format(numVectors=i))
                file.write((" 1.0" * i) + "\n")
                
            file.write("<TransP> {numStates:d}\n".format(numStates=numStates))
            file.write(" 0.000e+0 1.000e+0" + " 0.000e+0" * (numStates - 2) + "\n")

            for k in range(numStates - 3):
                file.write(" 0.000e+0" * (k + 1))
                file.write(" 6.000e-1 4.000e-1")
                file.write(" 0.000e+0" * ((numStates - 3) - k) + "\n")

            file.write(" 0.000e+0" * (numStates - 2) + " 9.000e-1 1.000e-1\n")
            file.write(" 0.000e+0" * numStates + "\n")

            file.write("<EndHMM>")

if __name__ == "__main__":
    for i in range(15,16):
        main(i)
