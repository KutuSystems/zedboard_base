--------------------------------------------------------------
--
-- (C) Copyright Kutu Pty. Ltd. 2014.
--
-- file: top_zc702.vhd
--
-- author: Greg Smart
--
--------------------------------------------------------------
--------------------------------------------------------------
--
-- This module is the top level module of zc702_base
-- running on a Xilinx zc702 board.
--
--------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_ARITH.ALL;
use IEEE.std_logic_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity top_zc702 is
   port (
      DDR_addr          : inout std_logic_vector ( 14 downto 0 );
      DDR_ba            : inout std_logic_vector ( 2 downto 0 );
      DDR_cas_n         : inout std_logic;
      DDR_ck_n          : inout std_logic;
      DDR_ck_p          : inout std_logic;
      DDR_cke           : inout std_logic;
      DDR_cs_n          : inout std_logic;
      DDR_dm            : inout std_logic_vector ( 3 downto 0 );
      DDR_dq            : inout std_logic_vector ( 31 downto 0 );
      DDR_dqs_n         : inout std_logic_vector ( 3 downto 0 );
      DDR_dqs_p         : inout std_logic_vector ( 3 downto 0 );
      DDR_odt           : inout std_logic;
      DDR_ras_n         : inout std_logic;
      DDR_reset_n       : inout std_logic;
      DDR_we_n          : inout std_logic;
      FIXED_IO_ddr_vrn  : inout std_logic;
      FIXED_IO_ddr_vrp  : inout std_logic;
      FIXED_IO_mio      : inout std_logic_vector ( 53 downto 0 );
      FIXED_IO_ps_clk   : inout std_logic;
      FIXED_IO_ps_porb  : inout std_logic;
      FIXED_IO_ps_srstb : inout std_logic;
      hdmio_clk         : out std_logic;
      hdmio_data        : out std_logic_vector ( 15 downto 0 );
      hdmio_de          : out std_logic;
      hdmio_hsync       : out std_logic;
      hdmio_vsync       : out std_logic;
      iic_scl_io        : inout std_logic;
      iic_sda_io        : inout std_logic;
      spdif_tx          : out std_logic;
      led               : out std_logic_vector(7 downto 0)
   );
end top_zc702;

architecture RTL of top_zc702 is

   component system_top_wrapper is
   port (
      DDR_addr          : inout std_logic_vector ( 14 downto 0 );
      DDR_ba            : inout std_logic_vector ( 2 downto 0 );
      DDR_cas_n         : inout std_logic;
      DDR_ck_n          : inout std_logic;
      DDR_ck_p          : inout std_logic;
      DDR_cke           : inout std_logic;
      DDR_cs_n          : inout std_logic;
      DDR_dm            : inout std_logic_vector ( 3 downto 0 );
      DDR_dq            : inout std_logic_vector ( 31 downto 0 );
      DDR_dqs_n         : inout std_logic_vector ( 3 downto 0 );
      DDR_dqs_p         : inout std_logic_vector ( 3 downto 0 );
      DDR_odt           : inout std_logic;
      DDR_ras_n         : inout std_logic;
      DDR_reset_n       : inout std_logic;
      DDR_we_n          : inout std_logic;
      FIXED_IO_ddr_vrn  : inout std_logic;
      FIXED_IO_ddr_vrp  : inout std_logic;
      FIXED_IO_mio      : inout std_logic_vector ( 53 downto 0 );
      FIXED_IO_ps_clk   : inout std_logic;
      FIXED_IO_ps_porb  : inout std_logic;
      FIXED_IO_ps_srstb : inout std_logic;
      hdmio_clk         : out std_logic;
      hdmio_data        : out std_logic_vector ( 15 downto 0 );
      hdmio_de          : out std_logic;
      hdmio_hsync       : out std_logic;
      hdmio_vsync       : out std_logic;
      iic_scl_io        : inout std_logic;
      iic_sda_io        : inout std_logic;
      spdif_tx          : out std_logic
  );
  end component;

begin

   led     <= "01010011";

   system_top_wrapper_1 : system_top_wrapper
   port map (
      DDR_addr(14 downto 0)      => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0)         => DDR_ba(2 downto 0),
      DDR_cas_n                  => DDR_cas_n,
      DDR_ck_n                   => DDR_ck_n,
      DDR_ck_p                   => DDR_ck_p,
      DDR_cke                    => DDR_cke,
      DDR_cs_n                   => DDR_cs_n,
      DDR_dm(3 downto 0)         => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0)        => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0)      => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0)      => DDR_dqs_p(3 downto 0),
      DDR_odt                    => DDR_odt,
      DDR_ras_n                  => DDR_ras_n,
      DDR_reset_n                => DDR_reset_n,
      DDR_we_n                   => DDR_we_n,
      FIXED_IO_ddr_vrn           => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp           => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0)  => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk            => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb           => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb          => FIXED_IO_ps_srstb,
      hdmio_clk                  => hdmio_clk,
      hdmio_data(15 downto 0)    => hdmio_data(15 downto 0),
      hdmio_de                   => hdmio_de,
      hdmio_hsync                => hdmio_hsync,
      hdmio_vsync                => hdmio_vsync,
      iic_scl_io                 => iic_scl_io,
      iic_sda_io                 => iic_sda_io,
      spdif_tx                   => spdif_tx
   );

end RTL;
