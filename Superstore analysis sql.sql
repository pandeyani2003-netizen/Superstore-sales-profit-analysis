-- =====================================================
-- SUPERSTORE SALES & PROFIT ANALYSIS
-- Tools: MySQL
-- Dataset: Superstore
-- =====================================================


-- =====================================================
-- 1. TOTAL SALES AND PROFIT
-- =====================================================

SELECT
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit
FROM superstore;


-- =====================================================
-- 2. SALES BY STATE - TOP 10
-- =====================================================

SELECT
    state,
    ROUND(SUM(sales), 2) AS Total_Sales
FROM superstore
GROUP BY state
ORDER BY Total_Sales DESC
LIMIT 10;


-- =====================================================
-- 3. PROFIT BY CATEGORY
-- =====================================================

SELECT
    category,
    ROUND(SUM(profit), 2) AS Total_Profit
FROM superstore
GROUP BY category
ORDER BY Total_Profit DESC;


-- =====================================================
-- 4. SALES BY SUB-CATEGORY - TOP 5
-- =====================================================

SELECT
    `sub-category`,
    ROUND(SUM(sales), 2) AS Total_Sales
FROM superstore
GROUP BY `sub-category`
ORDER BY Total_Sales DESC
LIMIT 5;


-- =====================================================
-- 5. STATES WITH PROFIT GREATER THAN 10,000
-- =====================================================

SELECT
    state,
    ROUND(SUM(profit), 2) AS Total_Profit
FROM superstore
GROUP BY state
HAVING SUM(profit) > 10000
ORDER BY Total_Profit DESC;


-- =====================================================
-- 6. PROFIT CLASSIFICATION USING CASE WHEN
-- =====================================================

SELECT
    state,
    ROUND(SUM(profit), 2) AS Total_Profit,
    CASE
        WHEN SUM(profit) > 50000 THEN 'High Profit'
        WHEN SUM(profit) > 10000 THEN 'Medium Profit'
        ELSE 'Low Profit'
    END AS Profit_Category
FROM superstore
GROUP BY state
ORDER BY Total_Profit DESC;


-- =====================================================
-- 7. CATEGORY SALES CLASSIFICATION
-- =====================================================

SELECT
    category,
    ROUND(SUM(sales), 2) AS Total_Sales,
    CASE
        WHEN SUM(sales) > 800000 THEN 'Excellent Sales'
        WHEN SUM(sales) > 500000 THEN 'Good Sales'
        ELSE 'Needs Improvement'
    END AS Sales_Performance
FROM superstore
GROUP BY category
ORDER BY Total_Sales DESC;


-- =====================================================
-- 8. NEGATIVE PROFIT STATES
-- =====================================================

SELECT
    state,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit
FROM superstore
GROUP BY state
HAVING SUM(profit) < 0
ORDER BY Total_Profit ASC;


-- =====================================================
-- 9. SUB-CATEGORIES WITH SALES ABOVE AVERAGE
-- =====================================================

SELECT
    `sub-category`,
    ROUND(SUM(sales), 2) AS Total_Sales
FROM superstore
GROUP BY `sub-category`
HAVING SUM(sales) >
(
    SELECT AVG(sales)
    FROM superstore
)
ORDER BY Total_Sales DESC;


-- =====================================================
-- 10. STATES WHOSE TOTAL SALES ARE ABOVE
--     THE AVERAGE STATE SALES
-- =====================================================

SELECT
    state,
    ROUND(total_sales, 2) AS Total_Sales
FROM
(
    SELECT
        state,
        SUM(sales) AS total_sales
    FROM superstore
    GROUP BY state
) AS state_sales
WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM
    (
        SELECT
            state,
            SUM(sales) AS total_sales
        FROM superstore
        GROUP BY state
    ) AS avg_state_sales
)
ORDER BY Total_Sales DESC;


-- =====================================================
-- 11. CATEGORY AND SUB-CATEGORY PERFORMANCE
-- =====================================================

SELECT
    category,
    `sub-category`,
    ROUND(SUM(sales), 2) AS Total_Sales,
    ROUND(SUM(profit), 2) AS Total_Profit
FROM superstore
GROUP BY category, `sub-category`
ORDER BY Total_Sales DESC;


-- END OF ANALYSIS