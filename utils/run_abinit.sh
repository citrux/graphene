#!/usr/bin/bash

prefix=$1
args=( "$@" )
psps=( "${args[@]:1}" )

echo -ne "\tPrepare..."

if [ ! -d $1 ]
then
    mkdir $prefix
fi

cp $prefix.in $prefix/
cd $prefix

cat > $prefix.files << EOF
$prefix.in
$prefix.out
$prefix.i
$prefix.o
$prefix
EOF

for i in "${psps[@]}"
do
cat >> $prefix.files << EOF
../$i    
EOF
done

echo -e "\tdone!"

echo -ne "\tCalculate $prefix..."
mpirun -np 4 abinit < $prefix.files > $prefix.log
echo -e "\tdone!"

# костыль
echo -ne "\tRemove large WFK files..."
rm *_WFK
echo -e "\tdone!"

cd ..

echo -ne "\tCompress results in $prefix.tag.gz..."
tar -zcf $prefix.tar.gz $prefix/
echo -e "\tdone!"

rm -rf $prefix
