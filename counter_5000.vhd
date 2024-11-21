----using libraries-----
library ieee;
use ieee.std_LOGIC_1164.all;
use work.PROJECT_EE232.all;


----entity declaration-----
entity counter_5000 is
port (clk: in std_logic; -- clock input
		reset: inout std_logic;
		Load: in std_logic; -- Loading values
		LED_OUT : inout std_logic_VECTOR (3 downto 0); --LED of random number
		DIS_1,DIS_2,DIS_3,DIS_4,DIS_5 : OUT STD_logic_vector(6 downto 0); -- DISPLAY on SSD
		decimal_point : out std_logic
		);
end entity;



----Architecture of the code -----
architecture Functionality of counter_5000 is


signal Load_mux_out : std_logic_vector(11 downto 0); -- MUX Output from MUX using Load as select line
signal reset_mux_out : std_logic_vector(11 downto 0); -- MUX Output from MUX using Reset as select line
signal xor_out: std_logic_vector(11 downto 0); -- output of XOR Gate
signal carry,QN,Q,R,D: std_logic_vector(11 downto 0); 
signal clk_out: std_logic;
signal Enable_OUT, enable_handling: std_logic; -- Enables the Counter
signal BCD_OUT : std_logic_vector(15 downto 0);
signal LED_SELECT: std_logic;


begIN

random : random_led_blinker port map (clk,reset,LED_OUT); ---pseudo random number generator for switrchin ON LED

clock: ClockDivider1ms port map(clk,reset,clk_out); -- clock divider making 1ms
R <= "000000000000"; ---Values WHEN RESET IS ASSERTED
D <= Q; -- Loading values of D to Q 

LED_SELECT <= led_OUT(0);
-- enable MUX using LED as select line
EN_MUX : MUX_2X1 port map ('0','1',LED_sELECT,Enable_OUT); 

------- synchronous sequential counter -------


LDR: for i in 11 downto 0 generate
	LDR0: MUX_2X1 PORT MAP(xor_out(i),D(i),Load,Load_mux_out(i)); 
	end generate;


-----MUX Output from MUX using Reset as select line------- 	
MR: for i in 11 downto 0 generate
	MR0: MUX_2X1 port map(R(i),Load_mux_out(i),reset,reset_mux_out(i));  
end generate;

------using XOR gates and outputs-----
X0: XOR_2 PORT MAP (enable_OUT,Q(0),xor_out(0));
X: for i in 10 downto 0 generate
	X1: XOR_2 PORT MAP(carry(i),Q(i+1),xor_out(i+1));
	end generate;

------using AND gates for carry-----	
A0: AND_2 port map(enable_OUT,Q(0),carry(0));
A: for i in 10 downto 0 generate
	A1: AND_2 port map(carry(i),Q(i+1),carry(i+1));
	end generate;

------using D Flip Flops for memory storage------ 	
D1: for i in 11 downto 0 generate	
	D0: D_FF port map(reset_mux_out(i),clk_out,reset,'1',Q(i),QN(i));
END GENERATE;

---binary to bcd conversion for display purposes----
bcd_convert : binary_to_bcd_4digit port map (Q,BCD_OUT);

----from bcd to SSD display on DE10 Lite Board------
dis_5 <= "1111111";

ssd_convert0 : BCD2SSD port map (BCD_OUT(15 DOWNTO 12),DIS_4,RESET); 
ssd_convert1 : BCD2SSD port map (BCD_OUT(11 DOWNTO 8),DIS_3,RESET); 
ssd_convert2 : BCD2SSD port map (BCD_OUT(7 DOWNTO 4),DIS_2,RESET); 
ssd_convert3 : BCD2SSD port map (BCD_OUT(3 DOWNTO 0),DIS_1,RESET); 

end architecture;