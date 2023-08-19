# RAF_Nightly

RAF Nightly Build for Internal Servers.  This is checked out and used by Jenkins to build the projects for in-house use.  There should be targets for CentOS 7, 8, and 9.

build_all.sh is the script that is run.  It loops over projects that use make(1), scons(1).  Some of the targets require changing into specific directories before building.

There is a loop to loop over projects that have a **publish** target.  The publish target is to copy html documentation to the EOL webserver space.  This is generally /net/www/docs/raf/software and is set in the SConstruct files as $PUBLISH_PREFIX.
