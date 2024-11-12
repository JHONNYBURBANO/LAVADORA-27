library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidad para el decodificador de I/D
entity decodificadorid27 is
    port (
        direccion : in std_logic;
        seg_out   : out std_logic_vector(6 downto 0);
        habilitar : in std_logic
    );
end entity;

architecture Behavioral of decodificadorid27 is
begin
    process(direccion, habilitar)
    begin
        if habilitar = '0' then
            seg_out <= "1111111";  -- Apagar display
        elsif direccion = '0' then
            seg_out <= "1111001";  -- Mostrar I
        else
            seg_out <= "1000000";  -- Mostrar D
        end if;
    end process;
end Behavioral;
