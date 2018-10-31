#!/bin/sh

if [ -z $JLOCAL ]; then
	echo "Environment variable JLOCAL not set, setting to $JLOCAL."
	export JLOCAL=/opt/local
fi

#
# Make sure libraf and vardb are done early
#
for repo in libraf ncplot
do
	cd $repo
	make install
	cd ..
done

#
# scons targets with the --prefix option
#
for repo in vardb ncpp oap nc_utils
do
	cd $repo
	scons --prefix=$JLOCAL
	scons --prefix=$JLOCAL install
	cd ..
done

#
# scons targets without the --prefix option
#
for repo in caledit
do
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
	cd $repo
	scons
	scons deploy
	cd ..
done
