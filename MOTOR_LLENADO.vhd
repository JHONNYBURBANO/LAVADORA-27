library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MOTOR_LLENADO is
    port( 
        CLK         : in std_logic;      -- Reloj
        enable      : in std_logic;      -- Habilita el motor
        direction   : in std_logic;      -- Control de dirección (0 o 1)
        velocidad   : in std_logic;      -- Control de velocidad (1 = 50%)
        IN1_Llenado  : out std_logic;     -- Pin IN1 del L298N
        IN2_Llenado : out std_logic;     -- Pin IN2 del L298N
        EN_Llenado   : out std_logic      -- Pin EN del L298N (PWM)
    );
end entity MOTOR_LLENADO;

architecture Behavioral of MOTOR_LLENADO is
    constant PWM_PERIOD : integer := 50_000; -- Frecuencia PWM ajustable según el reloj
    signal counter      : integer range 0 to PWM_PERIOD := 0;
    signal duty_cycle   : integer;           -- Ciclo de trabajo en función de `velocidad`
begin

    -- Control de dirección basado en la entrada `direction`
    process(direction, enable)
    begin
        if enable = '1' then
            if direction = '0' then
                IN1_Llenado <= '1';   -- Gira en LA dirección D
                IN2_Llenado <= '0';
            else
                IN1_Llenado <= '0';   -- Gira en la dirección I
                IN2_Llenado <= '1';
            end if;
        else
            IN1_Llenado <= '0';       -- Apaga el motor
            IN2_Llenado <= '0';
        end if;
    end process;

    -- Ajuste del ciclo de trabajo en función de la señal `velocidad`
    process(velocidad)
    begin
        if velocidad = '1' then
            duty_cycle <= PWM_PERIOD * 50 / 100; -- 75% del ciclo de trabajo
        else
            duty_cycle <= PWM_PERIOD * 30 / 100; -- 30% del ciclo de trabajo
        end if;
    end process;

    -- Generación de la señal PWM para el pin `EN` del L298N
    process(CLK)
    begin
        if rising_edge(CLK) then
            if enable = '1' then
                -- Incrementa el contador para el ciclo PWM
                if counter >= PWM_PERIOD then
                    counter <= 0;
                else
                    counter <= counter + 1;
                end if;
                
                -- Genera PWM basado en el ciclo de trabajo `duty_cycle`
                if counter < duty_cycle then
                    EN_Llenado <= '1';  -- Activa el pin EN según el ciclo de trabajo
                else
                    EN_Llenado <= '0';  -- Desactiva el pin EN en la parte baja del ciclo PWM
                end if;
            else
                EN_Llenado <= '0';      -- Si `enable` es 0, apaga el PWM
            end if;
        end if;
    end process;

end Behavioral;
