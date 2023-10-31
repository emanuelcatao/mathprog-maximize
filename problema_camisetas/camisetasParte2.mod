param custoNorm;
param custoExtra;
param custoSemanasFinais;
param custoArm;
param capacidadeNormal;
param capacidadeExtra;

param inicioSemanasFinais;
param fimSemanasFinais;
param fimSemanasIniciais;

set S;
set TIMES;
set SExtra;

param preco{T in TIMES, i in S};
param demanda{T in TIMES, i in S};

var x{T in TIMES, i in S} >= 0; # quantidade de camisetas produzidas do time T na semana i
var y{T in TIMES, i in SExtra} >= 0; # quantidade de camisetas produzidas extra do time T na semana i
var vendas{T in TIMES, i in S} >= 0;
var estoque{T in TIMES, i in S} >= 0; # quantidade de camisetas em estoque do time T na semana i

# maximizar lucro
maximize Lucro:
  sum{T in TIMES, i in 1..fimSemanasIniciais} (preco[T,i] * vendas[T,i] - custoNorm * x[T,i] - custoArm * estoque[T,i] - custoExtra * y[T,i])
  + sum{T in TIMES, i in inicioSemanasFinais..fimSemanasFinais} (preco[T,i] * x[T,i] - (custoSemanasFinais * x[T,i]) - (custoArm * estoque[T,i]));


# Atualização do estoque
subj to atualiza_estoque{T in TIMES, i in S}:
  estoque[T,i] = (if i == 1 then 0 else estoque[T,i-1]) + x[T,i] + (if i <= fimSemanasIniciais then y[T,i] else 0) - vendas[T,i];

# o estoque e atualizado semana a semana, cada time tem um estoque de camisetas, ele e resultado
# da soma do estoque do mes anterior com o excedente do mes atual (note que se o excedente e negativo
#temos que o estoque sera reduzido.

# de demanda (nao da para vender mais do que a demanda)
subj to restr_vendas1{T in TIMES, i in S}:
  vendas[T,i] <= demanda[T,i];

# de produção (não dá para produzir mais do que a capacidade normal)
subj to prodN{i in S}: 
    sum{T in TIMES} x[T,i] <= capacidadeNormal;

# de produção extra (não dá para produzir mais extras do que a capacidade extra)
subj to prodE{i in SExtra}: 
    sum{T in TIMES} y[T,i] <= capacidadeExtra;

# de estoque e producao (nao da para vender mais do que o estoque + producao)
subj to venda_estoque_prod{T in TIMES, i in S}:
  vendas[T,i] <= x[T,i] + (if i <= fimSemanasIniciais then y[T,i] else 0) + (if i > 1 then estoque[T,i-1] else 0);


end;

