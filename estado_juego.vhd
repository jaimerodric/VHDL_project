library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity estado_juego is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           pos2 : in  integer;
           pos1 : in  integer;
           estado_luchador1 : in  STD_LOGIC_VECTOR (1 downto 0);
           estado_luchador2 : in  STD_LOGIC_VECTOR (1 downto 0);
			  vida1 : out integer:= 3;
			  vida2 : out integer:= 3;
           fin_juego : out  STD_LOGIC);
end estado_juego;

architecture Behavioral of estado_juego is

signal dist : integer;
signal corazones1: integer := 3;
signal corazones2: integer := 3;
signal p_corazones1: integer;
signal p_corazones2: integer;
signal fin : std_logic;

begin

vida1<=corazones1;
vida2<=corazones1;

sinc:process(clk,rst)
begin
	if(rst='1')then
		fin_juego<='0';
		corazones1 <= 3;
		corazones2 <= 3;
	elsif(rising_edge(clk)) then
		corazones1 <= p_corazones1;
		corazones2 <= p_corazones2;
		fin_juego<=fin;
	end if;
end process;


comb: process(dist,pos1,pos2,estado_luchador1,estado_luchador2,fin,corazones1,corazones2,p_corazones1, p_corazones2)
begin

	dist <= pos2 - pos1;

	if (dist < 80) AND (pos2 > pos1) then
		if(estado_luchador1 = "01" AND estado_luchador2 = "00" and corazones2 > 1) then
				p_corazones2 <= corazones2 - 1;
		elsif (estado_luchador1 = "00" AND estado_luchador2 = "01" and corazones1 > 1) then
				p_corazones1 <= corazones1 - 1;
		end if;
	end if;

	if corazones2 = 0 or corazones1 = 0 then
		fin <= '1';
	else
		fin <= '0';
	end if;

end process;

end Behavioral;

