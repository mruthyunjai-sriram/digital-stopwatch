library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- required libraries
use IEEE.NUMERIC_STD.ALL;

entity Stopwatch_main is
    Port ( CLK : in STD_LOGIC;-- system clock that runs at 100 MHz
           RST : in STD_LOGIC;-- reset button 
           S1 : in STD_LOGIC;-- the start button
           S2 : in STD_LOGIC; --the stop button
           segments : out STD_LOGIC_VECTOR ( 6 downto 0 ); -- segments a-g that becomes the output of the system
           Anodes : out STD_LOGIC_VECTOR ( 3 downto 0 );-- output that declares which digit of the 7-segment display is being displayed
           DP : out STD_LOGIC );-- decimal point of the 7-segment display

end Stopwatch_main;

architecture Behavioral of Stopwatch_main is

    --the clock divider
    component ClkDivider port ( CLK: in STD_LOGIC;
                                Divisor : in STD_LOGIC_VECTOR ( 31 downto 0 );
                                CLKOUT : out STD_LOGIC );
    end component;
    
    -- 7-segment display driver
    component SSDDriver port ( D0, D1, D2, D3 : in STD_LOGIC_VECTOR ( 3 downto 0 );
                               CLK : in STD_LOGIC;
                               DP : out STD_LOGIC;
                               Anodes, temp : out STD_LOGIC_VECTOR ( 3 downto 0 ) );
    end component;
    
    -- digit counter
    component Digits port ( S, RST, CLK : in STD_LOGIC;
                            N : out STD_LOGIC;
                            D : out STD_LOGIC_VECTOR ( 3 downto 0 ) );
    end component;
    
    -- 7-segmennt display encoder
    component SevSegmentDisplayModule port ( digit : in STD_LOGIC_VECTOR ( 3 downto 0 );
                                             Segs : out STD_LOGIC_VECTOR ( 6 downto 0 ) );
    end component;
    
    signal CLKINA, CLKIN0, S10, N0, N1, N2, N3 : STD_LOGIC := '0'; -- signals used in this module all initialized to '0'
    signal temp, D0, D1, D2, D3 : STD_LOGIC_VECTOR ( 3 downto 0 ); -- signals to transfer to values of digits between modules

begin
    
    process ( CLKINA )
    
    begin

        if ( rising_edge ( CLKINA ) ) then
            if S1 = '1' then 
                S10 <= '1'; --starts the stopwatch
                
            elsif S2 = '1' then
                S10 <= '0'; -- pauses the stopwatch
                
            end if;
            
        end if;
    
    end process;
    
    ClkA : ClkDivider port map ( CLK => CLK, Divisor => x"000186A0", CLKOUT => CLKINA ); -- creates 500 Hz clock
    
    Clk0 : ClkDivider port map ( CLK => CLK, Divisor => x"0007A120", CLKOUT => CLKIN0 ); -- creates 100 Hz clock
    
    Digit0 : Digits port map ( CLK => CLKIN0, RST => RST, S => S10, D => D0, N => N1 ); -- counts for the first digit
    
    Digit1 : Digits port map ( CLK => N1, RST => RST, S => S10, D => D1, N => N2 ); -- counts for the second digit
    
    Digit2 : Digits port map ( CLK => N2, RST => RST, S => S10, D => D2, N => N3 ); -- counts for the third digit
    
    Digit3 : Digits port map ( CLK => N3, RST => RST, S => S10, D => D3, N => N0 ); -- counts for the fourth digit
    
    Driver : SSDDriver port map ( D0 => D0, D1 => D1, D2 => D2, D3 => D3, CLK => CLKINA, DP => DP, Anodes => Anodes, temp => temp ); -- determines which digit is being displayed
    
    Display : SevSegmentDisplayModule port map ( digit => temp, Segs => segments ); -- encodes the digits so that they are displayed on the board correctly
    
end Behavioral;