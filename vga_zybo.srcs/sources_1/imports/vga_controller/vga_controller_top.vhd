
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity vga_controller_top is

--	generic (
--			red_width : integer;
--			green_width : integer;
--			blue_width : integer
--			);
			
	port(
		clk : in std_logic;
		rst : in std_logic;
		sw : in std_logic_vector(2 downto 0);
		red : out std_logic_vector(4 downto 0);
		green : out std_logic_vector(5 downto 0);
		blue : out std_logic_vector(4 downto 0);
		h_sync : out std_logic;
		v_sync : out std_logic
		--display_enable : out std_logic
		);
		
end entity;

architecture arch of vga_controller_top is

	component vga_controller is
		port(
			pclk : in std_logic;
			locked : in std_logic;
			rst : in std_logic;
			h_sync : out std_logic;
			v_sync : out std_logic;
			display_enable : out std_logic
			);
	end component;
	
	component clk_2_pclk is
	   port(
	       clk : in std_logic;
	       reset : in std_logic;
	       pclk : out std_logic;
	       locked : out std_logic
	       );
	end component;

    signal pclk : std_logic;
    signal locked : std_logic;
	signal s_red : std_logic_vector(4 downto 0);
	signal s_green : std_logic_vector(5 downto 0);
	signal s_blue : std_logic_vector(4 downto 0);
	signal s_disp_en : std_logic;
	
begin

	vga_cntrl:
	component vga_controller
		port map(
				pclk => pclk,
				locked => locked,
				rst => rst,
				h_sync => h_sync,
				v_sync => v_sync,
				display_enable => s_disp_en
				);
				
	pclk_gen:
	component clk_2_pclk
	   port map(
	           clk => clk,
	           reset => rst,
	           pclk => pclk,
	           locked => locked
	           );
				
	rgb_pattern:
	process(sw) is
	begin
		case sw is
			when "000" => 
				s_red <= (others => '0');
				s_green <= (others => '0');
				s_blue <= (others => '0');
			when "001" => 
				s_red <= (others => '0');
				s_green <= (others => '0');
				s_blue <= (others => '1');
			when "010" => 
				s_red <= (others => '0');
				s_green <= (others => '1');
				s_blue <= (others => '0');
			when "011" => 
				s_red <= (others => '0');
				s_green <= (others => '1');
				s_blue <= (others => '1');
			when "100" => 
				s_red <= (others => '1');
				s_green <= (others => '0');
				s_blue <= (others => '0');
			when "101" => 
				s_red <= (others => '1');
				s_green <= (others => '0');
				s_blue <= (others => '1');
			when "110" => 
				s_red <= (others => '1');
				s_green <= (others => '1');
				s_blue <= (others => '0');
			when "111" => 
				s_red <= (others => '1');
				s_green <= (others => '1');
				s_blue <= (others => '1');
			when others =>
				null;
		end case;
	end process rgb_pattern;
	
	red <= s_red when (s_disp_en = '1') else
		   (others => '0');
		   
	green <= s_green when (s_disp_en = '1') else
			 (others => '0');
	
	blue <= s_blue when (s_disp_en = '1') else
			(others => '0');

	-- rgb_out:
	-- process(s_disp_en) is
	-- begin
		-- if s_disp_en = '0' then
			-- red <= (others => '0');
			-- green <= (others => '0');
			-- blue <= (others => '0');
		-- else
			-- red <= s_red;
			-- green <= s_green;
			-- blue <= s_blue;
		-- end if;
	-- end process rgb_out;
	
	--display_enable <= s_disp_en;

end arch;