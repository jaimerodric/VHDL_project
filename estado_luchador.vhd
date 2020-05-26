----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:26:39 05/21/2020 
-- Design Name: 
-- Module Name:    estado_luchador - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity estado_luchador is
	Generic (VAL_SAT_CONT:integer:=200; --modificar este valor para modificar tiempo que el muñeco salta
				ANCHO_CONTADOR:integer:=20); -- modificar para que el vector pueda contar hasta numero de arriba
				
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  up : in  STD_LOGIC;
           down : in  STD_LOGIC;
           estado_lucha : out  STD_LOGIC_VECTOR (1 downto 0));
end estado_luchador;

architecture Behavioral of estado_luchador is
	
	type estado is (ataque, normal,defensa);
	signal estado_actual,estado_nuevo:estado;
	signal p_cont,cont: STD_LOGIC_VECTOR (ancho_contador downto 0); -- contador de tiempo de ataque, para que no sea indefinido
	signal up_ant,down_ant: STD_LOGIC;

begin

sinc:process(clk,rst)
begin
	if(rst='1')then
		estado_actual<=normal;
	elsif(rising_edge(clk)) then
		estado_actual<=estado_nuevo;
		cont<=p_cont;
		up_ant<=up;
		down_ant<=down;
	end if;
end process;

comb: process(estado_actual,up_ant,up,down,down_ant,cont)
begin

case estado_actual is 

	when normal =>		
		estado_lucha<="00";
		p_cont<=(others => '0');
		
		if (up='1' and up_ant='0') then
			estado_nuevo<=	ataque;
		elsif (down='1' and down_ant='0') then
			estado_nuevo<= defensa;
		else
			estado_nuevo<=	normal;
		end if;

	when ataque =>		
		estado_lucha<="01";
		
		if (up='0') or (unsigned(cont) = VAL_SAT_CONT) then
			estado_nuevo<=	normal;
			p_cont<=(others => '0');
		else
			p_cont<=std_logic_vector(unsigned(cont)+1);
			estado_nuevo<=	ataque;
		end if;
		
	when defensa =>		
		estado_lucha<="10";
		p_cont<=(others => '0');
		
		if down='0' then
			estado_nuevo<=	normal;
		else
			estado_nuevo<=	defensa;
		end if;
		
end case;

end process;

end Behavioral;

