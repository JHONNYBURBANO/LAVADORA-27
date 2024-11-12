LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

entity infrared_tapa is

port ( sensorin_tapa : in std_logic;
	    tapa_cerrada : out std_logic);
end infrared_tapa;


architecture architecture_IR of infrared_tapa is
begin
    process(sensorin_tapa)
		 begin
			  if sensorin_tapa = '1' then
					tapa_cerrada <= '1';
			  else
					tapa_cerrada <= '0';
			  end if; 
    end process;
end architecture_IR;