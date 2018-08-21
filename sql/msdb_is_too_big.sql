/*----------------------------------------------------------------------------------
	VIEW STATS
-----------------------------------------------------------------------------------*/
SELECT object_name(i.object_id) as objectName,
i.[name] as indexName,
sum(a.total_pages) as totalPages,
sum(a.used_pages) as usedPages,
sum(a.data_pages) as dataPages,
(sum(a.total_pages) * 8) / 1024 as totalSpaceMB,
(sum(a.used_pages) * 8) / 1024 as usedSpaceMB,
(sum(a.data_pages) * 8) / 1024 as dataSpaceMB
FROM sys.indexes i
INNER JOIN sys.partitions p
ON i.object_id = p.object_id
AND i.index_id = p.index_id
INNER JOIN sys.allocation_units a
ON p.partition_id = a.container_id
GROUP BY i.object_id, i.index_id, i.[name]
ORDER BY sum(a.total_pages) DESC, object_name(i.object_id)
GO

/*----------------------------------------------------------------------------------
	IF SYSMAINTPLAN_LOG is the problem... Truncate tables
-----------------------------------------------------------------------------------*/
ALTER TABLE [dbo].[sysmaintplan_log] DROP CONSTRAINT [FK_sysmaintplan_log_subplan_id];

ALTER TABLE [dbo].[sysmaintplan_logdetail] DROP CONSTRAINT [FK_sysmaintplan_log_detail_task_id];

 

truncate table msdb.dbo.sysmaintplan_logdetail;

truncate table msdb.dbo.sysmaintplan_log;

 

ALTER TABLE [dbo].[sysmaintplan_log] WITH CHECK ADD CONSTRAINT [FK_sysmaintplan_log_subplan_id] FOREIGN KEY([subplan_id])

REFERENCES [dbo].[sysmaintplan_subplans] ([subplan_id]);

 

ALTER TABLE [dbo].[sysmaintplan_logdetail] WITH CHECK ADD CONSTRAINT [FK_sysmaintplan_log_detail_task_id] FOREIGN KEY([task_detail_id])

REFERENCES [dbo].[sysmaintplan_log] ([task_detail_id]) ON DELETE CASCADE;


/*----------------------------------------------------------------------------------
	SHRINK DATABASE
-----------------------------------------------------------------------------------*/
exec sp_helpdb msdb
dbcc shrinkfile(msdbdata, 1024);
exec sp_helpdb msdb

dbcc updateusage ('msdb')
