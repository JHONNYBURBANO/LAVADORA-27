library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidad para el decodificador de L/H
entity decodificadorlh27 is
    port (
        velocidad : in std_logic;
        seg_out   : out std_logic_vector(6 downto 0);
        habilitar : in std_logic
    );
end entity;

architecture Behavioral of decodificadorlh27 is
begin
    process(velocidad, habilitar)
    begin
        if habilitar = '0' then
            seg_out <= "1111111";  -- Apagar display
        elsif velocidad = '0' then
            seg_out <= "1000111";  -- Mostrar L
        else
            seg_out <= "0001001";  -- Mostrar H
        end if;
    end process;
end Behavioral;
