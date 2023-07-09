LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Motor_jogo IS 
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
END ENTITY Motor_jogo;

ARCHITECTURE rtl OF Motor_jogo IS

	TYPE ESTADO IS (IDLE, PLAYER1, PLAYER2, WIN); 
	
	SIGNAL SM_ENGINE 										: ESTADO := IDLE; -- estado inativo/inicial da máquina de estado
	SIGNAL Player_start 									: std_logic;
	SIGNAL Player1_aux, Player2_aux 					: std_logic_vector(41 DOWNTO 0):= (OTHERS => '0');
	SIGNAL EN 												: std_logic;
	SIGNAL Jogada_Player1, Jogada_Player2, Player1_rst, Player2_rst	: std_logic;
	SIGNAL Ganhador1, Ganhador2 						: std_logic:='0';
	SIGNAL Botao_shift									: std_logic;
	SIGNAL Botao_confirm									: std_logic;
	SIGNAL Coluna_atual									: std_logic_vector(2 DOWNTO 0):= (OTHERS => '0');
	SIGNAL Tabuleiro_null 								: std_logic_vector(41 DOWNTO 0):=(OTHERS => '0');
	SIGNAL RST												: std_logic;
	SIGNAL CLOCK											: std_logic;
	SIGNAL P1_Preview										: std_logic_vector(6 DOWNTO 0);
	SIGNAL P2_Preview										: std_logic_vector(6 DOWNTO 0);
	SIGNAL EMPATE											: std_logic;
	SIGNAL reset_in_aux									: std_logic;
	signal jogada_confirm_aux  						: std_logic;
	signal empate_tester : std_logic:='0';
	
		
	COMPONENT Teste_Ganhador IS 
	PORT (
		Jogada 			: IN std_logic_vector(41 DOWNTO 0); -- entrada da posição das jogadas do Player
		GANHADOR_OUT 	: OUT std_logic
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
	
	

	
	--COMPONENT Controle IS 
	--PORT (
	--	CLK_IN 				: IN std_logic; -- Clock de entrada (Reduzido)
	--	RESET					: IN std_logic; -- Reset de todas as posições
	--	Botao_Direita		: IN std_logic; -- Entrada do Botao de movimento (Escolha)
	--	Botao_Jogada		: IN std_logic; -- Confirm / Enter
	--	Player_1_IN			: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 1
	--	Player_2_IN			: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 2
	--	Jogador				: OUT std_logic; 							-- 0 = vermelho | 1 = amarelo -- Define o jogador atual
	--	Coluna_confirmada : OUT std_logic_vector(6 DOWNTO 0) 	--  Coluna de saída
   --     );
	--END COMPONENT;
	
	--COMPONENT Logica_do_Jogo IS 
	--PORT (
	--	CLK_IN 				: IN std_logic; -- Clock de entrada (Reduzido)
	--	RESET					: IN std_logic; -- Reset de todas as posições
	--	Coluna_confirmada : IN std_logic_vector(2 DOWNTO 0);
	--	EN						: IN std_logic;		 -- jogada confirmada
	--	Player_1_IN			: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 1
	--	Player_2_IN			: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 2
	--	Player_1_OUT		: OUT std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 1
	--	Player_2_OUT		: OUT std_logic_vector(41 DOWNTO 0) -- Entrada da posição das jogadas do Player 2
        --);
--END COMPONENT;

	BEGIN
	--Teste_Ganhador_1 : Teste_Ganhador
	--PORT MAP(Player1_aux, Ganhador1);
	--Teste_Ganhador_2 : Teste_Ganhador
	--PORT MAP(Player2_aux, Ganhador2);
	
	--JOGADOR_C : Controle --Define em qual coluna estamos para os dois jogadores 
	--PORT MAP(CLOCK, RST, Botao_shift, Botao_confirm, Player1_aux, Player2_aux, P1_Preview, P2_Preview, Player_start, Coluna_atual);
	
	
	--JOGADOR_1_L : Logica_do_Jogo --Define em qual coluna estamos
	--PORT MAP(CLK_IN, RST, Coluna_atual,EN, Player1_aux, Player2_aux,  );

	
	JOGADAS : Tabuleiro
	PORT MAP(Player1_aux, Player2_aux, Tabuleiro_null, EMPATE);
	
	
	reset_in_aux <= RESET_IN;

	Player1_rst <= EMPATE;

	Player2_rst <= EMPATE;
	 
	
	PROCESS (EN, Jogada_Player1, Jogada_Player2, jogada_confirm_aux)
	BEGIN
	
		EN 	<= Enable AND CLK_IN;
		CLOCK <= CLK_IN;
		RESET_Jogo <= RST;
		
		--Player1_aux <= Player_1;
		--Player2_aux <= Player_2;

		
		IF rising_edge(EN) THEN
			Player_1_OUT <= Player1_aux;
			Player_2_OUT <= Player2_aux;
			Player_start <= '0';
			jogada_confirm_aux <= Jogada_confirmada;

			
			CASE SM_ENGINE IS -- definição do estado inicial da máquina de estados
			
				WHEN IDLE =>
					LED_1 <= '1'; --LED IDLE
					LED_2 <= '0';
					LED_3 <= '0';
					LED_4 <= '0';
					LED_5 <= '0';
					LED_6 <= '0';
					
					IF reset_in_aux = '1' THEN --resetinaux
						Player1_aux <= (OTHERS => '0');
						Player2_aux <= (OTHERS => '0');
						RST <= '1';
							IF Player_start = '0' then
								SM_ENGINE <= PLAYER1;
							elsif Player_start = '1' then
								SM_ENGINE <= PLAYER2;
							end if;
							
					ELSE
						Player1_aux <= (OTHERS => '0');
						Player2_aux <= (OTHERS => '0');
						SM_ENGINE <= IDLE;
					END IF;
					
					
				WHEN PLAYER1 =>
					Player_1_OUT <= Player1_aux;
					Player_2_OUT <= Player2_aux;
					LED_2 <= '1'; -- LED P1
					LED_1 <= '0';
					LED_3 <= '0';
					LED_4 <= '0';
					LED_5 <= '0';
					LED_6 <= '0';
					IF reset_in_aux = '1' THEN --resetinaux
						Player1_aux <= (OTHERS => '0');
						Player2_aux <= (OTHERS => '0');
						RST <= '1';
						SM_ENGINE <= IDLE;
					end if;
					IF Player_start = '0' and jogada_confirm_aux = '1' THEN
						Player1_aux <= Player_1 OR Player1_aux;
						Player_start <= '1';
						jogada_confirm_aux <= '0';
						SM_ENGINE <= WIN; -- TESTE GANHADOR DENTRO DESTE ESTADO
					ELSE
						SM_ENGINE <= PLAYER1;
					END IF;
				
				WHEN PLAYER2 =>
					Player_1_OUT <= Player1_aux;
					Player_2_OUT <= Player2_aux;
					LED_3 <= '1'; -- led P2
					LED_2 <= '0';
					LED_1 <= '0';
					LED_4 <= '0';
					LED_5 <= '0';
					LED_6 <= '0';
					IF reset_in_aux = '1' THEN --resetinaux
						Player1_aux <= (OTHERS => '0');
						Player2_aux <= (OTHERS => '0');
						RST <= '1';
						SM_ENGINE <= IDLE;
					end if;
					IF Player_start = '1' and jogada_confirm_aux = '1' THEN
						Player2_aux <= Player_2 OR Player2_aux;
						Player_start <= '0';
						SM_ENGINE <= WIN;
						jogada_confirm_aux <= '0';
					ELSE
						SM_ENGINE <= PLAYER2;
					END IF;	
				
					
					
				WHEN WIN =>
				RST <= '0';
				IF Ganhador1 = '1' AND Ganhador2 = '0' THEN
					LED_4 <= '1'; -- led P1 GANHA
					LED_2 <= '0';
					LED_3 <= '0';
					LED_1 <= '0';
					LED_5 <= '0';
					LED_6 <= '0';
					RST <= '1';
					SM_ENGINE <= IDLE;
				ELSIF Ganhador2 = '1' AND Ganhador1 = '0' THEN
					LED_5 <= '1'; -- LED P2 GANHA
					LED_2 <= '0';
					LED_3 <= '0';
					LED_4 <= '0';
					LED_1 <= '0';
					LED_6 <= '0';
					RST <= '1';
					SM_ENGINE <= IDLE;
				ELSIF EMPATE = '1' THEN -- Talvez mudar o win tester com portmap do tabuleiro pra fazer um sinal de empate, em vez de acender os dois
					LED_6 <= '1'; --LED EMPATA
					LED_2 <= '0';
					LED_3 <= '0';
					LED_4 <= '0';
					LED_5 <= '0';
					LED_1 <= '0';
					RST <= '1';
					SM_ENGINE <= IDLE;
				ELSE 
					IF Player_start = '0' THEN
						SM_ENGINE <= PLAYER2;
					ELSE
						SM_ENGINE <= PLAYER1;
					END IF;
				END IF;
			WHEN OTHERS =>
					SM_ENGINE <= IDLE;

            END CASE;
	end if;
	END PROCESS;
END ARCHITECTURE;
