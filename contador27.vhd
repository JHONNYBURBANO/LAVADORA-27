library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity contador27 is
    port (
        Clock       : in  std_logic;                          -- Reloj de 1Hz
        Reset       : in  std_logic;                          -- Señal de reinicio
        EN          : in  std_logic;                          -- Habilitador
        Load        : in  std_logic;                          -- Señal para cargar el tiempo inicial
        CNT_in      : in  std_logic_vector(3 downto 0);       -- Tiempo inicial en cada estado
        CNT_units   : out std_logic_vector(3 downto 0);       -- Unidades para el display
        CNT_tens    : out std_logic_vector(3 downto 0);       -- Decenas para el display
        finalizado  : out std_logic                           -- Señal de finalización de cuenta regresiva
    );
end entity;

architecture Behavioral of contador27 is
    signal CNT_int : integer range 0 to 99 := 0;  -- Contador interno en rango de 0 a 99
begin
    process (Clock, Reset)
    begin
        if Reset = '1' then
            CNT_int <= 0;         -- Reiniciar contador
            finalizado <= '1';    -- Finalizado en alto mientras esté en reset
        elsif rising_edge(Clock) then
            if Load = '1' then
                -- Cargar el valor inicial desde CNT_in
                CNT_int <= to_integer(unsigned(CNT_in));
                finalizado <= '0';  -- Reiniciar finalizado al cargar nuevo tiempo
            elsif EN = '1' then
                if CNT_int = 0 then
                    finalizado <= '1';  -- Indicar que la cuenta regresiva ha terminado
                else
                    CNT_int <= CNT_int - 1;  -- Cuenta regresiva
                    finalizado <= '0';
                end if;
            end if;
        end if;
    end process;

    -- Asignación de las unidades y decenas para los displays
    CNT_units <= std_logic_vector(to_unsigned(CNT_int mod 10, 4));  -- Unidades
    CNT_tens  <= std_logic_vector(to_unsigned((CNT_int / 10) mod 10, 4));  -- Decenas

end Behavioral;
