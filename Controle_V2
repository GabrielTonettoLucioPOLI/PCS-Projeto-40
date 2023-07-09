LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Controle IS 
	PORT (
		CLK_IN 				: IN std_logic; -- Clock de entrada (Reduzido)
		RESET					: IN std_logic; -- Reset de todas as posições
		Botao_Direita		: IN std_logic; -- Entrada do Botao de movimento (Escolha)
		Botao_Jogada		: IN std_logic; -- Confirm / Enter
		Player_1_IN			: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 1
		Player_2_IN			: IN std_logic_vector(41 DOWNTO 0); -- Entrada da posição das jogadas do Player 2
		Player_1_Preview	: OUT std_logic_vector(6 DOWNTO 0);
		Player_2_Preview	: OUT std_logic_vector(6 DOWNTO 0);

		--Jogador				: OUT std_logic; -- 0 = vermelho | 1 = amarelo -- Define o jogador atual
		Jogada_habilitada	: OUT std_logic;
		Coluna_confirmada : OUT std_logic_vector(2 DOWNTO 0) --  Coluna de saída
		--LED_TESTE : OUT STD_LOGIC
        );
END CONTROLE;

ARCHITECTURE Controle_arch OF Controle IS

	SIGNAL	Tabuleiro_aux 												: std_logic_vector(41 DOWNTO 0):= (OTHERS => '0'); -- saida da posição das jogadas do Player 2
	SIGNAL	Jogador_aux													: std_logic := '1';
	SIGNAL	Botao_Jogada_aux, Botao_Direita_aux, RESET_aux	: std_logic;
	SIGNAL 	Contador		 												: INTEGER RANGE 0 TO 7 := 0;		
	SIGNAL   Coluna_confirmada_aux            					: std_logic_vector(2 DOWNTO 0):= (OTHERS => '0');
	SIGNAL 	EN 															: std_logic := '1';
	SIGNAL 	Jogada_confirmada_aux									: std_logic;
	SIGNAL 	EMPATE 														: std_logic;
	SIGNAL Player_1_Pre_aux : std_logic_vector(6 DOWNTO 0);
	
	SIGNAL Player_2_Pre_aux : std_logic_vector(6 DOWNTO 0);
	SIGNAL LED_TESTE_AUX : STD_LOGIC;

	COMPONENT TABULEIRO IS 
	PORT (
		Player_1 		: IN std_logic_vector(41 DOWNTO 0); -- entrada da posição das jogadas do Player 1
		Player_2 		: IN std_logic_vector(41 DOWNTO 0); -- entrada da posição das jogadas do Player 2
		Tabuleiro_OUT 	: OUT std_logic_vector(41 DOWNTO 0);
		Empate_OUT		: OUT std_logic
			 );
	END COMPONENT;
	
	BEGIN
	Botao_Jogada_aux <= 	not (Botao_Jogada);
	Botao_Direita_aux <= not (Botao_Direita) OR not (RESET);
	RESET_aux <= not (RESET) OR CLK_IN;
	Coluna_confirmada <= Coluna_confirmada_aux;
	Jogada_habilitada <= Jogada_confirmada_aux;
	--LED_TESTE <= LED_TESTE_AUX;
	
	TABULEIRO1 : TABULEIRO
	PORT MAP(Player_1_IN, Player_2_IN, Tabuleiro_aux, EMPATE);
	

	MOVEMENT: PROCESS (CLK_IN, Botao_Direita_aux, Contador, EN, Jogador_aux, RESET)
BEGIN
	IF not RESET = '1' THEN
  	Contador <= 0;
  END IF;
  IF (EN = '1') THEN
  	IF Contador < 7 THEN
    	IF rising_edge(Botao_Direita_aux) THEN
    	  Contador <= Contador + 1;
    	ELSE
    	  Contador <= Contador;
    	END IF;
    ELSE
    	Contador <= 0;
  	END IF;
	END IF;
	END PROCESS;

	CONFIRM: PROCESS (CLK_IN, Botao_Jogada_aux, Contador, EN, Tabuleiro_aux, Jogador_aux, RESET, Coluna_confirmada_aux)
	BEGIN
	IF rising_edge(CLK_IN) THEN
		IF RESET = '1' THEN
			Coluna_confirmada_aux <= "000";
		END IF;
		IF Botao_Jogada_aux = '1' THEN
			IF Contador = 0 THEN
				IF Tabuleiro_aux(5) = '0' THEN
					Coluna_confirmada_aux <= "001";
					Jogada_confirmada_aux <= '1';
					--LED_TESTE_AUX <= '1';
				ELSIF Tabuleiro_aux(5) = '1' THEN
					Coluna_confirmada_aux <= "000";
					Jogada_confirmada_aux <= '0';
					--LED_TESTE_AUX <= '0';
				END IF;
			ELSIF Contador = 1 THEN
				IF Tabuleiro_aux(11) = '0' THEN
					Coluna_confirmada_aux <= "010";
					Jogada_confirmada_aux <= '1';
					--LED_TESTE_AUX <= '1';
				ELSIF Tabuleiro_aux(11) = '1' THEN
					Coluna_confirmada_aux <= "000";
					Jogada_confirmada_aux <= '0';
					--LED_TESTE_AUX <= '0';
				END IF;
			ELSIF Contador = 2 THEN
				IF Tabuleiro_aux(17) = '0' THEN
					Coluna_confirmada_aux <= "011";
					Jogada_confirmada_aux <= '1';
				ELSIF Tabuleiro_aux(17) = '1' THEN
					Coluna_confirmada_aux <= "000";
					Jogada_confirmada_aux <= '0';
				END IF;
			ELSIF Contador = 3 THEN
				IF Tabuleiro_aux(23) = '0' THEN
					Coluna_confirmada_aux <= "100";
					Jogada_confirmada_aux <= '1';
				ELSIF Tabuleiro_aux(23) = '1' THEN
					Coluna_confirmada_aux <= "000";
					Jogada_confirmada_aux <= '0';
				END IF;
			ELSIF Contador = 4 THEN
				IF Tabuleiro_aux(29) = '0' THEN
					Coluna_confirmada_aux <= "101";
					Jogada_confirmada_aux <= '1';
				ELSIF Tabuleiro_aux(29) = '1' THEN
					Coluna_confirmada_aux <= "000";
					Jogada_confirmada_aux <= '0';
				END IF;
			ELSIF Contador = 5 THEN
				IF Tabuleiro_aux(35) = '0' THEN
					Coluna_confirmada_aux <= "110";
					Jogada_confirmada_aux <= '1';
				ELSIF Tabuleiro_aux(35) = '1' THEN
					Coluna_confirmada_aux <= "000";
					Jogada_confirmada_aux <= '0';
				END IF;
			ELSIF Contador = 6 THEN
				IF Tabuleiro_aux(41) = '0' THEN
					Coluna_confirmada_aux <= "111";
					Jogada_confirmada_aux <= '1';
				ELSIF Tabuleiro_aux(41) = '1' THEN
					Coluna_confirmada_aux <= "000";
					Jogada_confirmada_aux <= '0';
				END IF;
			ELSE
				Coluna_confirmada_aux <= "000";
				Jogada_confirmada_aux <= '0';
			END IF;
	END IF;
	END IF;
END PROCESS;
END ARCHITECTURE; 
