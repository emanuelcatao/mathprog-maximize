param custoNorm;
param custoExtra;
param custoDuasUltimas;
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
var v{T in TIMES, i in S} >= 0; # quantidade de camisetas vendidas do time T na semana i
var estoque{T in TIMES, i in S} >= 0; # quantidade de camisetas em estoque do time T na semana i
var excedente{T in TIMES, i in S} >= 0;

# maximizar lucro
maximize Lucro:
    sum{T in TIMES, i in S} (preco[T,i] * v[T,i] - custoNorm * x[T,i]) # preço liquido das camisetas sem1 e sem2
    + sum{T in TIMES, i in SExtra} (preco[T,i] * v[T,i] - custoExtra * y[T,i]) # preço liquido das camisetas prodE
    - sum{T in TIMES, i in inicioSemanasFinais..fimSemanasFinais} (custoDuasUltimas * x[T,i]) # custo fabricao semanas 3 e 4
    - sum{T in TIMES, i in S} (custoArm * estoque[T,i]); # custo total de armazenamento 


# Atualização do estoque
subj to atualiza_estoque{T in TIMES, i in S}:
  estoque[T,i] = (if i == 1 then 0 else estoque[T,i-1]) + x[T,i] + (if i <= fimSemanasIniciais then y[T,i] else 0) - v[T,i];
# o estoque e atualizado semana a semana, cada time tem um estoque de camisetas, ele e resultado
# da soma do estoque do mes anterior com o excedente do mes atual (note que se o excedente e negativo
#temos que o estoque sera reduzido.

# de demanda (nao da para vender mais do que a demanda)
subj to r_demanda{T in TIMES, i in S}: 
    v[T,i] <= demanda[T,i];

# de produção (não dá para produzir mais do que a capacidade normal)
subj to prodN{i in S}: 
    sum{T in TIMES} x[T,i] <= capacidadeNormal;

# de produção extra (não dá para produzir mais extras do que a capacidade extra)
subj to prodE{i in SExtra}: 
    sum{T in TIMES} y[T,i] <= capacidadeExtra;

# de estoque e producao (nao da para vender mais do que o estoque + producao)
subj to venda_estoque_prod{T in TIMES, i in S}:
  v[T,i] <= x[T,i] + (if i <= fimSemanasIniciais then y[T,i] else 0) + (if i > 1 then estoque[T,i-1] else 0);


end;

