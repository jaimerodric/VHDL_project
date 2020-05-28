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
	estado_luchador1: out std_logic_vector(1 downto 0);
	estado_luchador2: out std_logic_vector(1 downto 0);
	fin_juego: out std_logic;
	vida1 : out integer;
	vida2 : out integer);
	

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
	Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  estado_lucha : in  STD_LOGIC_VECTOR (1 downto 0);
           right : in  STD_LOGIC;
           left : in  STD_LOGIC;
			  p_inicial: in  STD_LOGIC_VECTOR (9 downto 0);
           posicion : out  STD_LOGIC_VECTOR (9 downto 0));
end component;

component estado_juego
	Port (  clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pos2 : in  STD_LOGIC_VECTOR (9 downto 0);
           pos1 : in  STD_LOGIC_VECTOR (9 downto 0);
           estado_luchador1 : in  STD_LOGIC_VECTOR (1 downto 0);
           estado_luchador2 : in  STD_LOGIC_VECTOR (1 downto 0);
			  vida1 : out integer:= 3;
			  vida2 : out integer:= 3;
           fin_juego : out  STD_LOGIC);
end component;

signal estado_lucha1, estado_lucha2 : std_logic_vector(1 downto 0);
signal p_inicial_1, p_inicial_2 : std_logic_vector(9 downto 0);


begin

	p_inicial_1 <= std_logic_vector(50);
	p_inicial_2 <= std_logic_vector(150);

	ESTADO_LUCHADOR1 : estado_luchador 	generic map( VAL_SAT_CONT => 200, ANCHO_CONTADOR=> 20)
						port map (clk => clk, rst => reset, up => UP, down => DOWN, estado_lucha => estado_lucha1);
	ESTADO_LUCHADOR2 : estado_luchador 	generic map( VAL_SAT_CONT => 200, ANCHO_CONTADOR=> 20)
						port map (clk => clk, rst => reset, up => W, down => S, estado_lucha => estado_lucha2);
	POSICION_LUCHADOR1 : posicion_luchador 	port map (clk => clk, rst => reset, right => RIGHT, left => LEFT, estado_lucha => estado_lucha1, p_inicial => p_inicial_1, posicion => pos1);
	POSICION_LUCHADOR2 : posicion_luchador 	port map (clk => clk, rst => reset, right => D, left => A, estado_lucha => estado_lucha2, p_inicial => p_inicial_2, posicion => pos2);
	ESTADO_JUEGO : estado_juego port map (clk => clk, reset => reset, pos1 => pos1, pos2 => pos2, estado_luchador1 => estado_lucha1, estado_luchador2 => estado_lucha2, fin_juego => fin_juego,vida1 => vida1, vida2 => vida2);

end Behavioral;

