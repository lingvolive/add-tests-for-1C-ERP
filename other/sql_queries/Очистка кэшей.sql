DECLARE @db_id INT;
SET @db_id = DB_ID(N'ERP_Demo');

DBCC FREEPROCCACHE 
DBCC FREESESSIONCACHE 
DBCC FREESYSTEMCACHE ('ALL') 
DBCC DROPCLEANBUFFERS 
DBCC FLUSHPROCINDB(@db_id)