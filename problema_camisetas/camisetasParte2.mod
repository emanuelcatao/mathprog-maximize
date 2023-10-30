param custoNorm;
param custoExtra;
param custoDuasUltimas;
param custoArm;

set S := 1..4;
set TIMES := {"TimeA", "TimeB", "TimeC", "TimeD"}; #aqui tem que ser string para definir o nome das variáveis
set SExtra := 1..2;

param preco{T in TIMES, i in S};
param demanda{T in TIMES, i in S}; 

var x{T in TIMES, i in S} >= 0; #quantidade de camisetas produzidas do time T na semana i
var y{T in TIMES, i in SExtra} >= 0;  #quantidade de camisetas produzidas extra do time T na semana i
var v{T in TIMES, i in S} >= 0;  #quantidade de camisetas vendidas do time T na semana i

# maximizar lucro
maximize Lucro:
    sum{T in TIMES, i in S} (preco[T,i] * v[T,i] - custoNorm * x[T,i])
    + sum{T in TIMES, i in SExtra} (preco[T,i] * v[T,i] - custoExtra * y[T,i])
    - sum{T in TIMES, i in 3..4} (custoDuasUltimas * x[T,i])
    - sum{T in TIMES, i in S} (custoArm * (x[T,i] + (if i <= 2 then y[T,i] else 0) - v[T,i]));

# de demanda
subj to r_demanda{T in TIMES, i in S}: 
    v[T,i] <= demanda[T,i];

# de produção
subj to prodN{T in TIMES, i in S}: 
    x[T,i] <= 25000;

#de producao extra
subj to prodE{T in TIMES, i in SExtra}: 
    y[T,i] <= 10000;

# vendas <= produção
subj to venda_menor_prod{T in TIMES, i in S}: 
    v[T,i] <= x[T,i] + (if i <= 2 then y[T,i] else 0); #esse if aí é só para não dar erro no range

end;

