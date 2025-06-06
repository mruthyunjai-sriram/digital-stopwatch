library IEEE;
use IEEE.STD_LOGIC_1164.ALL; -- required libraries
use IEEE.NUMERIC_STD.ALL;

entity SSDDriver is
    Port ( D0 : in STD_LOGIC_VECTOR (3 downto 0); -- first digit
           D1 : in STD_LOGIC_VECTOR (3 downto 0); -- second digit
           D2 : in STD_LOGIC_VECTOR (3 downto 0); -- third digit
           D3 : in STD_LOGIC_VECTOR (3 downto 0); -- fourth digit
           CLK : in STD_LOGIC; -- input clock
           DP : out STD_LOGIC; -- output for the decimal point
           Anodes : out STD_LOGIC_VECTOR (3 downto 0); -- output that determines which digit is displayed
           temp : out STD_LOGIC_VECTOR (3 downto 0)); -- temp is the single output digit depending on 2-bit control input SEL
end SSDDriver;

architecture Behavioral of SSDDriver is

begin
    process (CLK) 
    
        variable SEL : unsigned (1 downto 0) := "00"; -- control input
        
    begin
    
        if (rising_edge(CLK)) then -- multiplexer
            case SEL is
            
                when "00" => temp <= D0; -- dispalys hundredths place
                    Anodes <= "1110";--displays right-most digit
                    DP <= '1'; -- decimal point off
                    SEL := SEL + 1; -- count up
                    
                when "01" => temp <= D1; -- displays tenths place
                    Anodes <= "1101"; -- displays middle-right digit
                    DP <= '1'; -- decimal point off
                    SEL := SEL + 1; -- count up
                        
                when "10" => temp <= D2; -- displays ones place
                    Anodes <= "1011"; -- displays middle-left digit
                    DP <= '0'; -- decimal point on
                    SEL := SEL + 1; -- counts up
                    
                when others => temp <= D3; -- displays tens place
                    Anodes <= "0111"; -- displays left-most digit
                    DP <= '1'; -- decimal point off
                    SEL := "00"; -- reset count back to 0
            end case;
            
        end if;
        
    end process;

end Behavioral;