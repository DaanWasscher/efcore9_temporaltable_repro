# efcore9_temporaltable_repro

Set some connectionstring for sql in program.cs

Run `dotnet ef database update` 

Results in the following error:
```
Microsoft.Data.SqlClient.SqlException (0x80131904): The object 'DF__AHistory__Name__5DCAEF64' is dependent on column 'Name'.
ALTER TABLE ALTER COLUMN Name failed because one or more objects access this column.
```

Caused by EFCore 9 generated migration sql

Generated SQL for migration "MakeNonNullableAndSetDefaultValue" adds the DEFAULT value constraint on both the regular table and the history table.

Migration "SetMaxLength" removes the DEFAULT value constraint from the regular table. And leaves the DEFAULT constraint on the history table which causes the error when changing max-length.

See migration.sql file for the generated sql.

EFCore 8.0.12 migration SQL does not add the DEFAULT value constraint to the history table at all and thus does not have this issue.