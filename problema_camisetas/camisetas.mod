#so pra dizer que usei .dat
param custoNorm;
param custoExtra;
param custoDuasUltimas; #nome feio, eu sei
param custoArm;

set S := 1..4;
set SExtra := 1..2;

var x{i in S} >= 0; # produzidas normal
var y{i in SExtra} >= 0; # produzidas extra - primeiras semanas
var s{i in S} >= 0; # estoque

#funcao objetivo
minimize Ct:
  sum{i in SExtra} (custoNorm * x[i]) #aqui é o 2*(x[1] + x[2]) em que x[1] é a produção normal da semana 1 e x[2] é a produção normal da semana 2
   + sum{i in SExtra} (custoExtra * y[i]) #aqui é o 2,8*(y[1] + y[2]) em que y[1] é a produção extra da semana 1 e y[2] é a produção extra da semana 2
   + sum{i in 3..4} (custoDuasUltimas * x[i]) #aqui é o 2,5*(x[3] + x[4]) em que x[3] é a produção normal da semana 3 e x[4] é a produção normal da semana 4
   + sum{i in S} (custoArm * s[i]); #aqui é o 0,2*(s[1] + s[2] + s[3] + s[4]) em que s[1] é o estoque da semana 1, s[2] é o estoque da semana 2, s[3] é o estoque da semana 3 e s[4] é o estoque da semana 4

subj to demanda1: x[1] + y[1] - s[1] = 5000;
subj to demanda2: x[2] + y[2] + s[1] - s[2] = 10000;
subj to demanda3: x[3] + s[2] - s[3] = 30000;
subj to demanda4: x[4] + s[3] - s[4] = 60000;

subj to capProdN{i in S}: x[i] <= 25000; #capacidade de producao normal
subj to capProdE{i in SExtra}: y[i] <= 10000; #capacidade de producao extra

end;

