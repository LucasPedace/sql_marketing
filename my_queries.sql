-- This is a fully fiction project made to showcase my SQL skills.
-- So a fiction client reached out to me, asking me to provide some insights based on the
-- company's marketing campaigns data. Here's what I got:


-- Firstly, a quick look to our table
SELECT *
FROM marketing_campaign
LIMIT 10;


-- How many times clients accepted an offer for each campaign?
SELECT
	SUM(AcceptedCmp1) AS 'campaign_1',
    SUM(AcceptedCmp2) AS 'campaign_2',
    SUM(AcceptedCmp3) AS 'campaign_3',
    SUM(AcceptedCmp4) AS 'campaign_4',
    SUM(AcceptedCmp5) AS 'campaign_5',
    SUM(Response) AS 'final_campaign'
FROM marketing_campaign;
-- For some reason, the second campaign hasn't been very succsessful. We should find out why.


-- What's the average spent on Fish, Meat, Fruits, Sweet, Wine and Gold?
SELECT
	AVG(MntFishProducts) AS 'avg_fish',
    AVG(MntMeatProducts) AS 'avg_meat',
    AVG(MntFruits) AS 'avg_fruits',
    AVG(MntSweetProducts) AS 'avg_sweet',
    AVG(MntWines) AS 'avg_wine',
    AVG(MntGoldProds) AS 'avg_gold'
FROM marketing_campaign;
-- As we can see, Wines are, by far, our most profitable products, followed by Meat and Gold.


-- Who are the top 20 best clients?
SELECT
	ï»¿client_id AS 'client_id',
    (MntFishProducts + MntMeatProducts + MntFruits + MntFruits + MntSweetProducts + MntWines + MntGoldProds) AS 'total_spent',
    Dt_Customer,
    sum(MntFishProducts) AS 'sum_fish',
    sum(MntMeatProducts) AS 'sum_meat',
    sum(MntFruits) AS 'sum_fruits',
    sum(MntSweetProducts) AS 'sum_sweet',
    sum(MntWines) AS 'sum_wine',
    sum(MntGoldProds) AS 'sum_gold',
    NumCatalogPurchases,
    NumDealsPurchases,
    NumStorePurchases,
    NumWebPurchases
FROM marketing_campaign
GROUP BY ï»¿client_id
ORDER BY total_spent DESC
LIMIT 20;
-- Most of the best clients buy directly in stores, followed by using the catalog. Not that many used the store's website though, I thought it would be more.
-- Also, many of them had deals.


-- What's the client's average income?
SELECT
	AVG(Income) AS 'yearly_mean_income',
    MAX(Income) AS 'yearly_max_income',
    MIN(Income) AS 'yearly_min_income'
FROM marketing_campaign;
-- The average yearly income is 52247.2514


-- What's the client's average age?
SELECT
	ROUND(AVG((YEAR(NOW()) - Year_Birth))) AS 'avg_age'
FROM marketing_campaign;
-- The average age is 53


-- Amount of sales made directly in stores, using the catalog or through company’s web site.
SELECT
	SUM(NumStorePurchases) AS 'stores_total',
    SUM(NumCatalogPurchases) AS 'catalog_total',
    SUM(NumWebPurchases) AS 'web_total'
FROM marketing_campaign;


-- Who is the client num 22?
SELECT *
FROM marketing_campaign
WHERE ï»¿client_id = 22;


-- Lastly, clients with the most days since last purchase (who had already made at least ten purchase)
SELECT
	ï»¿client_id AS 'client_id',
    Recency,
    (NumStorePurchases + NumCatalogPurchases + NumWebPurchases) AS 'purchases_total'
FROM marketing_campaign
WHERE (NumStorePurchases + NumCatalogPurchases + NumWebPurchases) >= 9
ORDER BY Recency DESC;