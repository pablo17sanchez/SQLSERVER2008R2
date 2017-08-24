DECLARE @distributionDB AS sysname;
DECLARE @publisher AS sysname;
DECLARE @publicationDB as sysname;
SET @distributionDB = N'distribution';
SET @publisher = $(DistPubServer);
SET @publicationDB = N'AdventureWorks2012';

-- Disable the publication database.
USE [AdventureWorks2012]
EXEC sp_removedbreplication @publicationDB;

-- Remove the registration of the local Publisher at the Distributor.
USE master
EXEC sp_dropdistpublisher @publisher;

-- Delete the distribution database.
EXEC sp_dropdistributiondb @distributionDB;

-- Remove the local server as a Distributor.
EXEC sp_dropdistributor;