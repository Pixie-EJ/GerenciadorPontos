CALL prc_add_rule('Por pergunta respondida',  5 , 1);
CALL prc_add_rule('Entrada atrasada ou saída antecipada',  10 , 1);
CALL prc_add_rule('Entrada e saída no horário',  15 , 1);
CALL prc_add_rule('Não participação',  -30 , 1);
CALL prc_add_rule('Por dia de participação em evento', 20 , 1);
CALL prc_add_rule('Por dia de participação ATRASADA em evento',  10 , 1);
CALL prc_add_rule('Participação em task',  30 , 1);
CALL prc_add_rule('Não participação em task',  -30 , 1);
CALL prc_add_rule('A cada 6h em curso finalizado',  15 , 1);