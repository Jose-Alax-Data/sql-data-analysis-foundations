#_______________________________________________________________________
#PROBLEMA 1: Clientes com email válido
#Objetivo: Identificar quantos clientes possuem email preenchido e aparentemente válido.

SELECT 
    COUNT(*) AS 'Clientes com email válido'
FROM
    clientes
WHERE
    COALESCE(TRIM(Email), '') <> ''
        AND Email LIKE '%@%'
        AND Email LIKE '%.com';

-- Validação de email baseada em regras simples (não nulo, contém '@' e '.com')
-- Pode ser aprimorada futuramente com uso de REGEXP para maior precisão


#_______________________________________________________________________
#PROBLEMA 2: Clientes sem email
#Objetivo: Identificar quantos clientes não possuem email cadastrado.

select 
	sum(case 
		when coalesce(trim(Email), '') = ''
        then 1 else 0
    end) as Clientes_sem_email,
    
    sum(case 
		when coalesce(trim(Email), '') <> ''
        and (Email not like '%@%' or Email not like '%.com')
        then 1 else 0
        end) as Clientes_com_email_invalido
        
	from clientes;
    
-- Separação entre clientes sem email e com email inválido
-- Emails ausentes indicam falta de cadastro, enquanto emails inválidos indicam problema de qualidade dos dados
-- Essa distinção permite identificar falhas diferentes e direcionar ações, como atualização cadastral ou correção de informações


#_______________________________________________________________________
#PROBLEMA 3: Clientes com dados padronizados
#Objetivo: Identificar clientes cujo nome e sobrenome seguem um padrão mínimo e possuem email do domínio Yahoo.

SELECT 
    *
FROM
    clientes
WHERE
    LENGTH(TRIM(Nome)) > 3
        AND LENGTH(TRIM(Sobrenome)) > 2
        AND COALESCE(TRIM(Email), '') <> ''
        AND Email LIKE '%@yahoo.com';
        
-- Representa clientes com dados padronizados de nome e sobrenome, além de email válido do domínio Yahoo
-- Utilizado para garantir consistência dos dados e facilitar análises baseadas em clientes com informações confiáveis


#_______________________________________________________________________
#PROBLEMA 4: Clientes com nome incompleto
#Objetivo: Identificar possíveis nomes inválidos ou incompletos na base.

SELECT 
    Nome, Sobrenome
FROM
    clientes
WHERE
    COALESCE(TRIM(Nome), '') = ''
        OR LENGTH(trim(Nome)) < 4
        OR COALESCE(TRIM(Sobrenome), '') = ''; 


-- Nome incompleto impacta na identificação dos funcionários e na integridade e confiabilidade dos dados da empresa.


#_______________________________________________________________________
#PROBLEMA 5: Volume total de vendas
#Objetivo: Calcular o valor total de todos os pedidos realizados.

SELECT 
    SUM(Receita_Venda) AS Total_Vendas
FROM
    pedidos;

-- Representa o faturamento total gerado pelos pedidos
-- Utilizado para avaliar o desempenho financeiro e apoiar decisões estratégicas


#_______________________________________________________________________
#PROBLEMA 6: Quantidade total de pedidos
#Objetivo: Contar o número total de pedidos realizados.

SELECT 
    COUNT(*) AS Quant_pedidos
FROM
    pedidos;

-- Representa a quantidade total de pedidos realizados
-- Utilizado para analisar o volume de vendas e o nível de atividade da empresa


#_______________________________________________________________________
#PROBLEMA 7: Ticket médio dos pedidos
#Objetivo: Calcular a média do valor dos pedidos.

SELECT 
    AVG(Receita_Venda) AS Ticket_Medio
FROM
    pedidos;

-- Representa o valor médio dos pedidos realizados
-- Utilizado para analisar o comportamento de compra e o valor médio gasto por pedido


#_______________________________________________________________________
#PROBLEMA 8: Maior valor de pedido
#Objetivo: Identificar o maior valor registrado entre os pedidos.

SELECT 
    MAX(Receita_Venda) AS Maior_Valor_Vendido
FROM
    pedidos;

-- Representa o maior valor de pedido feito
-- Utilizado para identificar o maior valor de venda registrado


#_______________________________________________________________________
#PROBLEMA 9: Menor valor de pedido
#Objetivo: Identificar o menor valor registrado entre os pedidos.

SELECT 
    MIN(Receita_Venda) AS Menor_Valor_Venda
FROM
    pedidos;

-- Representa o menor valor de pedido feito
-- Utilizado para identificar a menor venda


#_______________________________________________________________________
#PROBLEMA 10: Pedidos acima de 1000
#Objetivo: Identificar pedidos com valor superior a 1000.

SELECT 
    *
FROM
    pedidos
WHERE
    Receita_Venda > 1000;

-- Representa pedidos com alto valor financeiro
-- Utilizado para identificar clientes de maior valor e analisar oportunidades de receita elevada


#_______________________________________________________________________
#PROBLEMA 11: Pedidos entre 100 e 300
#Objetivo: Identificar pedidos dentro da faixa intermediária de valor.

SELECT 
    *
FROM
    pedidos
WHERE
    Receita_Venda BETWEEN 100 AND 300;

-- Representa pedidos com valores dentro de uma faixa intermediária
-- Utilizado para analisar o comportamento de compras em valores médios


#_______________________________________________________________________
#PROBLEMA 12: Pedidos extremos
#Objetivo: Identificar pedidos com valores muito baixos (menores que 50) ou muito altos (maiores que 500).

SELECT 
    *
FROM
    pedidos
WHERE
    Receita_Venda < 50
        OR Receita_Venda > 500;

-- Representa pedidos com valores muito baixos ou muito altos
-- Utilizado para identificar padrões fora da normalidade e possíveis anomalias nos valores dos pedidos


#_______________________________________________________________________
#PROBLEMA 13: Pedidos abaixo da média
#Objetivo: Identificar pedidos com valor inferior à média geral de vendas.

set @Media = (select avg(Receita_Venda) from pedidos);

SELECT 
    *
FROM
    pedidos
WHERE
    Receita_Venda < @Media;

-- Representa pedidos com valores abaixo da média geral de vendas
-- Utilizado para identificar pedidos com desempenho inferior ao padrão médio


#_______________________________________________________________________
#PROBLEMA 14: Produtos em faixa de preço
#Objetivo: Listar produtos com preço entre 50 e 1000.

SELECT 
    *
FROM
    produtos
WHERE
    Preco_Unit BETWEEN 50 AND 1000;

-- Representa produtos dentro de uma faixa específica de preço
-- Utilizado para analisar produtos em uma faixa de valor intermediária


#_______________________________________________________________________
#PROBLEMA 15: Produtos fora da faixa padrão
#Objetivo: Identificar produtos com preço abaixo de 100 ou acima de 2000.

SELECT 
    *
FROM
    produtos
WHERE
    Preco_Unit < 100 OR Preco_Unit > 2000;


-- Representa produtos com preços fora da faixa padrão definida
-- Utilizado para identificar produtos com valores muito baixos ou muito altos em relação ao esperado

#_______________________________________________________________________
#PROBLEMA 16: Produto mais caro
#Objetivo: Identificar o produto com maior preço.

set @MaiorPreco = (select max(Preco_Unit) from produtos);

SELECT 
    *
FROM
    produtos
WHERE
    Preco_Unit = @MaiorPreco;

-- Representa o produto com maior valor no catálogo
-- Utilizado para analisar posicionamento de preços e identificar itens de maior valor comercial


#_______________________________________________________________________
#PROBLEMA 17: Produto mais barato
#Objetivo: Identificar o produto com menor preço.

set @MenorPreco = (select min(Preco_Unit) from produtos);

SELECT 
    *
FROM
    produtos
WHERE
    Preco_Unit = @MenorPreco;
    
-- Representa o produto com menor valor no catálogo
-- Utilizado para analisar estratégias de precificação e identificar itens de menor valor comercial


#_______________________________________________________________________
#PROBLEMA 18: Clientes com padrão no nome
#Objetivo: Identificar clientes cujo nome contém a letra "a".

SELECT 
    *
FROM
    clientes
WHERE
    Nome LIKE '%a%';

-- Representa clientes cujo nome contém a letra 'a'
-- Utilizado para análises baseadas em padrões de texto nos nomes dos clientes


#_______________________________________________________________________
#PROBLEMA 19: Clientes com domínio específico
#Objetivo: Identificar clientes cujo email contém "@gmail".

SELECT 
    *
FROM
    clientes
WHERE
    Email LIKE '%@gmail%';
    
-- Representa clientes com domínio '@gmail' no email
-- Utilizado para analisar padrões de domínio nos emails dos clientes


#_______________________________________________________________________
#PROBLEMA 20: Clientes com nome iniciando por letra específica
#Objetivo: Identificar clientes cujo nome começa com uma determinada letra.

SELECT 
    *
FROM
    clientes
WHERE
    Nome LIKE 'A%';
    
-- Representa clientes cujo nome inicia com a letra 'A'
-- Utilizado para analisar padrões de início nos nomes dos clientes


#_______________________________________________________________________
#PROBLEMA 21: Clientes distintos
#Objetivo: Identificar a quantidade de clientes únicos na base.

SELECT 
    COUNT(DISTINCT Nome) AS Quant_clientes
FROM
    clientes;
-- Representa a quantidade de nomes distintos na base de clientes
-- Utilizado para analisar a diversidade de nomes cadastrados


#_______________________________________________________________________
#PROBLEMA 22: Clientes com múltiplos critérios
#Objetivo: Identificar clientes que possuem email válido e nome com padrão específico.

SELECT 
    *
FROM
    clientes
WHERE
    COALESCE(TRIM(Email), '') <> ''
        AND email LIKE '%@%'
        AND Email LIKE '%.com'
        AND LENGTH(Nome) >= 4;
        
-- Representa clientes com email válido e nomes com tamanho mínimo definido
-- Utilizado para garantir qualidade básica dos dados de contato e identificação


#_______________________________________________________________________
#PROBLEMA 23: Produtos com múltiplos critérios
#Objetivo: Identificar produtos dentro de uma faixa de preço e com padrão no nome.

SELECT 
    *
FROM
    produtos
WHERE
    Preco_Unit BETWEEN 500 AND 5000
        AND Nome_Produto LIKE '%a%';

-- Representa produtos dentro de uma faixa de preço definida e com padrão específico no nome
-- Utilizado para analisar produtos com características combinadas de valor e identificação textual


#_______________________________________________________________________
#PROBLEMA 24: Pedidos acima da média
#Objetivo: Identificar pedidos com valor superior à média geral.

set @Media = (select avg(Receita_Venda) from pedidos);

SELECT 
    *
FROM
    pedidos
WHERE
    Receita_Venda > @Media;

-- Representa pedidos com valores acima da média geral de vendas
-- Utilizado para identificar pedidos com desempenho superior ao padrão médio


#_______________________________________________________________________
#PROBLEMA 25: Análise consolidada de pedidos
#Objetivo: Exibir total de pedidos, soma dos valores, média, maior e menor valor. 

SELECT 
    SUM(Receita_Venda) as Soma_Total_Vendas,
    AVG(Receita_Venda) as Média_Vendas,
    MAX(Receita_Venda) as Maior_Venda,
    MIN(Receita_Venda) as Menor_Venda
FROM
    pedidos;

-- Representa indicadores gerais das vendas, incluindo soma, média e valores extremos
-- Utilizado para obter uma visão consolidada do desempenho financeiro dos pedidos