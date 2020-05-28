library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity estado_juego is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pos2 : in  STD_LOGIC_VECTOR (9 downto 0);
           pos1 : in  STD_LOGIC_VECTOR (9 downto 0);
           estado_luchador1 : in  STD_LOGIC_VECTOR (1 downto 0);
           estado_luchador2 : in  STD_LOGIC_VECTOR (1 downto 0);
			  --vida1 : out std_logic_vector (3 downto 0);
			  vida1 : out integer:= 3;
			  vida2 : out integer:= 3;
			  --vida2 : out std_logic_vector (3 downto 0);
           fin_juego : out  STD_LOGIC);
end estado_juego;

architecture Behavioral of estado_juego is

signal dist : std_logic_vector(9 downto 0);
signal corazones1,corazones2 : integer := 3;
signal fin : std_logic;

begin

sinc:process(clk,reset)
begin
	if(reset='1')then
		fin_juego<='0';
		vida1 <= 3;
		vida2 <= 3;
	elsif(rising_edge(clk)) then
		vida1 <= corazones1;
		vida2 <= corazones2;
		fin_juego<=fin;
	end if;
end process;

comb: process(dist,pos1,pos2,estado_luchador1,estado_luchador2,fin,corazones1,corazones2)
begin

	dist <= std_logic_vector(unsigned(pos2) - unsigned(pos1));

	if (unsigned(dist) < 20) then
		if(estado_luchador1 = "01" AND estado_luchador2 = "00") then
			if corazones2 > 1 then
				corazones2 <= corazones2 - 1;
				if corazones2 = 0 then
					fin <= '1';
				else
					fin <= '0';
				end if;
			end if;
		elsif (estado_luchador1 = "00" AND estado_luchador2 = "01") then
			if corazones1 > 1 then
				corazones1 <= corazones1 - 1;
				if corazones1 = 0 then
					fin <= '1';
				else
					fin <= '0';
				end if;
			end if;
		else
			fin <= '0';
		end if;
		
	else
		fin <= '0';
	end if;


end process;

end Behavioral;

