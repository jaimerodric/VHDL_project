--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:36:28 05/28/2020
-- Design Name:   
-- Module Name:   C:/Users/jorda/Desktop/microelectronica/juegoV1/tb_top_level.vhd
-- Project Name:  juegoV1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_level
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_top_level IS
END tb_top_level;
 
ARCHITECTURE behavior OF tb_top_level IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_level
    PORT(
         UP : IN  std_logic;
         DOWN : IN  std_logic;
         RIGHT : IN  std_logic;
         LEFT : IN  std_logic;
         W : IN  std_logic;
         S : IN  std_logic;
         D : IN  std_logic;
         A : IN  std_logic;
         clk : IN  std_logic;
         reset : IN  std_logic;
         pos1 : OUT  integer;
         pos2 : OUT  integer;
         estado_luchad1 : OUT  std_logic_vector(1 downto 0);
         estado_luchad2 : OUT  std_logic_vector(1 downto 0);
         fin_juego : OUT  integer;
         vida1 : OUT  integer;
         vida2 : OUT  integer
        );
    END COMPONENT;
    

   --Inputs
   signal UP : std_logic := '0';
   signal DOWN : std_logic := '0';
   signal RIGHT : std_logic := '0';
   signal LEFT : std_logic := '0';
   signal W : std_logic := '0';
   signal S : std_logic := '0';
   signal D : std_logic := '0';
   signal A : std_logic := '0';
   signal clk : std_logic := '0';
   signal reset : std_logic := '1';

 	--Outputs
   signal pos1 : integer;
   signal pos2 : integer;
   signal estado_luchad1 : std_logic_vector(1 downto 0);
   signal estado_luchad2 : std_logic_vector(1 downto 0);
   signal fin_juego : integer;
   signal vida1 : integer;
   signal vida2 : integer;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_level PORT MAP (
          UP => UP,
          DOWN => DOWN,
          RIGHT => RIGHT,
          LEFT => LEFT,
          W => W,
          S => S,
          D => D,
          A => A,
          clk => clk,
          reset => reset,
          pos1 => pos1,
          pos2 => pos2,
          estado_luchad1 => estado_luchad1,
          estado_luchad2 => estado_luchad2,
          fin_juego => fin_juego,
          vida1 => vida1,
          vida2 => vida2
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	
		wait for clk_period*10;

		reset<='0';


      wait;
   end process;

END;
