library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity estado_juego is
    Port ( --clk : in  STD_LOGIC;
           --reset : in  STD_LOGIC;
           pos2 : in  integer;
           pos1 : in  integer;
           estado_luchador1 : in  STD_LOGIC_VECTOR (1 downto 0);
           estado_luchador2 : in  STD_LOGIC_VECTOR (1 downto 0);
           fin_juego : out  STD_LOGIC);
end estado_juego;

architecture Behavioral of estado_juego is

signal dist : integer;

begin

comb: process(dist,pos1,pos2,estado_luchador1,estado_luchador2)
begin

	dist <= pos2 - pos1;

	if (dist < 35) AND (pos2 > pos1) then
		if(estado_luchador1 = "01" AND estado_luchador2 = "00") then
			fin_juego <= '1';
		elsif (estado_luchador1 = "00" AND estado_luchador2 = "01") then
			fin_juego <= '1';
		else
			fin_juego <= '0';
		end if;
		
	else
		fin_juego <= '0';
	end if;


end process;

end Behavioral;

