--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:17:34 05/21/2020
-- Design Name:   
-- Module Name:   C:/Users/jorda/Desktop/microelectronica/juego/tb_estado_luchador.vhd
-- Project Name:  juego
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: estado_luchador
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
 
ENTITY tb_estado_luchador IS
END tb_estado_luchador;
 
ARCHITECTURE behavior OF tb_estado_luchador IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT estado_luchador
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         up : IN  std_logic;
         down : IN  std_logic;
         estado_lucha : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal up : std_logic := '0';
   signal down : std_logic := '0';

 	--Outputs
   signal estado_lucha : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: estado_luchador PORT MAP (
          clk => clk,
          rst => rst,
          up => up,
          down => down,
          estado_lucha => estado_lucha
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

      wait for clk_period*3;

      rst<='0';
		
      wait for clk_period*3;

      down<='1';
		
		wait for clk_period*3;
		
		up<='1';
		
      wait for clk_period*3;

      down<='0';
		
      wait for clk_period*3;

      up<='1';
		
      wait for clk_period*3;

      up<='0';
		
      wait for clk_period*3;

      up<='1';
		
		wait for clk_period*3;
		
		down<='1';
		
		wait for clk_period*3;
		
		down<='0';
		up<='0';
		
		wait for clk_period*3;
		
		up<='1';
		
		wait for clk_period*15;
		
		up<='0';
		
      wait;
   end process;

END;
