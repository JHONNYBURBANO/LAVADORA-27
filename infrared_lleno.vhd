LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;

entity infrared_lleno is

port ( sensorin_lleno : in std_logic;
	    lleno_vacio : out std_logic);
end infrared_lleno;


architecture architecture_IR of infrared_lleno is
begin
    process(sensorin_lleno)
		 begin
			  if sensorin_lleno = '1' then
					lleno_vacio <= '1';
			  else
					lleno_vacio <= '0';
			  end if; 
    end process;
end architecture_IR;