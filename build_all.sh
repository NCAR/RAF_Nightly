#!/bin/sh

alias scons='scons-3 -j 4'

if [ -z $JLOCAL ]; then
	echo "Environment variable JLOCAL not set, setting to $JLOCAL."
	export JLOCAL=/opt/local
fi

#
# Make sure libraf and vardb are done early
#
for repo in ncplot
do
	echo "\nBuilding $repo ...."
	cd $repo
	make install
	cd ..
done

#
# scons targets with the --prefix option
#
for repo in libraf vardb ncpp oap nc_utils
do
	echo "\nBuilding $repo ...."
	cd $repo
	scons --prefix=$JLOCAL
	scons --prefix=$JLOCAL install
	cd ..
done

#
# scons targets without the --prefix option
#
for repo in caledit nimbus
do
	echo "\nBuilding $repo ...."
	cd $repo
	scons
	scons install
	cd ..
done

#
# scons with 'deploy' target
#
for repo in aeros
do
	echo "\nBuilding $repo ...."
	cd $repo/source
	scons
	scons deploy
	cd ../..
done
