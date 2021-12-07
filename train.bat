:: Train model
FOR %%n IN (albi,
alex,
alexander,
alejandro,
aurelie,
benjamin,
brennan,
felipe,
harry,
hemal,
hugo,
max,
nathaniel,
owen,
ruby,
ruaridh,
sarah,
sophie,
vav,
yan,
sil,
) do (
  HInit -S lists/trainListBruce.txt -l %%n -L labels/train -M hmms -o %%n -T 1 lib/proto10x10States.txt
)
pause
:: -S specifies training data list file
:: -l vocabulary item to be trained
:: -L directory to find label files
:: -M directory to write initialised HMMs
:: -o name of output model (normally the same as the vocabulary item name)
:: -T level of trace reporting
