# O Problema das Camisetas

## Variáveis de Decisão
$x_t$: Número de camisetas produzidas na semana `t` (t = 1,2,3,4).

$y_t$: Número de camisetas em excesso produzidas na semana `t` (t = 1,2,3,4).

## Função Objetivo
Minimizar o custo total de produção e estocagem.

$Min_z = 2.00(x_1 + x_2) + 2.52(x_3 + x_4) + 2.80(y_1 + y_2 + y_3 + y_4) + 0.20s_1 + 0.20s_2 + 0.20s_3 + 0.20s_4$

## Restrições:
1) De capacidade produtiva:

    $x_1 + y_1 <= 25,000 + 10,000 \hspace{0.5cm} (\text{semana 1})\\
x_2 + y_2 <= 25,000 + 10,000 \hspace{0.5cm} (\text{semana 2})\\
x_3 <= 25,000 \hspace{2.7cm} (\text{semana 3})\\
x_4 <= 25,000 \hspace{2.7cm} (\text{semana 4})$

2) De demanda:
  
   $x_1 = 5,000\\
x_2 = 10,000\\
x_3 = 30,000\\
x_4 = 60,000\\
$

3) De estoque:

    $s_t = (x_t + y_t) - demanda_t, \text{para }t = 1,2,3,4$

