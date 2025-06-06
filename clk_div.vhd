library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- required libraries
use IEEE.NUMERIC_STD.ALL;

entity ClkDivider is
    Port ( CLK : in STD_LOGIC; -- system clock
           Divisor : in STD_LOGIC_VECTOR ( 31 downto 0 ); -- Divisor = ( system frequency / ( 2 * desired clock frequency ) )
           CLKOUT : out STD_LOGIC ); -- resulting clock
end ClkDivider;

architecture Behavioral of ClkDivider is

    signal CLKTOG : STD_LOGIC := '0'; -- toggling signal

begin

    process ( CLK )
    
        variable count : unsigned ( 31 downto 0 ) := x"00000000"; -- variable needed for counter
        
    begin
    
        if ( rising_edge ( CLK ) ) then
            count := count + 1; -- counting
            if ( STD_LOGIC_VECTOR ( count ) = Divisor ) then -- when the counter reaches the value of the divisor
                CLKTOG <= NOT CLKTOG; -- toggling signal toogles its value
                count := x"00000000"; -- counter resets to 0
                
            end if;
            
        end if;
        
    end process;
    
    CLKOUT <= CLKTOG; -- desired clock is the same as the toogling signal

end Behavioral;