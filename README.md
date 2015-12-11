zc706_base
==========

ZC702 base system with ADI's ADV7511 support

This project is just a top level VHDL file, a constraints file and scripts to build the project.

It uses several IP blocks from the XilinxIP repository.
To build this project you must first download and build the XilinxIP repository.

After that then do the following.
1. Start Vivado (currently 2013.4)
2. cd <your dir>/zc702_base
3. source scripts/create_project.tcl
 
The project will then be created.  After it is done then build the bitstream using Vivado GUI.

