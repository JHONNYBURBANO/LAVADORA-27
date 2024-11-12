library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity divisordefrecuencia24 is
    port (
        clk   : in  std_logic;
        clk1Hz : out std_logic
    );
end entity divisordefrecuencia24;

architecture Behavioral of divisordefrecuencia24 is
    signal count : integer range 0 to 25000000 := 0;  -- Inicializa el contador
    signal clk1Hz_internal : std_logic := '0';        -- Señal interna para clk1Hz
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if count = 25000000 then
                clk1Hz_internal <= not clk1Hz_internal;  -- Invertir el reloj de 1Hz
                count <= 0;  -- Reinicia el contador
            else
                count <= count + 1;
            end if;
        end if;
    end process;

    clk1Hz <= clk1Hz_internal;  -- Asignar la señal interna al puerto de salida
end Behavioral;