Oracle Examples in Module 2

SET LINESIZE 32000;
SET PAGESIZE 60;

-- Lesson 2

-- Example 1.
SELECT StoreZip, TimeMonth, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 GROUP BY CUBE (StoreZip, TimeMonth)
 ORDER BY StoreZip, TimeMonth;

-- Example 2. 
-- Rewrite of query 1 using the UNION operator
-- Only shown partially in the lesson 2 slides
SELECT StoreZip, TimeMonth, SUM(SalesDollar) AS SumSales
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 GROUP BY StoreZip, TimeMonth
UNION
SELECT StoreZip, NULL, SUM(SalesDollar) AS SumSales
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 GROUP BY StoreZip
UNION
SELECT NULL, TimeMonth, SUM(SalesDollar) AS SumSales
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 GROUP BY TimeMonth
UNION
SELECT NULL, NULL, SUM(SalesDollar) AS SumSales
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
ORDER BY 1, 2;

-- ORDER BY StoreZip, TimeMonth generates a syntax error on StoreZip

-- Example 3.
-- Not shown in the lesson 2 notes
-- Summarize sales for USA and Canada in 2012 by store zipcode, month, and division
SELECT StoreZip, TimeMonth, DivId,
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 GROUP BY CUBE (StoreZip, TimeMonth, DivId)
 ORDER BY StoreZip, TimeMonth, DivId;

-- Example 4.
-- Rewrite of query 3 using the UNION operator
-- Not shown in the lesson 2 slides
SELECT StoreZip, TimeMonth, DivId, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 GROUP BY StoreZip, TimeMonth, DivId
UNION
SELECT StoreZip, TimeMonth, NULL, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 GROUP BY StoreZip, TimeMonth
UNION
SELECT NULL, TimeMonth, DivId, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 GROUP BY TimeMonth, DivId
UNION
SELECT StoreZip, NULL, DivId, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 GROUP BY StoreZip, DivId
UNION
SELECT StoreZip, NULL, NULL, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 GROUP BY StoreZip
UNION
SELECT NULL, TimeMonth, NULL, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 GROUP BY TimeMonth
UNION
SELECT NULL, NULL, DivId, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 GROUP BY DivId
UNION
SELECT NULL, NULL, NULL, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 ORDER BY 1, 2, 3;