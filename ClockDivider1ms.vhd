library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockDivider1ms is
    Port (
        clk : in std_logic;           -- Main clock input (e.g., 50 MHz)
        reset : in std_logic;         -- Reset signal
        clk_1ms : out std_logic       -- 1 ms clock pulse output
    );
end ClockDivider1ms;

architecture Behavioral of ClockDivider1ms is
    -- Counter signal for generating 1 ms clock
    signal counter : std_logic_vector(15 downto 0) := (others => '0');  -- 16-bit counter
begin

    process(clk, reset)
    begin
        if reset = '0' then
            counter <= (others => '0');
            clk_1ms <= '0';
        elsif rising_edge(clk) then
            if counter = 49999 then
                counter <= (others => '0');
                clk_1ms <= '1';  -- Generate 1 ms pulse
            else
                counter <= counter + 1;
                clk_1ms <= '0';
            end if;
        end if;
    end process;

end Behavioral;