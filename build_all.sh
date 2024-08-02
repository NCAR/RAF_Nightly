#!/bin/sh

alias scons='scons-3 -j 4'

if [ -z $JLOCAL ]; then
	echo "Environment variable JLOCAL not set, setting to $JLOCAL."
	export JLOCAL=/opt/local
fi

#
for repo in ncplot
do
	echo "\nBuilding $repo ...."
	cd $repo
	make install
	make publish
	cd ..
done

#
# scons targets 
#
for repo in vardb ncpp oap nc_utils caledit nimbus
do
	echo "\nBuilding $repo ...."
	cd $repo
	scons
	scons install
	cd ..
done

#
# Publish web pages.
#
for repo in ncpp oap nc_utils nimbus
do
	echo "\nPublishing $repo web pages ...."
	cd $repo
	scons publish
	cd ..
done

# This is two directories down, so doesn't 
cd kml_tools/acTrack2kml
scons install
cd ../..


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
