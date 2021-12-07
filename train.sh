
names=(
	"albi"
	"alex"
	"alexander"
	"alejandro"
	"aurelie"
	"benjamin"
	"brennan"
	"felipe"
	"harry"
	"hemal"
	"hugo"
	"max"
	"nathaniel"
	"owen"
	"ruby"
	"ruaridh"
	"sarah"
	"sophie"
	"vav"
	"yan"
	"sil"
)

for name in ${names[@]};
do
	echo $name
	HInit -S lists/trainList.txt -l $name -L labels/train -M hmms -o $name -T 1 lib/15StateSize/proto15x16States.txt
done

