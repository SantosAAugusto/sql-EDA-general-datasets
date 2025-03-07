/*
AVISO:
O script abaixo contém apenas as queries.
Para criação da DATABASE, Tabelas e colunas, utilizou-se SQLServer.
*/

-- Checagem inicial do conjunto, avaliando o número de clientes com informações desconhecidas
SELECT * FROM youtube.bank
WHERE job = 'unknown' OR contact = 'unknown' OR education = 'unknown' OR poutcome = 'unknown'
LIMIT 10;


-- Qual o número de novos clientes advindos através das campanhas?
SELECT COUNT(*) FROM youtube.bank
WHERE y = 'yes';


-- Qual o capital dos clientes que disseram 'SIM' ou 'NÃO' às campanhas de marketing?
SELECT
	y
	, COUNT (*) AS qtd_clientes
	, AVG (balance) AS avg_balance
	, STDDEV (balance) AS std_balance
	, MIN (balance) AS min balance
	, MAX (balance) AS max_balance
FROM youtube.bank
GROUP BY y


-- Há diferença na taxa de conversão de clientes, após as campanhas de marketing, de acordo com a forma de contato?
SELECT y, contact, COUNT(*) AS qtd_clientes
FROM youtube.bank
GROUP BY y, contact


-- Como se comportam as variáveis 'housing (Tem casa ou não)', 'age (idade)' e 'marital (estado civil)' entre os clientes assinantes?

-- Idade
SELECT y, AVG(age) as avg_age 
FROM youtube.bank
GROUP BY y;

-- Tem casa ou não (percentual)
SELECT
	y
	, AVG(CASE WHEN housing = 'yes' THEN 1 ELSE 0 END) AS perc_housing
FROM youtube.bank
GROUP BY y;

-- Estado civil (Geral)
SELECT
	y
	, AVG(CASE WHEN marital = 'married' THEN 1 ELSE 0 END) AS marital_married
	, AVG(CASE WHEN marital = 'single' THEN 1 ELSE 0 END) AS marital_single
	, AVG(CASE WHEN marital = 'divorced' THEN 1 ELSE 0 END) AS divorced
FROM youtube.bank
GROUP BY y;

-- Estado civil (comportamento apenas para casados, 'married')
SELECT
	marital
	, AVG (CASE WHEN y = 'yes' THEN 1 ELSE 0 END) AS y_yes
	, AVG (CASE WHEN y = 'no' THEN 1 ELSE 0 END) AS y_no
FROM youtube.bank
GROUP BY y;
