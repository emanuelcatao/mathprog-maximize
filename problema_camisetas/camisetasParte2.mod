param custoNorm;
param custoExtra;
param custoDuasUltimas;
param custoArm;
param capacidadeNormal;
param capacidadeExtra;

set S;
set TIMES;
set SExtra;

param preco{T in TIMES, i in S};
param demanda{T in TIMES, i in S};

var x{T in TIMES, i in S} >= 0; # quantidade de camisetas produzidas do time T na semana i
var y{T in TIMES, i in SExtra} >= 0; # quantidade de camisetas produzidas extra do time T na semana i
var v{T in TIMES, i in S} >= 0; # quantidade de camisetas vendidas do time T na semana i

# maximizar lucro
maximize Lucro:
    sum{T in TIMES, i in S} (preco[T,i] * v[T,i] - custoNorm * x[T,i])
    + sum{T in TIMES, i in SExtra} (preco[T,i] * v[T,i] - custoExtra * y[T,i])
    - sum{T in TIMES, i in 3..4} (custoDuasUltimas * x[T,i])
    - sum{T in TIMES, i in S} (custoArm * (x[T,i] + (if i <= 2 then y[T,i] else 0) - v[T,i]));

# de demanda (nao da para vender mais do que a demanda)
subj to r_demanda{T in TIMES, i in S}: 
    v[T,i] <= demanda[T,i];

# de produção (nao da para produzir mais do que a capacidade normal)
subj to prodN{T in TIMES, i in S}: 
    x[T,i] <= capacidadeNormal;

#de producao extra (nao da para produzir mais extras do que a capacidade extra)
subj to prodE{T in TIMES, i in SExtra}: 
    y[T,i] <= capacidadeExtra;

# vendas <= produção (nao da para vender mais do que eh produzido)
subj to venda_prod{T in TIMES, i in S}: 
    v[T,i] <= x[T,i] + (if i <= 2 then y[T,i] else 0);

end;

