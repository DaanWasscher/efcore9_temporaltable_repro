IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
DECLARE @historyTableSchema sysname = SCHEMA_NAME()
EXEC(N'CREATE TABLE [A] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NULL,
    [PeriodEnd] datetime2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
    [PeriodStart] datetime2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    CONSTRAINT [PK_A] PRIMARY KEY ([Id]),
    PERIOD FOR SYSTEM_TIME([PeriodStart], [PeriodEnd])
) WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = [' + @historyTableSchema + N'].[AHistory]))');

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250212140151_Init', N'9.0.2');

ALTER TABLE [A] SET (SYSTEM_VERSIONING = OFF)


DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[A]') AND [c].[name] = N'Name');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [A] DROP CONSTRAINT [' + @var2 + '];');
UPDATE [A] SET [Name] = N'blabla' WHERE [Name] IS NULL;
ALTER TABLE [A] ALTER COLUMN [Name] nvarchar(max) NOT NULL;
ALTER TABLE [A] ADD DEFAULT N'blabla' FOR [Name];

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[AHistory]') AND [c].[name] = N'Name');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [AHistory] DROP CONSTRAINT [' + @var3 + '];');
UPDATE [AHistory] SET [Name] = N'blabla' WHERE [Name] IS NULL;
ALTER TABLE [AHistory] ALTER COLUMN [Name] nvarchar(max) NOT NULL;
ALTER TABLE [AHistory] ADD DEFAULT N'blabla' FOR [Name];

DECLARE @historyTableSchema1 sysname = SCHEMA_NAME()
EXEC(N'ALTER TABLE [A] SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = [' + @historyTableSchema1 + '].[AHistory]))')


INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250212140303_MakeNonNullableAndSetDefaultValue', N'9.0.2');

DECLARE @var4 sysname;
SELECT @var4 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[A]') AND [c].[name] = N'Name');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [A] DROP CONSTRAINT [' + @var4 + '];');
ALTER TABLE [A] ALTER COLUMN [Name] nvarchar(100) NOT NULL;
ALTER TABLE [A] ADD DEFAULT N'blabla' FOR [Name];

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250212140344_SetMaxLength', N'9.0.2');

COMMIT;
GO

