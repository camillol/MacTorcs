How to install
--------------
- Download the Torcs 1.3.1 source package from SourceForge: [torcs-1.3.1.tar.bz2][1]
- Extract it, and put the MacTorcs folder inside the torcs-1.3.1 folder
- Open the Torcs project
- Build the "Apply patch" target to patch the source code for Mac support
- Build the "Torcs.app" target to build Torcs as a Mac application
- Enjoy!

About
-----
The Xcode project is based on previous work by [Stephen Hudson][2] and others, with vast changes to
streamline the build, leverage the existing Torcs makefiles for installing data, and reduce the size
of the final application bundle. The Mac-specific changes to the source code have been redone to
minimize impact (for instance, there is now no need to change the way learning and tmath headers are
included). As a result, this port should be easier to maintain and adapt to future versions of Torcs.

How to add a driver
-------------------
- Duplicate one of the existing driver targets (eg "tita.so") and rename it as appropriate
  (eg "newdriver.so")
- Double-click the new target, go to the "Build" tab and change the product name (eg "newdriver")
- Expand the new target and remove all files from the Compile Sources phase
- Add the new driver's source files to the project; choose to add them to the new target you just
  set up
- Add the new target to "All Dynamic Libraries" (drag it)
- Double-click on the "Install drivers" phase in the "Torcs.app" target and add your newdriver.so to
  the input files (follow the pattern).

TODO
----
- Save settings in the Preferences folder instead of modifying the application bundle.

Camillo Lugaresi


[1]: http://sourceforge.net/projects/torcs/files/all-in-one/1.3.1/torcs-1.3.1.tar.bz2/download
[2]: http://publish.uwo.ca/~shudson2/Home/Blog/7805725A-C647-41F0-B9C2-B91E8388D4EC.html