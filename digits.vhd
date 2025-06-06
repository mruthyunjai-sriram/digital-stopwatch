library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- required libraries
use IEEE.NUMERIC_STD.ALL;

entity Digits is
    Port ( S : in STD_LOGIC; -- enabling input ('1' is on, '0' is off)
           RST : in STD_LOGIC; -- reset input ('1' is reset, '0' does not change count)
           CLK : in STD_LOGIC; -- clock input used for counter
           N : out STD_LOGIC; -- output that becomes the input clock of the next digit
           D : out STD_LOGIC_VECTOR ( 3 downto 0 ) ); -- binary value of the digit
end Digits;

architecture Behavioral of Digits is

    signal X : STD_LOGIC := '1'; -- initialize X to be '1' because we want the clock input for the next digit to change at when x is '10'

begin

    process ( S, CLK )
    
        variable count : unsigned ( 3 downto 0 ) := x"0"; -- variable needed for counter
    
    begin
        
        if RST = '1' then
            count := x"0"; -- manual reset is indepedent of clock
            X <= '1'; -- re-initializes the clock
        
        elsif ( S = '1' and rising_edge ( CLK ) ) then
            count := count + 1; --counting up
            if ( STD_LOGIC_VECTOR ( count ) = x"A" ) then -- digit reaches value of 10
                count := x"0"; -- counter resets to 0 to begin counting again
                X <= NOT X; -- clock input for the next digit should have its rising edge here
                    
            elsif ( STD_LOGIC_VECTOR ( count ) = x"5" ) then-- digit reaches value of 5
                X <= NOT X; -- clock input for the next digit should have its falling edge here
                    
            end if;
            
        end if;
        
        D <= STD_LOGIC_VECTOR ( count ); --output the binary value of the digit
        N <= X; -- output N becomes the input clock for the next digit
        
    end process;

end Behavioral;