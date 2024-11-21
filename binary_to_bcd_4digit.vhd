library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

---------entity declaration------
entity binary_to_bcd_4digit is
    Port (
        binary_in : in STD_LOGIC_VECTOR(11 downto 0); -- 12-bit binary input
        bcd_out   : out STD_LOGIC_VECTOR(15 downto 0) -- 16-bit BCD output
    );
end binary_to_bcd_4digit;


-------architecture declaration-----------
architecture Behavioral of binary_to_bcd_4digit is
begin
    process(binary_in)
        variable binary : unsigned(11 downto 0);
        variable bcd    : unsigned(15 downto 0);
        variable i      : integer;
    begin
        binary := unsigned(binary_in);
        bcd := (others => '0');
        
        ------ Double Dabble algorithm--------
        for i in 0 to 11 loop
				if bcd(15 downto 12) > "0100" then
                bcd(15 downto 12) := bcd(15 downto 12) + "0011";
            end if;
            if bcd(11 downto 8) > "0100" then
                bcd(11 downto 8) := bcd(11 downto 8) + "0011";
            end if;
            if bcd(7 downto 4) > "0100" then
                bcd(7 downto 4) := bcd(7 downto 4) + "0011";
            end if;
            if bcd(3 downto 0) > "0100" then
                bcd(3 downto 0) := bcd(3 downto 0) + "0011";
            end if;
            
            bcd := bcd(14 downto 0) & binary(11); -- shift left
            binary := binary(10 downto 0) & '0';
        end loop;
        
        bcd_out <= std_logic_vector(bcd);
    end process;
	 
end Behavioral;