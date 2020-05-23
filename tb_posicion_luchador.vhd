--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:42:53 05/22/2020
-- Design Name:   
-- Module Name:   C:/Users/jorda/Desktop/microelectronica/juego/tb_posicion_luchador.vhd
-- Project Name:  juego
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: posicion_luchador
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
 
ENTITY tb_posicion_luchador IS
END tb_posicion_luchador;
 
ARCHITECTURE behavior OF tb_posicion_luchador IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT posicion_luchador
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         estado_lucha : IN  std_logic_vector(1 downto 0);
         right : IN  std_logic;
         left : IN  std_logic;
         p_inicial : IN  std_logic_vector(9 downto 0);
         posicion : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '1';
   signal estado_lucha : std_logic_vector(1 downto 0) := (others => '0');
   signal right : std_logic := '0';
   signal left : std_logic := '0';
   signal p_inicial : std_logic_vector(9 downto 0) := (others => '0');

 	--Outputs
   signal posicion : std_logic_vector(9 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: posicion_luchador PORT MAP (
          clk => clk,
          rst => rst,
          estado_lucha => estado_lucha,
          right => right,
          left => left,
          p_inicial => p_inicial,
          posicion => posicion
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
		
		wait for clk_period*16;
		
		right<='1';
		
		wait for clk_period*16;
		
		left<='1';
		
		wait for clk_period*16;
		
		right<='0';
		
		wait for clk_period*13;
		
		left<='0';
		
		wait for clk_period*25;
		
		estado_lucha<="01";
		
		wait for clk_period*5;
		
		right<='1';
		
		wait for clk_period*11;
		
		right<='0';
		
		wait for clk_period*5;
		
		left<='1';
		
		wait for clk_period*5;
		
		left<='0';
		
		estado_lucha<="00";
		
		wait for clk_period*5;

		left<='1';
		
		wait for clk_period*16;
		
		left<='0';
		
		right<='1';
		
		wait for clk_period*14;
		
		estado_lucha<="00";
		
		wait for clk_period*14;
		
		estado_lucha<="10";

		wait for clk_period*7;
		
		estado_lucha<="00";
		
      wait;
   end process;

END;
