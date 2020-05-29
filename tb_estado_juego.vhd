--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:04:25 05/28/2020
-- Design Name:   
-- Module Name:   C:/Users/jorda/Desktop/microelectronica/juegoV1/tb_estado_juego.vhd
-- Project Name:  juegoV1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: estado_juego
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
 
ENTITY tb_estado_juego IS
END tb_estado_juego;
 
ARCHITECTURE behavior OF tb_estado_juego IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT estado_juego
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         pos2 : IN  integer;
         pos1 : IN  integer;
         estado_luchador1 : IN  std_logic_vector(1 downto 0);
         estado_luchador2 : IN  std_logic_vector(1 downto 0);
         vida1 : OUT  integer;
         vida2 : OUT  integer;
         fin_juego : OUT  integer
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal pos2 : integer := 0;
   signal pos1 : integer := 0;
   signal estado_luchador1 : std_logic_vector(1 downto 0) := (others => '0');
   signal estado_luchador2 : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal vida1 : integer;
   signal vida2 : integer;
   signal fin_juego : integer;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: estado_juego PORT MAP (
          clk => clk,
          rst => rst,
          pos2 => pos2,
          pos1 => pos1,
          estado_luchador1 => estado_luchador1,
          estado_luchador2 => estado_luchador2,
          vida1 => vida1,
          vida2 => vida2,
          fin_juego => fin_juego
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
		
		rst<='0';
		
		wait for clk_period*10;
		
		pos2 <= 100;
      pos1 <= 50;
		
		wait for clk_period*10;
		
		estado_luchador1<="00" ;
      estado_luchador2 <="01";
		
		wait for clk_period*10;
		
		estado_luchador1<="00" ;
      estado_luchador2 <="00";

		wait for clk_period*10;
		
		estado_luchador1<="00" ;
      estado_luchador2 <="01";

		wait for clk_period*10;
		
		estado_luchador1<="00" ;
      estado_luchador2 <="00";

		wait for clk_period*10;
		
		estado_luchador1<="00" ;
      estado_luchador2 <="01";
		
      wait;
   end process;

END;
