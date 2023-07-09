LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Top_Entity_Game_Connect_4 IS 
	PORT (
		CLK 					 													: IN std_logic; -- Entrada do CLock da FPGA (50MHz)
		Reset_in																	: IN std_logic;					 													
		PLAY																		: IN std_logic; -- Entrada sinal de controle da ativação do jogo
		JOGADA																	: IN std_logic; -- Entrada do Botao1 (Confirm)
		DIREITA																	: IN std_logic; -- Entrada do Botao2 (Escolha)
		LED_IDLE, LED_P1, LED_P2, LED_P1_G, LED_P2_G, LED_EMPATE	: OUT std_logic; -- Saida pro display de 7 segmentos (Para testes)
		R, G, B																	: OUT std_logic_vector(3 DOWNTO 0); -- Saida dos sinais RGB
		HSYNC, VSYNC															: OUT std_logic -- Saida dos syncs verticais e horizontais
        );
END Top_Entity_Game_Connect_4; -- fim da entidade

ARCHITECTURE Top_Entity_Game_Connect_4_arch OF Top_Entity_Game_Connect_4 IS
	--SIGNAL CLK_aux, RESET, PLAY_aux			 		: std_logic;
	SIGNAL Player1_CTRL, Player2_CTRL								: std_logic_vector(41 DOWNTO 0);
	SIGNAL Player1_DISPLAY, Player2_DISPLAY						: std_logic_vector(41 DOWNTO 0);
	SIGNAL Player_1, Player_2, Tabuleiro_aux						: std_logic_vector(41 DOWNTO 0);
	SIGNAL Player_1_Preview, Player_2_Preview						: std_logic_vector(6 DOWNTO 0);
	SIGNAL KEY_shift														: std_logic;
	SIGNAL KEY_confirm													: std_logic;
	SIGNAL KEYS_aux														: std_logic_vector(3 DOWNTO 0);
	SIGNAL S_aux															: std_logic_vector(3 downto 0);
	SIGNAL LED1, LED2, LED3, LED4, LED5, LED6 					: std_logic;
	SIGNAL Coluna_confirm    											: std_logic_vector(2 DOWNTO 0);
	SIGNAL Jogada_confirm 												: std_logic;
	SIGNAL EMPATE															: std_logic;
	SIGNAL R_VGA, G_VGA, B_VGA											: STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL HSYNC_VGA, VSYNC_VGA										: std_logic;
	SIGNAL CLK_aux, RESET, PLAY_aux			 						: std_logic;
	SIGNAL bot_rst															: std_logic;
	SIGNAL LED_TESTE_TOP_AUX : STD_LOGIC;
	
	COMPONENT VGA IS
	PORT(
	CLOCK_24				: IN STD_LOGIC_VECTOR(1 downto 0);
	VGA_HS,VGA_VS		: OUT STD_LOGIC;
	VGA_R,VGA_G,VGA_B	: OUT STD_LOGIC_VECTOR(3 downto 0);
	Player1_IN_VGA			: IN STD_LOGIC_VECTOR (41 DOWNTO 0);
	Player2_IN_VGA			: IN STD_LOGIC_VECTOR (41 DOWNTO 0);
	Player1_Preview		: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
	Player2_Preview		: IN STD_LOGIC_VECTOR (6 DOWNTO 0)
	);
	END COMPONENT;
	
	COMPONENT Controle IS 
	PORT (
		CLK_IN 				: IN std_logic; -- Clock de entrada (Reduzido)
		RESET					: IN std_logic; -- Reset de todas as posições
		Botao_Direita		: IN std_logic; -- Entrada do Botao de movimento (Escolha)
		Botao_Jogada		: IN std_logic; -- Confirm / Enter
		Player_1_IN			: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 1
		Player_2_IN			: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 2
		--Jogador				: OUT std_logic; -- 0 = vermelho | 1 = amarelo -- Define o jogador atual
		Player_1_Preview	: OUT std_logic_vector(6 DOWNTO 0);
		Player_2_Preview	: OUT std_logic_vector(6 DOWNTO 0);
		Jogada_habilitada	: OUT std_logic;
		Coluna_confirmada : OUT std_logic_vector(2 DOWNTO 0)
	--LED_TESTE : OUT STD_LOGIC	--  Coluna de saída
        );
END COMPONENT;
	COMPONENT SYNC IS
	PORT(
	CLK					: IN STD_LOGIC;
	KEYS					: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
	S						: IN STD_LOGIC_VECTOR (3 downto 0);
	Player1_IN			: IN STD_LOGIC_VECTOR (41 DOWNTO 0);
	Player2_IN			: IN STD_LOGIC_VECTOR (41 DOWNTO 0);
	Player1_Choice		: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
	Player2_Choice		: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
	HSYNC, VSYNC		: OUT STD_LOGIC;
	R, G, B				: OUT STD_LOGIC_VECTOR(3 downto 0)
	);

END COMPONENT;

	COMPONENT TABULEIRO IS 
	PORT (
		Player_1 		: IN std_logic_vector(41 DOWNTO 0); -- entrada da posição das jogadas do Player 1
		Player_2 		: IN std_logic_vector(41 DOWNTO 0); -- entrada da posição das jogadas do Player 2
		Tabuleiro_OUT 	: OUT std_logic_vector(41 DOWNTO 0);
		Empate_OUT		: OUT std_logic
			 );
END COMPONENT;

	COMPONENT Motor_jogo IS 
	PORT (
		CLK_IN 			: IN std_logic; -- clock de entrada
		RESET_IN			: IN std_logic;
		Enable			: IN std_logic; -- PLAY / PAUSE
		Jogada_confirmada : IN std_logic;
		Player_1 		: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 1
		Player_2 		: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 2 
		Player_1_OUT 	: OUT std_logic_vector(41 DOWNTO 0); -- Saida da posição das jogadas do Player 1
		Player_2_OUT 	: OUT std_logic_vector(41 DOWNTO 0); -- Saida da posição das jogadas do Player 2 
		LED_1, LED_2, LED_3, LED_4, LED_5, LED_6	: OUT std_logic;	-- Saida dos estados da máquina de estados para os (LEDs)
		RESET_Jogo				: OUT std_logic -- Sinal para Reset de todas as posições
			
        ); 
END COMPONENT;

	COMPONENT Logica_do_Jogo IS 
	PORT (
		CLK_IN 				: IN std_logic; -- Clock de entrada (Reduzido)
		RESET					: IN std_logic; -- Reset de todas as posições
		Coluna_confirmada : IN std_logic_vector(2 DOWNTO 0);
		Jogada_confirmada	: IN std_logic;		 -- jogada confirmada
		Player_1_IN			: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 1
		Player_2_IN			: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 2
		Player_1_OUT		: OUT std_logic_vector(41 DOWNTO 0);-- Entrada da posição das jogadas do Player 1
		Player_2_OUT		: OUT std_logic_vector(41 DOWNTO 0) -- Entrada da posição das jogadas do Player 2
        );
END COMPONENT;

COMPONENT DivisorDeClock is
    generic(
	    freq_clock_in : integer := 50_000_000;
		 freq_clock_out : integer := 1_024
		 );
	 port(
	    clock_in: in std_logic;
		clock_out: out std_logic
		 );
END COMPONENT;

BEGIN
		
		PLAY_aux <= PLAY;
		--Player1_CTRL <= Player_1;
		--Player2_CTRL <= Player_2;
		KEY_shift <= DIREITA;
		KEY_confirm <= JOGADA;
		LED_IDLE <= LED1;
		LED_P1 <= LED2;
		LED_P2 <= LED3; 
		LED_P1_G <= LED4; 
		LED_P2_G <= LED5; 
		LED_EMPATE <= LED6;
		bot_rst <= Reset_in;
		--LED_TESTE_TOP <= LED_TESTE_TOP_AUX;
		
		
		CLOCK_1 : DivisorDeClock
		PORT MAP(CLK, CLK_aux);
		
		STATE_MACHINE : Motor_jogo
		PORT MAP(CLK_aux, bot_rst, PLAY_aux, Jogada_confirm ,Player1_DISPLAY, Player2_DISPLAY,  Player1_CTRL, Player2_CTRL, LED1, LED2, LED3, LED4, LED5, LED6, RESET);
		
		LOGICA_1 : Logica_do_Jogo
		PORT MAP(CLK_aux, bot_rst, Coluna_confirm, Jogada_confirm, Player1_CTRL , Player2_CTRL, Player1_DISPLAY, Player2_DISPLAY);
		
		CONTROLE_1 : Controle
		PORT MAP(CLK_aux, bot_rst, KEY_shift, KEY_confirm, Player1_CTRL, Player2_CTRL, Player_1_Preview, Player_2_Preview, Jogada_confirm, Coluna_confirm);

		VGA_1 : VGA
		PORT MAP('0'& CLK , HSYNC_VGA, VSYNC_VGA, R_VGA, G_VGA, B_VGA, Player1_DISPLAY, Player2_DISPLAY, Player_1_Preview, Player_2_Preview);
		
		R <= R_VGA;
		G <= G_VGA;
		B <= B_VGA;
		HSYNC <= HSYNC_VGA;
		VSYNC <= VSYNC_VGA;

END ARCHITECTURE;
