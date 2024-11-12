library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Entidad del decodificador
entity decodificador_7_segmentos24 is
    port (
        bin_in  : in std_logic_vector(3 downto 0);
        seg_out : out std_logic_vector(6 downto 0);
        habilitar : in std_logic
    );
end entity;

architecture Behavioral of decodificador_7_segmentos24 is
begin
    process(bin_in, habilitar)
    begin
        if habilitar = '0' then
            seg_out <= "1111111";  -- Apagar display
        else
            case bin_in is
                when "0000" => seg_out <= "1000000";  -- '0'
                when "0001" => seg_out <= "1111001";  -- '1'
                -- Agregar el resto de las asignaciones
                when others => seg_out <= "1111111";  -- Apagado por defecto
            end case;
        end if;
    end process;
end architecture;
