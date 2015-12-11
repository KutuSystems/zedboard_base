
################################################################
# This is a generated script based on design: system_top
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_top_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z020clg484-1
#    set_property BOARD_PART em.avnet.com:zed:part0:1.3 [current_project]

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name system_top

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES:
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: Zynq_1
proc create_hier_cell_Zynq_1 { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_Zynq_1() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR
  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M03_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M04_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  # Create pins
  create_bd_pin -dir O clk_100mhz
  create_bd_pin -dir O clk_142mhz
  create_bd_pin -dir O clk_200mhz
  create_bd_pin -dir I hdmi_int
  create_bd_pin -dir O -from 0 -to 0 s_axi_aresetn
  create_bd_pin -dir O spdif_tx_o

  # Create instance: axi4_gp0, and set properties
  set axi4_gp0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi4_gp0 ]
  set_property -dict [ list \
CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
CONFIG.M06_HAS_REGSLICE {1} \
CONFIG.NUM_MI {5} \
CONFIG.NUM_SI {1} \
 ] $axi4_gp0

  # Create instance: axi4_hp0, and set properties
  set axi4_hp0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi4_hp0 ]
  set_property -dict [ list \
CONFIG.ENABLE_ADVANCED_OPTIONS {1} \
CONFIG.M00_HAS_DATA_FIFO {2} \
CONFIG.M00_HAS_REGSLICE {1} \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {1} \
CONFIG.S00_HAS_DATA_FIFO {2} \
CONFIG.S00_HAS_REGSLICE {1} \
CONFIG.S01_HAS_DATA_FIFO {2} \
CONFIG.S01_HAS_REGSLICE {1} \
CONFIG.STRATEGY {0} \
 ] $axi4_hp0

  # Create instance: axi_spdif_tx_core, and set properties
  set axi_spdif_tx_core [ create_bd_cell -type ip -vlnv kutu.com.au:kutu:axi_spdif_tx:1.0 axi_spdif_tx_core ]

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.2 clk_wiz_0 ]
  set_property -dict [ list \
CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {12.288} \
CONFIG.PRIM_SOURCE {No_buffer} \
CONFIG.RESET_BOARD_INTERFACE {Custom} \
CONFIG.RESET_TYPE {ACTIVE_LOW} \
CONFIG.USE_BOARD_FLOW {false} \
CONFIG.USE_DYN_PHASE_SHIFT {false} \
CONFIG.USE_LOCKED {false} \
CONFIG.USE_PHASE_ALIGNMENT {true} \
CONFIG.USE_SPREAD_SPECTRUM {false} \
 ] $clk_wiz_0

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: proc_sys_reset_1, and set properties
  set proc_sys_reset_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_1 ]

  # Create instance: processing_system7_1, and set properties
  set processing_system7_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_1 ]
  set_property -dict [ list \
CONFIG.PCW_CAN0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {100 Mbps} \
CONFIG.PCW_ENET0_RESET_IO {MIO 47} \
CONFIG.PCW_EN_CLK0_PORT {1} \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_EN_CLK2_PORT {1} \
CONFIG.PCW_EN_CLK3_PORT {0} \
CONFIG.PCW_EN_CLKTRIG0_PORT {0} \
CONFIG.PCW_EN_EMIO_GPIO {0} \
CONFIG.PCW_EN_RST0_PORT {1} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {142.86} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {0} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_I2C0_I2C0_IO {MIO 50 .. 51} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_I2C0_RESET_ENABLE {1} \
CONFIG.PCW_I2C0_RESET_IO {MIO 46} \
CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_IRQ_F2P_INTR {1} \
CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_SD0_GRP_POW_ENABLE {0} \
CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {25} \
CONFIG.PCW_USE_DMA0 {1} \
CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.PCW_USE_M_AXI_GP0 {1} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
CONFIG.PCW_USE_S_AXI_HP1 {0} \
CONFIG.PCW_USE_S_AXI_HP2 {0} \
CONFIG.PCW_WDT_PERIPHERAL_ENABLE {0} \
CONFIG.preset {ZC706} \
 ] $processing_system7_1

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
CONFIG.IN0_WIDTH {1} \
CONFIG.NUM_PORTS {2} \
 ] $xlconcat_0

  # Create instance: xlconstant_gnd_0, and set properties
  set xlconstant_gnd_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_gnd_0 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $xlconstant_gnd_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axi4_hp0/S00_AXI]
  connect_bd_intf_net -intf_net axi4_gp0_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi4_gp0/M00_AXI]
  connect_bd_intf_net -intf_net axi4_gp0_M01_AXI [get_bd_intf_pins M01_AXI] [get_bd_intf_pins axi4_gp0/M01_AXI]
  connect_bd_intf_net -intf_net axi4_gp0_M02_AXI [get_bd_intf_pins axi4_gp0/M02_AXI] [get_bd_intf_pins axi_spdif_tx_core/S_AXI]
  connect_bd_intf_net -intf_net axi4_gp0_M03_AXI [get_bd_intf_pins M03_AXI] [get_bd_intf_pins axi4_gp0/M03_AXI]
  connect_bd_intf_net -intf_net axi4_gp0_M04_AXI [get_bd_intf_pins M04_AXI] [get_bd_intf_pins axi4_gp0/M04_AXI]
  connect_bd_intf_net -intf_net axi4_hp0_M00_AXI [get_bd_intf_pins axi4_hp0/M00_AXI] [get_bd_intf_pins processing_system7_1/S_AXI_HP0]
  connect_bd_intf_net -intf_net processing_system7_1_ddr [get_bd_intf_pins DDR] [get_bd_intf_pins processing_system7_1/DDR]
  connect_bd_intf_net -intf_net processing_system7_1_fixed_io [get_bd_intf_pins FIXED_IO] [get_bd_intf_pins processing_system7_1/FIXED_IO]
  connect_bd_intf_net -intf_net s00_axi_1 [get_bd_intf_pins axi4_gp0/S00_AXI] [get_bd_intf_pins processing_system7_1/M_AXI_GP0]

  # Create port connections
  connect_bd_net -net axi_spdif_tx_0_DMA_REQ_DAREADY [get_bd_pins axi_spdif_tx_core/DMA_REQ_DAREADY] [get_bd_pins processing_system7_1/DMA0_DAREADY]
  connect_bd_net -net axi_spdif_tx_0_DMA_REQ_DRLAST [get_bd_pins axi_spdif_tx_core/DMA_REQ_DRLAST] [get_bd_pins processing_system7_1/DMA0_DRLAST]
  connect_bd_net -net axi_spdif_tx_0_DMA_REQ_DRTYPE [get_bd_pins axi_spdif_tx_core/DMA_REQ_DRTYPE] [get_bd_pins processing_system7_1/DMA0_DRTYPE]
  connect_bd_net -net axi_spdif_tx_0_DMA_REQ_DRVALID [get_bd_pins axi_spdif_tx_core/DMA_REQ_DRVALID] [get_bd_pins processing_system7_1/DMA0_DRVALID]
  connect_bd_net -net axi_spdif_tx_0_spdif_tx_o [get_bd_pins spdif_tx_o] [get_bd_pins axi_spdif_tx_core/spdif_tx_o]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins axi_spdif_tx_core/spdif_data_clk] [get_bd_pins clk_wiz_0/clk_out1]
  connect_bd_net -net logicvc_int_1 [get_bd_pins hdmi_int] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins axi4_hp0/ARESETN] [get_bd_pins axi4_hp0/M00_ARESETN] [get_bd_pins axi4_hp0/S00_ARESETN] [get_bd_pins proc_sys_reset_0/interconnect_aresetn]
  connect_bd_net -net proc_sys_reset_1_interconnect_aresetn [get_bd_pins s_axi_aresetn] [get_bd_pins axi4_gp0/ARESETN] [get_bd_pins axi4_gp0/M00_ARESETN] [get_bd_pins axi4_gp0/M01_ARESETN] [get_bd_pins axi4_gp0/M02_ARESETN] [get_bd_pins axi4_gp0/M03_ARESETN] [get_bd_pins axi4_gp0/M04_ARESETN] [get_bd_pins axi4_gp0/S00_ARESETN] [get_bd_pins axi_spdif_tx_core/S_AXI_ARESETN] [get_bd_pins proc_sys_reset_1/interconnect_aresetn]
  connect_bd_net -net proc_sys_reset_1_peripheral_aresetn [get_bd_pins axi_spdif_tx_core/DMA_REQ_RSTN] [get_bd_pins clk_wiz_0/resetn] [get_bd_pins proc_sys_reset_1/peripheral_aresetn]
  connect_bd_net -net processing_system7_1_DMA0_DATYPE [get_bd_pins axi_spdif_tx_core/DMA_REQ_DATYPE] [get_bd_pins processing_system7_1/DMA0_DATYPE]
  connect_bd_net -net processing_system7_1_DMA0_DAVALID [get_bd_pins axi_spdif_tx_core/DMA_REQ_DAVALID] [get_bd_pins processing_system7_1/DMA0_DAVALID]
  connect_bd_net -net processing_system7_1_DMA0_DRREADY [get_bd_pins axi_spdif_tx_core/DMA_REQ_DRREADY] [get_bd_pins processing_system7_1/DMA0_DRREADY]
  connect_bd_net -net processing_system7_1_FCLK_CLK0 [get_bd_pins clk_100mhz] [get_bd_pins axi4_gp0/ACLK] [get_bd_pins axi4_gp0/M00_ACLK] [get_bd_pins axi4_gp0/M01_ACLK] [get_bd_pins axi4_gp0/M02_ACLK] [get_bd_pins axi4_gp0/M03_ACLK] [get_bd_pins axi4_gp0/M04_ACLK] [get_bd_pins axi4_gp0/S00_ACLK] [get_bd_pins axi_spdif_tx_core/DMA_REQ_ACLK] [get_bd_pins axi_spdif_tx_core/S_AXI_ACLK] [get_bd_pins proc_sys_reset_1/slowest_sync_clk] [get_bd_pins processing_system7_1/DMA0_ACLK] [get_bd_pins processing_system7_1/FCLK_CLK0] [get_bd_pins processing_system7_1/M_AXI_GP0_ACLK]
  connect_bd_net -net processing_system7_1_FCLK_CLK1 [get_bd_pins clk_142mhz] [get_bd_pins axi4_hp0/ACLK] [get_bd_pins axi4_hp0/M00_ACLK] [get_bd_pins axi4_hp0/S00_ACLK] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins processing_system7_1/FCLK_CLK1] [get_bd_pins processing_system7_1/S_AXI_HP0_ACLK]
  connect_bd_net -net processing_system7_1_FCLK_CLK2 [get_bd_pins clk_200mhz] [get_bd_pins clk_wiz_0/clk_in1] [get_bd_pins processing_system7_1/FCLK_CLK2]
  connect_bd_net -net processing_system7_1_FCLK_RESET0_N [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins proc_sys_reset_1/ext_reset_in] [get_bd_pins processing_system7_1/FCLK_RESET0_N]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins processing_system7_1/IRQ_F2P] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconstant_gnd_0_dout [get_bd_pins xlconcat_0/In1] [get_bd_pins xlconstant_gnd_0/dout]

  # Perform GUI Layout
  regenerate_bd_layout -hierarchy [get_bd_cells /Zynq_1] -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.8
#  -string -flagsOSRD
preplace port DDR -pg 1 -y 120 -defaultsOSRD
preplace port clk_200mhz -pg 1 -y 790 -defaultsOSRD
preplace port S00_AXI -pg 1 -y 550 -defaultsOSRD
preplace port hdmi_int -pg 1 -y 750 -defaultsOSRD
preplace port M01_AXI -pg 1 -y 490 -defaultsOSRD
preplace port M04_AXI -pg 1 -y 550 -defaultsOSRD
preplace port M03_AXI -pg 1 -y 530 -defaultsOSRD
preplace port clk_100mhz -pg 1 -y 430 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 750 -defaultsOSRD
preplace port spdif_tx_o -pg 1 -y 360 -defaultsOSRD
preplace port clk_142mhz -pg 1 -y 770 -defaultsOSRD
preplace port M00_AXI -pg 1 -y 470 -defaultsOSRD
preplace portBus s_axi_aresetn -pg 1 -y 450 -defaultsOSRD
preplace inst processing_system7_1 -pg 1 -lvl 3 -y 590 -defaultsOSRD
preplace inst xlconstant_gnd_0 -pg 1 -lvl 1 -y 800 -defaultsOSRD
preplace inst proc_sys_reset_0 -pg 1 -lvl 2 -y 340 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 2 -y 790 -defaultsOSRD
preplace inst proc_sys_reset_1 -pg 1 -lvl 4 -y 210 -defaultsOSRD
preplace inst axi4_gp0 -pg 1 -lvl 4 -y 510 -defaultsOSRD
preplace inst clk_wiz_0 -pg 1 -lvl 4 -y 60 -defaultsOSRD
preplace inst axi_spdif_tx_core -pg 1 -lvl 5 -y 310 -defaultsOSRD
preplace inst axi4_hp0 -pg 1 -lvl 2 -y 610 -defaultsOSRD
preplace netloc processing_system7_1_ddr 1 3 3 NJ 310 NJ 120 NJ
preplace netloc processing_system7_1_DMA0_DRREADY 1 2 4 640 810 NJ 810 NJ 810 2080
preplace netloc processing_system7_1_DMA0_DATYPE 1 3 2 NJ 730 NJ
preplace netloc axi_spdif_tx_0_DMA_REQ_DRLAST 1 2 4 660 790 NJ 790 NJ 790 2060
preplace netloc xlconstant_gnd_0_dout 1 1 1 NJ
preplace netloc processing_system7_1_FCLK_RESET0_N 1 1 3 220 430 NJ 400 1180
preplace netloc processing_system7_1_DMA0_DAVALID 1 3 2 NJ 720 NJ
preplace netloc axi4_gp0_M03_AXI 1 4 2 NJ 530 NJ
preplace netloc processing_system7_1_FCLK_CLK0 1 2 4 680 780 1170 760 1650 460 NJ
preplace netloc logicvc_int_1 1 0 2 NJ 750 NJ
preplace netloc axi_spdif_tx_0_DMA_REQ_DRTYPE 1 2 4 670 800 NJ 780 NJ 760 2070
preplace netloc processing_system7_1_FCLK_CLK1 1 1 5 210 850 620 820 1140 770 NJ 770 NJ
preplace netloc proc_sys_reset_1_peripheral_aresetn 1 3 2 1220 300 1600
preplace netloc processing_system7_1_FCLK_CLK2 1 3 3 1190 800 NJ 800 NJ
preplace netloc axi_spdif_tx_0_spdif_tx_o 1 5 1 NJ
preplace netloc processing_system7_1_fixed_io 1 3 3 NJ 750 NJ 750 NJ
preplace netloc proc_sys_reset_0_interconnect_aresetn 1 1 2 220 730 610
preplace netloc axi_spdif_tx_0_DMA_REQ_DRVALID 1 2 4 650 120 NJ 120 NJ 110 2060
preplace netloc s00_axi_1 1 3 1 1140
preplace netloc axi4_gp0_M00_AXI 1 4 2 NJ 470 NJ
preplace netloc xlconcat_0_dout 1 2 1 630
preplace netloc clk_wiz_0_clk_out1 1 4 1 1630
preplace netloc S00_AXI_2 1 0 2 NJ 550 NJ
preplace netloc axi_spdif_tx_0_DMA_REQ_DAREADY 1 3 2 NJ 710 NJ
preplace netloc axi4_gp0_M02_AXI 1 4 1 1590
preplace netloc proc_sys_reset_1_interconnect_aresetn 1 3 3 1220 740 1580 450 NJ
preplace netloc axi4_hp0_M00_AXI 1 2 1 N
preplace netloc axi4_gp0_M04_AXI 1 4 2 NJ 550 NJ
preplace netloc axi4_gp0_M01_AXI 1 4 2 NJ 490 NJ
levelinfo -pg 1 -80 110 440 910 1390 1860 2110 -top 0 -bot 1020
",
}

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: Video_Display
proc create_hier_cell_Video_Display { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_Video_Display() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_MM2S
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_CLKGEN
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_HDMI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_IIC
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_LITE_VDMA

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 axi_resetn
  create_bd_pin -dir I -type clk clk_100mhz
  create_bd_pin -dir I clk_142mhz
  create_bd_pin -dir I -type clk clk_200mhz
  create_bd_pin -dir O hdmi_int
  create_bd_pin -dir O hdmio_clk
  create_bd_pin -dir O -from 15 -to 0 hdmio_data
  create_bd_pin -dir O hdmio_de
  create_bd_pin -dir O hdmio_hsync
  create_bd_pin -dir O hdmio_vsync

  # Create instance: axi_hdmi_clkgen, and set properties
  set axi_hdmi_clkgen [ create_bd_cell -type ip -vlnv kutu.com.au:kutu:axi_clkgen:1.0 axi_hdmi_clkgen ]

  # Create instance: axi_hdmi_core, and set properties
  set axi_hdmi_core [ create_bd_cell -type ip -vlnv kutu.com.au:kutu:axi_hdmi_tx:1.0 axi_hdmi_core ]

  # Create instance: axi_hdmi_dma, and set properties
  set axi_hdmi_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_hdmi_dma ]
  set_property -dict [ list \
CONFIG.c_include_mm2s_dre {0} \
CONFIG.c_include_s2mm {0} \
CONFIG.c_m_axis_mm2s_tdata_width {64} \
CONFIG.c_mm2s_genlock_mode {0} \
CONFIG.c_use_mm2s_fsync {1} \
 ] $axi_hdmi_dma

  # Create instance: axi_iic_main, and set properties
  set axi_iic_main [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 axi_iic_main ]
  set_property -dict [ list \
CONFIG.C_GPO_WIDTH {1} \
CONFIG.IIC_FREQ_KHZ {100} \
 ] $axi_iic_main

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins IIC] [get_bd_intf_pins axi_iic_main/IIC]
  connect_bd_intf_net -intf_net S_AXI2_1 [get_bd_intf_pins S_AXI_CLKGEN] [get_bd_intf_pins axi_hdmi_clkgen/s_axi]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI_IIC] [get_bd_intf_pins axi_iic_main/S_AXI]
  connect_bd_intf_net -intf_net S_AXI_HDMI_1 [get_bd_intf_pins S_AXI_HDMI] [get_bd_intf_pins axi_hdmi_core/s_axi]
  connect_bd_intf_net -intf_net S_AXI_LITE_1 [get_bd_intf_pins S_AXI_LITE_VDMA] [get_bd_intf_pins axi_hdmi_dma/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_hdmi_core/m_axis_mm2s] [get_bd_intf_pins axi_hdmi_dma/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_MM2S [get_bd_intf_pins M_AXI_MM2S] [get_bd_intf_pins axi_hdmi_dma/M_AXI_MM2S]

  # Create port connections
  connect_bd_net -net axi_clkgen_0_clk_0 [get_bd_pins axi_hdmi_clkgen/clk_0] [get_bd_pins axi_hdmi_core/hdmi_clk]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_16_data [get_bd_pins hdmio_data] [get_bd_pins axi_hdmi_core/hdmi_16_data]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_16_data_e [get_bd_pins hdmio_de] [get_bd_pins axi_hdmi_core/hdmi_16_data_e]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_16_hsync [get_bd_pins hdmio_hsync] [get_bd_pins axi_hdmi_core/hdmi_16_hsync]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_16_vsync [get_bd_pins hdmio_vsync] [get_bd_pins axi_hdmi_core/hdmi_16_vsync]
  connect_bd_net -net axi_hdmi_tx_0_hdmi_out_clk [get_bd_pins hdmio_clk] [get_bd_pins axi_hdmi_core/hdmi_out_clk]
  connect_bd_net -net axi_hdmi_tx_0_m_axis_mm2s_fsync [get_bd_pins axi_hdmi_core/m_axis_mm2s_fsync] [get_bd_pins axi_hdmi_core/m_axis_mm2s_fsync_ret] [get_bd_pins axi_hdmi_dma/mm2s_fsync]
  connect_bd_net -net axi_resetn_1 [get_bd_pins axi_resetn] [get_bd_pins axi_hdmi_clkgen/s_axi_aresetn] [get_bd_pins axi_hdmi_core/s_axi_aresetn] [get_bd_pins axi_hdmi_dma/axi_resetn] [get_bd_pins axi_iic_main/s_axi_aresetn]
  connect_bd_net -net axi_vdma_0_mm2s_introut [get_bd_pins hdmi_int] [get_bd_pins axi_hdmi_dma/mm2s_introut]
  connect_bd_net -net clk_100mhz_1 [get_bd_pins clk_100mhz] [get_bd_pins axi_hdmi_clkgen/drp_clk] [get_bd_pins axi_hdmi_clkgen/s_axi_aclk] [get_bd_pins axi_hdmi_core/s_axi_aclk] [get_bd_pins axi_hdmi_dma/s_axi_lite_aclk] [get_bd_pins axi_iic_main/s_axi_aclk]
  connect_bd_net -net clk_142mhz_1 [get_bd_pins clk_142mhz] [get_bd_pins axi_hdmi_core/m_axis_mm2s_clk] [get_bd_pins axi_hdmi_dma/m_axi_mm2s_aclk] [get_bd_pins axi_hdmi_dma/m_axis_mm2s_aclk]
  connect_bd_net -net clk_200mhz_1 [get_bd_pins clk_200mhz] [get_bd_pins axi_hdmi_clkgen/clk]

  # Perform GUI Layout
  regenerate_bd_layout -hierarchy [get_bd_cells /Video_Display] -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.8
#  -string -flagsOSRD
preplace port hdmio_clk -pg 1 -y 350 -defaultsOSRD
preplace port clk_200mhz -pg 1 -y 20 -defaultsOSRD
preplace port hdmio_de -pg 1 -y 410 -defaultsOSRD
preplace port hdmi_int -pg 1 -y 310 -defaultsOSRD
preplace port M_AXI_MM2S -pg 1 -y 290 -defaultsOSRD
preplace port S_AXI_LITE_VDMA -pg 1 -y 270 -defaultsOSRD
preplace port hdmio_vsync -pg 1 -y 390 -defaultsOSRD
preplace port S_AXI_HDMI -pg 1 -y 430 -defaultsOSRD
preplace port hdmio_hsync -pg 1 -y 370 -defaultsOSRD
preplace port S_AXI_IIC -pg 1 -y 40 -defaultsOSRD
preplace port IIC -pg 1 -y 40 -defaultsOSRD
preplace port clk_100mhz -pg 1 -y 290 -defaultsOSRD
preplace port clk_142mhz -pg 1 -y 310 -defaultsOSRD
preplace port S_AXI_CLKGEN -pg 1 -y 160 -defaultsOSRD
preplace portBus axi_resetn -pg 1 -y 350 -defaultsOSRD
preplace portBus hdmio_data -pg 1 -y 430 -defaultsOSRD
preplace inst axi_hdmi_clkgen -pg 1 -lvl 2 -y 200 -defaultsOSRD
preplace inst axi_hdmi_core -pg 1 -lvl 2 -y 490 -defaultsOSRD
preplace inst axi_iic_main -pg 1 -lvl 2 -y 40 -defaultsOSRD
preplace inst axi_hdmi_dma -pg 1 -lvl 1 -y 320 -defaultsOSRD
preplace netloc S_AXI_LITE_1 1 0 1 NJ
preplace netloc S_AXI_1 1 0 2 NJ 20 NJ
preplace netloc Conn1 1 2 1 NJ
preplace netloc S_AXI2_1 1 0 2 NJ 160 NJ
preplace netloc axi_hdmi_tx_0_hdmi_out_clk 1 2 1 NJ
preplace netloc S_AXI_HDMI_1 1 0 2 NJ 430 NJ
preplace netloc axi_hdmi_tx_0_hdmi_16_hsync 1 2 1 NJ
preplace netloc axi_vdma_0_M_AXI_MM2S 1 1 2 NJ 290 NJ
preplace netloc clk_200mhz_1 1 0 2 NJ 30 370
preplace netloc clk_142mhz_1 1 0 2 20 490 NJ
preplace netloc axi_vdma_0_M_AXIS_MM2S 1 1 1 370
preplace netloc clk_100mhz_1 1 0 2 10 220 390
preplace netloc axi_hdmi_tx_0_m_axis_mm2s_fsync 1 0 3 30 510 370 680 780
preplace netloc axi_hdmi_tx_0_hdmi_16_vsync 1 2 1 NJ
preplace netloc axi_clkgen_0_clk_0 1 1 2 410 110 780
preplace netloc axi_vdma_0_mm2s_introut 1 1 2 NJ 300 NJ
preplace netloc axi_hdmi_tx_0_hdmi_16_data_e 1 2 1 NJ
preplace netloc axi_resetn_1 1 0 2 10 420 400
preplace netloc axi_hdmi_tx_0_hdmi_16_data 1 2 1 NJ
levelinfo -pg 1 -10 200 600 800 -top -30 -bot 690
",
}

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
  set IIC [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC ]

  # Create ports
  set hdmio_clk [ create_bd_port -dir O hdmio_clk ]
  set hdmio_data [ create_bd_port -dir O -from 15 -to 0 hdmio_data ]
  set hdmio_de [ create_bd_port -dir O hdmio_de ]
  set hdmio_hsync [ create_bd_port -dir O hdmio_hsync ]
  set hdmio_vsync [ create_bd_port -dir O hdmio_vsync ]
  set spdif_tx [ create_bd_port -dir O spdif_tx ]

  # Create instance: Video_Display
  create_hier_cell_Video_Display [current_bd_instance .] Video_Display

  # Create instance: Zynq_1
  create_hier_cell_Zynq_1 [current_bd_instance .] Zynq_1

  # Create interface connections
  connect_bd_intf_net -intf_net Video_Display_IIC [get_bd_intf_ports IIC] [get_bd_intf_pins Video_Display/IIC]
  connect_bd_intf_net -intf_net Zynq_1_M00_AXI1 [get_bd_intf_pins Video_Display/S_AXI_IIC] [get_bd_intf_pins Zynq_1/M00_AXI]
  connect_bd_intf_net -intf_net Zynq_1_M01_AXI [get_bd_intf_pins Video_Display/S_AXI_HDMI] [get_bd_intf_pins Zynq_1/M01_AXI]
  connect_bd_intf_net -intf_net Zynq_1_M03_AXI [get_bd_intf_pins Video_Display/S_AXI_CLKGEN] [get_bd_intf_pins Zynq_1/M03_AXI]
  connect_bd_intf_net -intf_net Zynq_1_M04_AXI [get_bd_intf_pins Video_Display/S_AXI_LITE_VDMA] [get_bd_intf_pins Zynq_1/M04_AXI]
  connect_bd_intf_net -intf_net processing_system7_1_ddr [get_bd_intf_ports DDR] [get_bd_intf_pins Zynq_1/DDR]
  connect_bd_intf_net -intf_net processing_system7_1_fixed_io [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins Zynq_1/FIXED_IO]
  connect_bd_intf_net -intf_net s01_axi_1 [get_bd_intf_pins Video_Display/M_AXI_MM2S] [get_bd_intf_pins Zynq_1/S00_AXI]

  # Create port connections
  connect_bd_net -net Video_Display_hdmi_data [get_bd_ports hdmio_data] [get_bd_pins Video_Display/hdmio_data]
  connect_bd_net -net Video_Display_hdmi_int [get_bd_pins Video_Display/hdmi_int] [get_bd_pins Zynq_1/hdmi_int]
  connect_bd_net -net Video_Display_hdmio_clk [get_bd_ports hdmio_clk] [get_bd_pins Video_Display/hdmio_clk]
  connect_bd_net -net Video_Display_hdmio_de [get_bd_ports hdmio_de] [get_bd_pins Video_Display/hdmio_de]
  connect_bd_net -net Video_Display_hdmio_hsync [get_bd_ports hdmio_hsync] [get_bd_pins Video_Display/hdmio_hsync]
  connect_bd_net -net Video_Display_hdmio_vsync [get_bd_ports hdmio_vsync] [get_bd_pins Video_Display/hdmio_vsync]
  connect_bd_net -net Zynq_1_clk_100mhz [get_bd_pins Video_Display/clk_100mhz] [get_bd_pins Zynq_1/clk_100mhz]
  connect_bd_net -net Zynq_1_clk_142mhz [get_bd_pins Video_Display/clk_142mhz] [get_bd_pins Zynq_1/clk_142mhz]
  connect_bd_net -net Zynq_1_clk_200mhz [get_bd_pins Video_Display/clk_200mhz] [get_bd_pins Zynq_1/clk_200mhz]
  connect_bd_net -net Zynq_1_s_axi_aresetn [get_bd_pins Video_Display/axi_resetn] [get_bd_pins Zynq_1/s_axi_aresetn]
  connect_bd_net -net Zynq_1_spdif_tx_o [get_bd_ports spdif_tx] [get_bd_pins Zynq_1/spdif_tx_o]

  # Create address segments
  create_bd_addr_seg -range 0x40000000 -offset 0x0 [get_bd_addr_spaces Video_Display/axi_hdmi_dma/Data_MM2S] [get_bd_addr_segs Zynq_1/processing_system7_1/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_1_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x79000000 [get_bd_addr_spaces Zynq_1/processing_system7_1/Data] [get_bd_addr_segs Video_Display/axi_hdmi_clkgen/s_axi/reg0] SEG_axi_clkgen_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x70E00000 [get_bd_addr_spaces Zynq_1/processing_system7_1/Data] [get_bd_addr_segs Video_Display/axi_hdmi_core/s_axi/axi_lite] SEG_axi_hdmi_tx_0_axi_lite
  create_bd_addr_seg -range 0x10000 -offset 0x41600000 [get_bd_addr_spaces Zynq_1/processing_system7_1/Data] [get_bd_addr_segs Video_Display/axi_iic_main/S_AXI/Reg] SEG_axi_iic_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x75C00000 [get_bd_addr_spaces Zynq_1/processing_system7_1/Data] [get_bd_addr_segs Zynq_1/axi_spdif_tx_core/S_AXI/reg0] SEG_axi_spdif_tx_0_reg0
  create_bd_addr_seg -range 0x10000 -offset 0x43000000 [get_bd_addr_spaces Zynq_1/processing_system7_1/Data] [get_bd_addr_segs Video_Display/axi_hdmi_dma/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.8
#  -string -flagsOSRD
preplace port DDR -pg 1 -y 90 -defaultsOSRD
preplace port hdmio_clk -pg 1 -y 410 -defaultsOSRD
preplace port hdmio_de -pg 1 -y 450 -defaultsOSRD
preplace port hdmio_vsync -pg 1 -y 490 -defaultsOSRD
preplace port hdmio_hsync -pg 1 -y 470 -defaultsOSRD
preplace port IIC -pg 1 -y 350 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 110 -defaultsOSRD
preplace port spdif_tx -pg 1 -y 290 -defaultsOSRD
preplace portBus hdmio_data -pg 1 -y 430 -defaultsOSRD
preplace inst Video_Display -pg 1 -lvl 1 -y 420 -defaultsOSRD
preplace inst Zynq_1 -pg 1 -lvl 2 -y 190 -defaultsOSRD
preplace netloc processing_system7_1_ddr 1 2 1 NJ
preplace netloc Video_Display_hdmio_de 1 1 2 NJ 450 NJ
preplace netloc Zynq_1_clk_142mhz 1 0 3 40 550 NJ 550 650
preplace netloc Video_Display_hdmio_hsync 1 1 2 NJ 470 NJ
preplace netloc Zynq_1_s_axi_aresetn 1 0 3 20 570 NJ 570 630
preplace netloc Zynq_1_spdif_tx_o 1 2 1 NJ
preplace netloc Zynq_1_clk_100mhz 1 0 3 30 540 NJ 540 660
preplace netloc processing_system7_1_fixed_io 1 2 1 NJ
preplace netloc Zynq_1_clk_200mhz 1 0 3 50 560 NJ 560 640
preplace netloc Video_Display_hdmi_int 1 1 1 370
preplace netloc Zynq_1_M04_AXI 1 0 3 30 30 NJ 30 680
preplace netloc Video_Display_hdmi_data 1 1 2 NJ 430 NJ
preplace netloc Zynq_1_M03_AXI 1 0 3 50 290 NJ 340 670
preplace netloc Video_Display_IIC 1 1 2 NJ 350 NJ
preplace netloc Video_Display_hdmio_clk 1 1 2 NJ 410 NJ
preplace netloc s01_axi_1 1 1 1 350
preplace netloc Zynq_1_M01_AXI 1 0 3 40 20 NJ 20 690
preplace netloc Zynq_1_M00_AXI1 1 0 3 20 10 NJ 10 700
preplace netloc Video_Display_hdmio_vsync 1 1 2 NJ 490 NJ
levelinfo -pg 1 0 200 500 720 -top 0 -bot 580
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""
