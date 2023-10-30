# variaveis
var x1 >= 0;  # Qtd de chapas cortadas - matriz 1
var x2 >= 0;  # Qtd de chapas cortadas - matriz 2
var x3 >= 0;  # Qtd de chapas cortadas - matriz 3
var x4 >= 0;  # qtd de chapas cortadas - matriz 4

# f. objetivo
minimize custo: x1 + 2*x2 + 3*x3 + 2*x4;

# restrições
# matriz 1 corta 8 chapas de 0,25m, mtriz 2 corta 4 de 0,25m, matirz 3 corta 2 de 0,25m
s.t. panelas_medias: 8*x1 + 4*x2 + 2*x3 >= 500;

# matriz 2 pode cortar 1 de 0,4m, a matriz 3 corta 2 chapas de 0,4m e matriz 4 corta 3 de 0,4m
s.t. panelas_grandes: x2 + 2*x3 + 3*x4 >= 350;


# para exibir sem precisar de aquela coisa toda lá, roda direto com o solve e printa no final
#solve;
# 
# printf "Quantidade de chapas cortadas - matriz 1: %g\n", x1;
# printf "Quantidade de chapas cortadas - matriz 2: %g\n", x2;
# printf "Quantidade de chapas cortadas - matriz 3: %g\n", x3;
# printf "Quantidade de chapas cortadas - matriz 4: %g\n", x4;
# printf "Custo mínimo total: %g\n", custo;

end;
