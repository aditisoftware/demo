<cfcomponent name="mssql">
	
	<cffunction name="init" access="public" output="false" returntype="mssql">
		<cfargument name="dsn" type="string" required="true" />
		<cfargument name="tableService" required="true">
		<cfargument name="columnService" required="true">
		<cfset variables.tableService = arguments.tableService>
		<cfset variables.columnService = arguments.columnService>
		<cfset setDSN(arguments.dsn) />
		<cfreturn this />
	</cffunction>

	<cffunction name="setDSN" access="public" output="false" returntype="void">
		<cfargument name="dsn" type="string" required="true" />
		<cfset variables.dsn = arguments.dsn />
	</cffunction>

	<cffunction name="getTables" access="public" output="false" returntype="array">
		<cfset var qAllTables = "" />
		<cfset var objTable = "" />
		<cfset var arrReturn = arrayNew(1) />

		<cfif not len(variables.dsn)>
			<cfthrow message="you must provide a dsn" />
		</cfif>
		<cfquery name="qAllTables" datasource="#variables.dsn#">
			exec sp_tables @table_type="'Table'"
		</cfquery>
		<cfloop query="qAllTables">
			<cfif qAllTables.table_name NEQ "sysdiagrams">
				<cfset objTable = variables.tableService.createTable(qAllTables.table_name,qAllTables.table_type) />
				<cfset arrayAppend(arrReturn,objTable) />
			</cfif>
		</cfloop>
		<cfreturn arrReturn />
	</cffunction>

	<cffunction name="getTableColumns" access="public" output="false" returntype="array">
		<cfargument name="tablename" required="true">
		<cfset var column= structNew() />
		<cfset var columns = ArrayNew(1)>
		<cfset var tableMetaData = getTableMetadata(arguments.tableName)>
		<cfset var primaryKeyList = getPrimaryKeyList(arguments.tableName)>
		<cfloop query="tableMetadata">
			<cfscript>
				column.name = tableMetadata.column_name;
				column.formlabel = tableMetadata.column_name;

				if((tableMetadata.type_name EQ "uniqueidentifier" OR (tableMetadata.type_name EQ 'char' AND tableMetadata.length EQ 35)) AND listFind(primaryKeyList,tableMetadata.column_name))
					column.datatype = 'uuid';
				else
					column.datatype = translateDataType(listFirst(tableMetadata.type_name," "));

				column.cfsqltype = translateCfSqlType(listFirst(tableMetadata.type_name," "));
				column.required = yesNoFormat(tableMetadata.nullable-1);
				column.primaryKey = yesNoFormat(listFind(primaryKeyList,tableMetadata.column_name));
				column.length = tableMetadata.length;
				column.identity = tableMetadata.identity;
				column.numeric_scale = tableMetadata.numeric_scale;
				column.PKTable = tableMetadata.PKTable;
				column.PKTableColumn = tableMetadata.PKTableColumn;
				ArrayAppend(columns,variables.columnService.createColumn(argumentCollection=column));
			</cfscript>
		</cfloop>
		<cfreturn columns />
	</cffunction>

	<!--- these functions are modified from reactor v0.1 --->
	<cffunction name="translateCfSqlType" hint="I translate the MSSQL data type names into ColdFusion cf_sql_xyz names" output="false" returntype="string">
		<cfargument name="typeName" hint="I am the type name to translate" required="yes" type="string" />

		<cfswitch expression="#arguments.typeName#">
			<cfcase value="bigint">
				<cfreturn "cf_sql_bigint" />
			</cfcase>
			<cfcase value="binary">
				<cfreturn "cf_sql_binary" />
			</cfcase>
			<cfcase value="bit">
				<cfreturn "cf_sql_bit" />
			</cfcase>
			<cfcase value="char">
				<cfreturn "cf_sql_char" />
			</cfcase>
			<cfcase value="date">
				<cfreturn "cf_sql_date" />
			</cfcase>
			<cfcase value="datetime">
				<cfreturn "cf_sql_timestamp" />
			</cfcase>
			<cfcase value="decimal">
				<cfreturn "cf_sql_decimal" />
			</cfcase>
			<cfcase value="float">
				<cfreturn "cf_sql_float" />
			</cfcase>
			<cfcase value="image">
				<cfreturn "cf_sql_longvarbinary" />
			</cfcase>
			<cfcase value="int">
				<cfreturn "cf_sql_integer" />
			</cfcase>
			<cfcase value="money">
				<cfreturn "cf_sql_money" />
			</cfcase>
			<cfcase value="nchar">
				<cfreturn "cf_sql_char" />
			</cfcase>
			<cfcase value="ntext">
				<cfreturn "cf_sql_longvarchar" />
			</cfcase>
			<cfcase value="numeric">
				<cfreturn "cf_sql_numeric" />
			</cfcase>
			<cfcase value="nvarchar">
				<cfreturn "cf_sql_varchar" />
			</cfcase>
			<cfcase value="real">
				<cfreturn "cf_sql_real" />
			</cfcase>
			<cfcase value="smalldatetime">
				<cfreturn "cf_sql_timestamp" />
			</cfcase>
			<cfcase value="smallint">
				<cfreturn "cf_sql_smallint" />
			</cfcase>
			<cfcase value="smallmoney">
				<cfreturn "cf_sql_money" />
			</cfcase>
			<cfcase value="text">
				<cfreturn "cf_sql_longvarchar" />
			</cfcase>
			<cfcase value="time">
				<cfreturn "cf_sql_time" />
			</cfcase>
			<cfcase value="timestamp">
				<cfreturn "cf_sql_timestamp" />
			</cfcase>
			<cfcase value="tinyint">
				<cfreturn "cf_sql_tinyint" />
			</cfcase>
			<cfcase value="uniqueidentifier">
				<cfreturn "cf_sql_idstamp" />
			</cfcase>
			<cfcase value="varbinary">
				<cfreturn "cf_sql_varbinary" />
			</cfcase>
			<cfcase value="varchar">
				<cfreturn "cf_sql_varchar" />
			</cfcase>
			<cfcase value="xml">
				<cfreturn "cf_sql_longvarchar" />
			</cfcase>
			<cfcase value="sql_variant">
				<cfreturn "cf_sql_varchar" />
			</cfcase>
		</cfswitch>
	</cffunction>

	<cffunction name="translateDataType" hint="I translate the MSSQL data type names into ColdFusion data type names" output="false" returntype="string">
		<cfargument name="typeName" hint="I am the type name to translate" required="yes" type="string" />

		<cfswitch expression="#arguments.typeName#">
			<cfcase value="bigint">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="binary">
				<cfreturn "binary" />
			</cfcase>
			<cfcase value="bit">
				<cfreturn "boolean" />
			</cfcase>
			<cfcase value="char">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="date">
				<cfreturn "date" />
			</cfcase>
			<cfcase value="datetime">
				<cfreturn "date" />
			</cfcase>
			<cfcase value="decimal">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="float">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="image">
				<cfreturn "binary" />
			</cfcase>
			<cfcase value="int">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="money">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="nchar">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="ntext">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="numeric">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="nvarchar">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="real">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="smalldatetime">
				<cfreturn "date" />
			</cfcase>
			<cfcase value="smallint">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="smallmoney">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="text">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="time">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="timestamp">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="tinyint">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="uniqueidentifier">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="varbinary">
				<cfreturn "binary" />
			</cfcase>
			<cfcase value="varchar">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="xml">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="sql_variant">
				<cfreturn "string" />
			</cfcase>
		</cfswitch>
	</cffunction>

	<cffunction name="getTableMetadata" access="public" output="false" returntype="query">
		<cfargument name="tablename" required="true">
		<cfset var qTable = "" />
		<!--- get table column info --->
		<!--- This is a modified version of the query in sp_columns --->
		<cfquery name="qTable" datasource="#variables.dsn#">
			SELECT	c.COLUMN_NAME,
				c.DATA_TYPE as TYPE_NAME,
				CASE
					WHEN ISNUMERIC(c.CHARACTER_MAXIMUM_LENGTH) = 1 THEN c.CHARACTER_MAXIMUM_LENGTH
					ELSE 0
					END as LENGTH,
				CASE
					WHEN c.IS_NULLABLE = 'No' AND c.Column_Default IS NULL THEN 0 /* a column is defined as nullable only if it doesn't have a default */
					ELSE 1
				END as NULLABLE,
				CASE
					WHEN columnProperty(object_id(c.TABLE_NAME), c.COLUMN_NAME, 'IsIdentity') > 0 THEN 'true'
					ELSE 'false'
				END AS [IDENTITY],
				c.NUMERIC_SCALE,
				(SELECT OBJECT_NAME(f.referenced_object_id) AS 'PKTable' 
					FROM sys.foreign_key_columns f 
					INNER JOIN sys.all_columns c1 ON f.parent_object_id = c1.[object_id] 
						AND f.parent_column_id = c1.column_id 
					INNER JOIN sys.all_columns c2 ON f.referenced_object_id = c2.[object_id] 
					AND f.referenced_column_id = c2.column_id
					Where OBJECT_NAME(f.parent_object_id) = 	c.TABLE_NAME
					and c1.[name] = c.COLUMN_NAME
				) as PKTable,
				(SELECT c2.[name] AS 'PKColumnName' 
					FROM sys.foreign_key_columns f 
					INNER JOIN sys.all_columns c1 ON f.parent_object_id = c1.[object_id] 
					AND f.parent_column_id = c1.column_id 
					INNER JOIN sys.all_columns c2 ON f.referenced_object_id = c2.[object_id] 
					AND f.referenced_column_id = c2.column_id
					Where OBJECT_NAME(f.parent_object_id) = 	c.TABLE_NAME
					and c1.[name] = c.COLUMN_NAME
				) as PKTableColumn
			FROM INFORMATION_SCHEMA.COLUMNS as c
			WHERE c.TABLE_NAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.tablename#" />
		</cfquery>
		<cfreturn qTable />
	</cffunction>
	
	<cffunction name="getPrimaryKeyList" access="public" output="false" returntype="string">
		<cfargument name="tablename" required="true">
		<cfset var qPrimaryKeys = "" />
		<cfset var lstPrimaryKeys = "" />
		<cfquery name="qPrimaryKeys" datasource="#variables.dsn#">
			SELECT ccu.COLUMN_NAME,ccu.CONSTRAINT_NAME AS PK_NAME
			FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
				INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
				ON ccu.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
			AND 	ccu.TABLE_NAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.tablename#" />
			AND	tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
		</cfquery>
		<cfset lstPrimaryKeys = valueList(qPrimaryKeys.column_name) />
		<cfreturn lstPrimaryKeys />
	</cffunction>
	
</cfcomponent>