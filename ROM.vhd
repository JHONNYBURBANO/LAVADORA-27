library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    Port (
        address : in  std_logic_vector(2 downto 0); -- Dirección del ciclo actual
        data_out : out std_logic_vector(3 downto 0) -- Tiempo de ejecución en unidades de 10s
    );
end entity;

architecture Behavioral of ROM is
    type rom_array is array (0 to 7) of std_logic_vector(3 downto 0);
    constant ROM_CONTENT : rom_array := (
        "0010",  -- Tiempo para INICIAL (10 segundos)
        "1110",  -- Tiempo para LLENADO (30 segundos)
        "1011",  -- Tiempo para LAVADO (90 segundos)
        "0101",  -- Tiempo para VACIADO (45 segundos)
        "0110",  -- Tiempo para ENJUAGUE (60 segundos)
        "0111",  -- Tiempo para CENTRIFUGADO (75 segundos)
        "0000",  -- Tiempo para TERMINADO (sin tiempo)
        "0000"   -- Tiempo para PAUSA (sin tiempo)
    );
begin
    process(address)
    begin
        data_out <= ROM_CONTENT(to_integer(unsigned(address)));
    end process;
end Behavioral;
