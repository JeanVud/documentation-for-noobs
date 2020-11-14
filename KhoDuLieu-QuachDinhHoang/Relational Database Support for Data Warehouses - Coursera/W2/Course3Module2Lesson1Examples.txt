Oracle Examples in Module 2

SET LINESIZE 32000;
SET PAGESIZE 60;

-- Lesson 1

-- Example 1.
-- Summarize sum of store sales for USA and Canada in 2012 by store zip and month
-- Only include groups with more than one row

SELECT StoreZip, TimeMonth, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
     OR StoreNation = 'Canada') 
   AND TimeYear = 2012
 GROUP BY StoreZip, TimeMonth
 HAVING COUNT(*) > 1
 ORDER BY StoreZip, TimeMonth;