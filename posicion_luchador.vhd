----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:55:06 05/21/2020 
-- Design Name: 
-- Module Name:    posicion_luchador - Behavioral 
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

entity posicion_luchador is
	Generic ( p_inicial:integer:= 50
				);
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  estado_lucha : in  STD_LOGIC_VECTOR (1 downto 0);
           right : in  STD_LOGIC;
           left : in  STD_LOGIC;
           posicion : out  integer);
end posicion_luchador;

architecture Behavioral of posicion_luchador is

signal p_cont,cont: INTEGER;
signal p_posicion,posicion_aux: integer;

begin

posicion<=posicion_aux;

sinc:process(clk,rst)
begin
	if(rst='1')then
		posicion_aux<=p_inicial;
		cont<=0;
	elsif(rising_edge(clk)) then
		posicion_aux<=p_posicion;
		cont<=p_cont;
	end if;
end process;

comb: process(posicion_aux,cont,left,right,estado_lucha)
begin

	p_cont<=(cont+1);
	
	p_posicion<=posicion_aux;
	
	if cont=5 then -- ajustar este div_frec para un movimiento fluido
		p_cont<=0;
	
		if estado_lucha = "00" then 
			if right='1' and left ='0' and posicion_aux<200 then
				p_posicion<=posicion_aux+1;
			elsif right='0' and left ='1' and posicion_aux>0 then
				p_posicion<=posicion_aux-1;
			end if;
		end if;
		
	end if;
 
end process;

end Behavioral;

