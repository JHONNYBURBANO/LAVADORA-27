library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ciclo_operacion27 is
    port (
        encendido          : in  std_logic;
        lleno_vacio        : in  std_logic;
        tapa_cerrada       : in  std_logic;
        clk                : in  std_logic;
        finalizado         : in  std_logic;  -- Entrada de señal de finalización desde contador27
        ciclo              : out std_logic_vector(2 downto 0);  -- Indica el ciclo actual
        alarma             : out std_logic;
        direccion          : out std_logic;  -- D/I (0 para derecha, 1 para izquierda)
        velocidad          : out std_logic;                     -- Rápido (H) o Lento (L)
        habilitar_velocidad : out std_logic;
        habilitar_direccion : out std_logic;
        habilitar_displays  : out std_logic;
        habilitar_contador  : out std_logic;
		  tiempo_rom         : in std_logic_vector(3 downto 0);   -- Tiempo de operación desde la ROM
        tiempo_operacion    : out std_logic_vector(3 downto 0); -- Tiempo de operación para cada estado (en unidades de 10s)

        -- Señales de control de motores
        motor_llenado       : out std_logic;  -- Activa motor de llenado
        motor_vaciado       : out std_logic;  -- Activa motor de vaciado
        motor_tambor        : out std_logic
		 
    );
end entity;

architecture Behavioral of ciclo_operacion27 is
    type state_type is (INICIAL, LLENADO, LAVADO, VACIADO, ENJUAGUE, CENTRIFUGADO, TERMINADO, PAUSA);
    signal state, next_state : state_type := INICIAL;
begin
    -- Proceso de transición de estado
    process (clk, encendido, lleno_vacio, tapa_cerrada)
    begin
        if rising_edge(clk) then
            if encendido = '1' and lleno_vacio = '1' and tapa_cerrada = '1' then
                if finalizado = '1' then  -- Espera a que el contador termine antes de avanzar
                    state <= next_state;
                end if;
            end if;
        end if;
    end process;

    -- Proceso de lógica de estado y generación de las salidas
    process (state)
    begin
        -- Valores predeterminados
        alarma <= '0';
        direccion <= '0';
        velocidad <= '0';
        habilitar_velocidad <= '0';
        habilitar_direccion <= '0';
        habilitar_displays <= '0';
        habilitar_contador <= '0';
		  tiempo_operacion <= tiempo_rom;  -- Obtiene el tiempo desde la ROM


        -- Señales de motores predeterminadas (apagadas)
        motor_llenado <= '0';
        motor_vaciado <= '0';
        motor_tambor  <= '0';
		  
		  
        case state is
            when INICIAL =>
                next_state <= LLENADO;
                habilitar_contador <= '1';
                

            when LLENADO =>
                motor_llenado <= '1';  -- Activar motor de llenado
                habilitar_displays <= '1';
                habilitar_contador <= '1';
                next_state <= LAVADO;

            when LAVADO =>
                habilitar_velocidad <= '1';
                habilitar_direccion <= '1';
                habilitar_displays <= '1';
                direccion <= '1';  -- Derecha
                velocidad <= '0';  -- Lento
                motor_tambor <= '1';
                next_state <= VACIADO;

            when VACIADO =>
                motor_vaciado <= '1';  -- Activar motor de vaciado
                habilitar_displays <= '1';
                habilitar_contador <= '1';
                next_state <= ENJUAGUE;

            when ENJUAGUE =>
                habilitar_velocidad <= '1';
                habilitar_direccion <= '1';
                habilitar_displays <= '1';
                direccion <= '0';  -- Izquierda
                velocidad <= '0';  -- Lento
					 motor_tambor <= '1';
                next_state <= CENTRIFUGADO;

            when CENTRIFUGADO =>
                habilitar_velocidad <= '1';
                habilitar_direccion <= '1';
                direccion <= '0';  -- Izquierda
                velocidad <= '1';  -- Rápido
					 motor_tambor <= '1';
                next_state <= TERMINADO;

            when TERMINADO =>
                alarma <= '1';  -- Activar alarma
                next_state <= TERMINADO;

            when PAUSA =>
                next_state <= PAUSA;

            when others =>
                next_state <= INICIAL;
        end case;
    end process;
    
    -- Conversión de estado a valor binario para salida
    ciclo <= std_logic_vector(to_unsigned(state'pos(state), 3));

end Behavioral;



