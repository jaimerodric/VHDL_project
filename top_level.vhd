----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:29:13 05/26/2020 
-- Design Name: 
-- Module Name:    top_level - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level is
PORT (
	UP: in std_logic;
	DOWN: in std_logic;
	RIGHT: in std_logic;
	LEFT: in std_logic;
	W: in std_logic;
	S: in std_logic;
	D: in std_logic;
	A: in std_logic;
	clk: in std_logic;
	reset: in std_logic;
	pos1: out std_logic_vector(9 downto 0);
	pos2: out std_logic_vector(9 downto 0);
	estado_luchad1: out std_logic_vector(1 downto 0);
	estado_luchad2: out std_logic_vector(1 downto 0);
	fin_juego: out std_logic);
	

end top_level;

architecture Behavioral of top_level is

component estado_luchador
	Generic (VAL_SAT_CONT:integer:=200; --modificar este valor para modificar tiempo que el muñeco salta
				ANCHO_CONTADOR:integer:=20); -- modificar para que el vector pueda contar hasta numoer de arriba
				
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  up : in  STD_LOGIC;
           down : in  STD_LOGIC;
           estado_lucha : out  STD_LOGIC_VECTOR (1 downto 0));
end component;
	
component posicion_luchador
	Generic ( p_inicial:std_logic_vector:= "0000110010"
				);
	Port (  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  estado_lucha : in  STD_LOGIC_VECTOR (1 downto 0);
           right : in  STD_LOGIC;
           left : in  STD_LOGIC;
           posicion : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

component estado_juego
	Port (  pos2 : in  STD_LOGIC_VECTOR (9 downto 0);
           pos1 : in  STD_LOGIC_VECTOR (9 downto 0);
           estado_luchador1 : in  STD_LOGIC_VECTOR (1 downto 0);
           estado_luchador2 : in  STD_LOGIC_VECTOR (1 downto 0);
           fin_juego : out  STD_LOGIC);
end component;

signal estado_lucha1, estado_lucha2 : std_logic_vector(1 downto 0);
signal p_inicial_1, p_inicial_2, p1_aux, p2_aux : std_logic_vector(9 downto 0);


begin

	ESTADO_LUCHADOR1 : estado_luchador 
						generic map( VAL_SAT_CONT => 200, 
										 ANCHO_CONTADOR=> 20)
										 
						port map 	(clk => clk, 
										rst => reset, 
										up => UP, 
										down => DOWN, 
										estado_lucha => estado_lucha1);
						
	ESTADO_LUCHADOR2 : estado_luchador 	
						generic map( VAL_SAT_CONT => 200, 
										 ANCHO_CONTADOR=> 20)
										 
						port map (clk => clk, 
									 rst => reset, 
									 up => W, 
									 down => S, 
									 estado_lucha => estado_lucha2);
						
	POSICION_LUCHADOR1 : posicion_luchador 
						generic map( p_inicial => "0000110010"
						)
						port map (clk => clk, 
									 rst => reset, 
									 right => RIGHT, 
									 left => LEFT, 
									 estado_lucha => estado_lucha1, 
									 posicion => p1_aux);
									 
	POSICION_LUCHADOR2 : posicion_luchador 	
						generic map( p_inicial => "0010010110"
						)
						port map (clk => clk, 
									 rst => reset, 
									 right => D, 
									 left => A, 
									 estado_lucha => estado_lucha2,  
									 posicion => p2_aux);
									 
	EST_JUEGO : estado_juego 
						port map (pos1 => p1_aux, 
									 pos2 => p2_aux, 
									 estado_luchador1 => estado_lucha1, 
									 estado_luchador2 => estado_lucha2, 
									 fin_juego => fin_juego);
									
	pos1<=p1_aux;
	pos2<=p2_aux;
	
	estado_luchad1<= estado_lucha1;
	estado_luchad2<= estado_lucha2;

end Behavioral;