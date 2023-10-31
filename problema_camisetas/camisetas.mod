param custoNorm;
param custoExtra;
param custoDuasUltimas; # custo de produção das duas últimas semanas
param custoArm; # custo de armazenamento por semana
param capacidadeNormal;
param capacidadeExtra;

set S; # semanas
set SExtra; # semanas com produção extra

param demanda{S};

var x{S} >= 0; # produzidas normaois
var y{SExtra} >= 0; # produzidas extra - primeiras semanas
var s{S} >= 0; # estoque

minimize Ct: # custo total
  sum{i in SExtra} (custoNorm * x[i] + custoExtra * y[i]) # custo de produção
  + sum{i in 3..4} (custoDuasUltimas * x[i]) # custo de produção das duas semanas finais
  + sum{i in S} (custoArm * s[i]); # csuto estoque

subj to demandaSemana1{t in S: t = 1}: 
    x[t] + y[t] - s[t] = demanda[t]; # demanda da semana 1
subj to demandaSemana2{t in S: t > 1 and t <= 2}: 
    x[t] + y[t] + s[t-1] - s[t] = demanda[t]; # demanda da semana 2
subj to demandaSemana34{t in S: t > 2}: 
    x[t] + s[t-1] - s[t] = demanda[t]; # demanda semana 3 e 4
subj to capProdN{t in S}: x[t] <= capacidadeNormal;
subj to capProdE{t in SExtra}: y[t] <= capacidadeExtra;

end;

