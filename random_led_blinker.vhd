library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity random_led_blinker is
    Port (
        clk       : in STD_LOGIC;  -- Clock signal
        reset     : in STD_LOGIC;  -- Reset signal (active high)
        LED       : out STD_LOGIC_vector(3 downto 0)  -- LED output
    );
end entity;

architecture Behavioral of random_led_blinker is

    -- Constants
    constant CLOCK_FREQ : integer := 50000000; -- 50 MHz clock frequency
    constant MIN_DELAY  : integer := 2 * CLOCK_FREQ; -- 2 seconds
    constant MAX_DELAY  : integer := 4 * CLOCK_FREQ; -- 4 seconds

    -- Signals
    signal counter      : integer range 0 to MAX_DELAY := 0;
    signal delay        : integer range MIN_DELAY to MAX_DELAY := MIN_DELAY;
    signal random_seed  : integer := 123456; -- Initial seed for PRNG
    signal LED_state    : STD_LOGIC_vector(3 downto 0) := "0000";

begin

    -- PRNG process to generate pseudo-random delay (between MIN_DELAY and MAX_DELAY)
    Random_Generator : process(clk)
    begin
        if rising_edge(clk) then
            if reset = '0' then
                random_seed <= 123456; -- Reset seed to a known value
                delay <= MIN_DELAY; -- Reset delay to minimum
            else
                -- Generate a new pseudo-random value within range MIN_DELAY to MAX_DELAY
                random_seed <= (random_seed * 1103515245 + 12345) mod 2147483648; -- Linear congruential generator
                delay <= MIN_DELAY + abs(random_seed mod (MAX_DELAY - MIN_DELAY)); -- Scale within range
            end if;
        end if;
    end process Random_Generator;

    -- Timer process to activate LED after the calculated delay
    Timer_Process : process(clk)
    begin
        if rising_edge(clk) then
            if reset = '0' then
                counter <= 0;
                LED_state <= "0000"; -- Turn off LED on reset
            elsif counter < delay then
                counter <= counter + 1; -- Increment counter until delay is reached
            else
                LED_state <= "1111" ; -- Turn on LED after the delay
            end if;
        end if;
    end process Timer_Process;

    -- Assign LED output
    LED <= LED_state;

end Behavioral;