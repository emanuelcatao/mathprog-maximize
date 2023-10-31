# O Problema das Camisetas

## Parte 1:

### Variáveis de Decisão
$x_t$: Número de camisetas produzidas na semana `t` (t = 1,2,3,4).

$y_t$: Número de camisetas extras na semana `t` (t = 1,2).

### Função Objetivo
Minimizar o custo total de produção e estocagem.

$Min_z = 2.00(x_1 + x_2) + 2.50(x_3 + x_4) + 2.80(y_1 + y_2) + 0.20s_1 + 0.20s_2 + 0.20s_3 + 0.20s_4$

### Restrições:
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

## Parte 2:

# Modelo de Programação Linear para Maximizar Lucros

**Objetivo:** Maximizar os lucros totais da produção e venda de camisetas.

**Variáveis de Decisão:**
- $x_{t,i}$: Camisetas do time $i$ produzidas na semana $t$.
- $y_{t,i}$: Camisetas do time $i$ produzidas em horas extras na semana $t$, para $t = 1, 2$.
- $s_{t,i}$: Camisetas do time $i$ estocadas na semana $t$.

**Função Objetivo:**
$$
\max Z = \sum_{t=1}^{4} \sum_{i=A}^{D} \left( v_{t,i} \cdot (x_{t,i} + y_{t,i}) - c_{t} \cdot x_{t,i} - c_{t}^{e} \cdot y_{t,i} - c_{s} \cdot s_{t,i} \right)
$$
Onde:
- $c_{t} = \begin{cases} 2,00, & \text{se } t \leq 2 \\ 2,50, & \text{se } t > 2 \end{cases}$
- $c_{t}^{e} = 2,80$ para $t = 1, 2$
- $c_{s} = 0,20$

**Restrições:**
1. $\sum_{i=A}^{D} x_{t,i} \leq 25,000 \quad \forall t$
2. $\sum_{i=A}^{D} y_{t,i} \leq 10,000 \quad t = 1, 2$
3. $x_{t,i} + y_{t,i} + s_{t-1,i} - s_{t,i} = \text{Demanda do time } i \text{ na semana } t \quad \forall t, i$
4. $s_{0,i} = 0, \quad s_{4,i} = 0 \quad \forall i$
5. $x_{t,i}, y_{t,i}, s_{t,i} \geq 0 \quad \forall t, i$

**Observações:**
- O lucro é calculado a partir da receita de vendas menos os custos.
- O modelo leva em consideração as variações específicas de cada time.

