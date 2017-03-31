-- run these so they're optimized
GO
SELECT *
INTO before_query_transformation_stats
FROM sys.dm_exec_query_transformation_stats
GO

SELECT *
INTO after_query_transformation_stats
FROM sys.dm_exec_query_transformation_stats
GO
DROP TABLE after_query_transformation_stats

DROP TABLE before_query_transformation_stats
GO
SELECT *
INTO before_query_transformation_stats
FROM sys.dm_exec_query_transformation_stats
GO

-- replace with query to collect stats on
SELECT * FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 43659
-- end replace block
OPTION (RECOMPILE)
GO

SELECT *
INTO after_query_transformation_stats
FROM sys.dm_exec_query_transformation_stats
GO

SELECT a.name, (a.promised - b.promised) as promised
FROM before_query_transformation_stats b
JOIN after_query_transformation_stats a
ON b.name = a.name
WHERE b.succeeded <> a.succeeded

DROP TABLE before_query_transformation_stats
DROP TABLE after_query_transformation_stats