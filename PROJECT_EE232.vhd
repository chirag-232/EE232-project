library ieee;
use ieee.std_logic_1164.all;

package PROJECT_EE232 is

	component AND_2 is
		port(I0,I1 : in std_logic;
				O0 : out std_logic);

	end component;
	
	
	component XOR_2 is
		port(I0,I1 : in std_logic;
			O0: out std_logic);
		
	end component;
	
	
	component OR_2 is
		port(I0,I1 :in std_logic;
			O0 : out std_logic);
		
	end component;
	
	component NOT_1 is
		port (I0: in std_logic;
				O0: out std_logic);
				
	end component;
	
	component MUX_2X1 IS

		port(I0,I1,S0: IN STD_LOGIC;
			O0: out std_logic);
			
	end component;
		
	component BCD2SSD is

		port (BCD_1 : in std_logic_vector(3 downto 0);
			DIS_1: out std_logic_vector (6 downto 0);
			RSTN: in std_logic);
	end component;

		component D_FF is

		port(D: in std_logic;
				CLK: in std_logic;
				CLRN: in std_logic;
				PREN: in std_logic;
				Q: inout std_logic;
				QN: inout std_logic);
				
		end component;

		comPONENT ClockDivider1ms is
			 Port (
				  clk : in std_logic;           -- Main clock input (e.g., 50 MHz)
				  reset : in std_logic;         -- Reset signal
				  clk_1ms : out std_logic       -- 1 ms clock pulse output
			 );
		end Component;

		component random_led_blinker is
			 Port (
				  clk       : in STD_LOGIC;  -- Clock signal
				  reset     : in STD_LOGIC;  -- Reset signal (active high)
				  LED       : out STD_LOGIC_vector(3 downto 0)  -- LED output
			 );
		end component;


		component binary_to_bcd_4digit is
			 Port (
				  binary_in : in STD_LOGIC_VECTOR(11 downto 0); -- 12-bit binary input
				  bcd_out   : out STD_LOGIC_VECTOR(15 downto 0) -- 16-bit BCD output
			 );
		end component;

	
end package;
