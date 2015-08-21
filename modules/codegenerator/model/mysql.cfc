<cfcomponent name="mysql">
	
	<cffunction name="init" access="public" output="false" returntype="mysql">
		<cfargument name="dsn" type="string" required="true" />
		<cfargument name="tableService" required="true">
		<cfargument name="columnService" required="true">
		<cfset variables.tableService = arguments.tableService>
		<cfset variables.columnService = arguments.columnService>
		<cfset setDSN(arguments.dsn) />
		<cfset isMySQL5plus() />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="isMySQL5plus" access="private" output="false" returntype="boolean">
		<!--- a simple test to see if the information_schema exists --->
		<cfset var qTestMySQL = "" />
		<cfset var rtnValue = true />
		<cfif not isDefined("variables.isMySQL5plusVar")>
			<cftry>
				<cfquery name="qTestMySQL" datasource="#variables.dsn#">
					SELECT 0 FROM INFORMATION_SCHEMA.columns LIMIT 1
				</cfquery>
				<cfcatch type="database">
					<cfset rtnValue = false />
				</cfcatch>
			</cftry>
			<cfset variables.isMySQL5plusVar = rtnValue />
		<cfelse>
			<cfset rtnValue = variables.isMySQL5plusVar />
		</cfif>
		<cfreturn rtnValue />
	</cffunction>
	
	<cffunction name="getTables" access="public" output="false" returntype="array">
		<cfif isMySQL5Plus()>
			<cfreturn getTables_5() />
		<cfelse>
			<cfreturn getTables_41() />
		</cfif>
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

				if(tableMetadata.type_name EQ 'char' AND tableMetadata.length EQ 35 AND listFind(primaryKeyList,tableMetadata.column_name))
					column.datatype = 'uuid';
				else
					column.datatype = translateDataType(listFirst(tableMetadata.type_name," "));

				column.cfsqltype = translateCfSqlType(listFirst(tableMetadata.type_name," "));
				column.required = yesNoFormat(tableMetadata.nullable-1);
				column.primaryKey = yesNoFormat(listFind(primaryKeyList,tableMetadata.column_name));
				column.length = tableMetadata.length;
				column.identity = tableMetadata.identity;
				column.numeric_scale = tableMetadata.numeric_scale;
				column.defaultValue = tableMetadata.column_default;
					
				ArrayAppend(columns,variables.columnService.createColumn(argumentCollection=column));
			</cfscript>
		</cfloop>
		<cfreturn columns />
	</cffunction>
	
	
	<!--- MySQL 4.1 support thanks to Josh Nathanson --->
	<cffunction name="getTables_41" access="private" output="false" returntype="array">
		<cfset var qStatus = "" />
		<cfset var qDB = "" />
		<cfset var getDBname = "" />
		<cfset var qAllTables = "" />
		<cfset objTable = "" />
		<cfset arrReturn = arrayNew(1) />
		
		<cfif not len(variables.dsn)>
			<cfthrow errorcode="you must provide a dsn" />
		</cfif>
		
		<cfquery name="qStatus" datasource="#variables.dsn#">
		SHOW TABLE STATUS
		</cfquery>

		<cfquery name="qDB" datasource="#variables.dsn#">
		SHOW OPEN TABLES
		</cfquery>

		<cfquery name="getDBname" dbtype="query">
		SELECT Database AS db FROM qDB
		GROUP BY Database
		</cfquery>

		<cfquery name="qAllTables" dbtype="query">
		SELECT '#getDBname.db#' as DATABASE_NAME, '#getDBname.db#' AS TABLE_SCHEMA, Name AS TABLE_NAME, Engine AS TABLE_TYPE
			FROM qStatus
		</cfquery>
		<cfloop query="qAllTables">
			<cfset objTable = variables.tableService.createTable(qAllTables.table_name,qAllTables.table_type) />
			<cfset arrayAppend(arrReturn,objTable) />
		</cfloop>
		<cfreturn arrReturn />
	</cffunction>
	<!------------------------>
	
	<cffunction name="getTables_5" access="public" output="false" returntype="array">
		<cfset var qAllTables = "" />
		<cfset objTable = "" />
		<cfset arrReturn = arrayNew(1) />
		
		<cfif not len(variables.dsn)>
			<cfthrow errorcode="you must provide a dsn" />
		</cfif>
		<cfquery name="qAllTables" datasource="#variables.dsn#">
			SELECT database() as DATABASE_NAME, TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE
			FROM information_schema.TABLES
			WHERE TABLE_SCHEMA = database()
		</cfquery>
		<cfloop query="qAllTables">
			<cfset objTable = variables.tableService.createTable(qAllTables.table_name,qAllTables.table_type) />
			<cfset arrayAppend(arrReturn,objTable) />
		</cfloop>
		<cfreturn arrReturn />
	</cffunction>
	
	<cffunction name="setDSN" access="public" output="false" returntype="void">
		<cfargument name="dsn" type="string" required="true" />
		<cfset variables.dsn = arguments.dsn />
	</cffunction>

	<!--- these functions are modified from reactor v0.1 --->
	<cffunction name="translateCfSqlType" hint="I translate the MySQL data type names into ColdFusion cf_sql_xyz names" output="false" returntype="string">
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
				<cfreturn "cf_sql_timestamp" />
			</cfcase>
			<cfcase value="datetime">
				<cfreturn "cf_sql_timestamp" />
			</cfcase>
			<cfcase value="decimal">
				<cfreturn "cf_sql_decimal" />
			</cfcase>
			<cfcase value="double">
				<cfreturn "cf_sql_float" />
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
			<cfcase value="longtext">
				<cfreturn "cf_sql_longvarchar" />
			</cfcase>
			<cfcase value="real">
				<cfreturn "cf_sql_real" />
			</cfcase>
			<cfcase value="smalldatetime">
				<cfreturn "cf_sql_date" />
			</cfcase>
			<cfcase value="smallint">
				<cfreturn "cf_sql_smallint" />
			</cfcase>
			<cfcase value="smallmoney">
				<cfreturn "cf_sql_decimal" />
			</cfcase>
			<cfcase value="text">
				<cfreturn "cf_sql_longvarchar" />
			</cfcase>
			<cfcase value="time">
				<cfreturn "cf_sql_timestamp" />
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
			<cfcase value="enum">
				<cfreturn "cf_sql_varchar" />
			</cfcase>
			<cfcase value="mediumtext">
				<cfreturn "cf_sql_varchar" />
			</cfcase>
			<cfcase value="tinytext">
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
				<cfreturn "string" />
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
			<cfcase value="double">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="float">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="image">
				<cfreturn "numeric" />
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
				<cfreturn "ntring" />
			</cfcase>
			<cfcase value="longtext">
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
				<cfreturn "date" />
			</cfcase>
			<cfcase value="tinyint">
				<cfreturn "numeric" />
			</cfcase>
			<cfcase value="uniqueidentifier">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="varbinary">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="varchar">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="enum">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="mediumtext">
				<cfreturn "string" />
			</cfcase>
			<cfcase value="tinytext">
				<cfreturn "string" />
			</cfcase>
		</cfswitch>
	</cffunction>
	
	<cffunction name="getTableMetadata" access="public" output="false" returntype="void">
		<cfargument name="tablename" required="true">
		<cfif isMySQL5plus()>
			<cfreturn getTableMetadata_5(arguments.tablename) />
		<cfelse>
			<cfreturn getTableMetadata_41(arguments.tablename) />
		</cfif>
	</cffunction>
	
	<cffunction name="getTableMetadata_5" access="private" output="false" returntype="void">
		<cfargument name="tablename" required="true">
		<cfset var qTable = "" />
		<!--- get table column info, borrowed from Reactor --->
		<cfquery name="qTable" datasource="#variables.dsn#">
			SELECT COLUMN_NAME,
			CASE
				WHEN IS_NULLABLE = 'Yes' AND COLUMN_DEFAULT IS NULL THEN 'true'
				ELSE 'false'
			END as nullable,
			DATA_TYPE as type_name,
			CASE
				WHEN CHARACTER_MAXIMUM_LENGTH IS NULL THEN 0
				ELSE CHARACTER_MAXIMUM_LENGTH
			END as length,
			CASE
				WHEN EXTRA = 'auto_increment' THEN 'true'
				ELSE 'false'
			END as identity,
			NUMERIC_SCALE,
			COLUMN_DEFAULT
			FROM information_schema.COLUMNS
			WHERE TABLE_SCHEMA = Database() AND TABLE_NAME = <cfqueryparam cfsqltype="cf_sql_varchar" scale="128" value="#arguments.tablename#" />
		</cfquery>
		<cfset variables.tableMetadata = qTable />
	</cffunction>
	<!--- MySQL 4.1 support thanks to Josh Nathanson --->
	<cffunction name="getTableMetadata_41" access="private" output="false" returntype="void">
		<cfargument name="tablename" required="true">
		<cfset var qTable_pre = "" />
		<cfset var qTable = "" />
		<cfset var lgth = "" />
		<cfset var typ = "" />
		<cfset var lgth_str = "" />

		<cfquery name="qTable_pre" datasource= "#variables.dsn#">
			DESCRIBE #arguments.tablename#
		</cfquery>

		<cfset qTable = QueryNew("COLUMN_NAME, nullable, type_name, length, identity")>

		<cfoutput query="qTable_pre">
			<!--- set type and length --->
			<cfset lgth = REFind("[0-9]+",Type,1,true)>
			<cfset typ = REFind("[a-zA-Z]+",Type,1,true)>
			<cfif lgth.len[1]> 
			<!--- if lgth is found by REFind, return struct - lgth.len[1] will be nonzero --->
				<cfset lgth_str = Mid(Type,lgth.pos[1],lgth.len[1])>
			<cfelse>
				<cfset lgth_str = "0">
			</cfif>
			<cfset typ_str = Mid(Type,typ.pos[1],typ.len[1])> <!--- there will always be a type --->
		
			<cfset QueryAddRow(qTable)>
			<cfset QuerySetCell(qTable,"COLUMN_NAME",Field)>
			<cfif Null is "Yes">
				<cfset QuerySetCell(qTable, "nullable", "true")>
			<cfelse>
				<cfset QuerySetCell(qTable, "nullable", "false")>
			</cfif>
			<cfset QuerySetCell(qTable, "type_name", typ_str)>
			<cfset QuerySetCell(qTable, "length", lgth_str)>
			<cfif Extra is "auto_increment">
				<cfset QuerySetCell(qTable, "identity", "true")>
			<cfelse>
				<cfset QuerySetCell(qTable, "identity", "false")>
			</cfif>
	
		</cfoutput>

		<cfset variables.tableMetadata = qTable />
	</cffunction>
	<!------------------------>
	<cffunction name="getPrimaryKeyList" access="public" output="false" returntype="string">
		<cfargument name="tablename" required="true">
		<cfif isMySQL5plus()>
			<cfreturn getPrimaryKeyList_5(arguments.tableName) />
		<cfelse>
			<cfreturn getPrimaryKeyList_41(arguments.tableName) />
		</cfif>
	</cffunction>
	
	<cffunction name="getPrimaryKeyList_5" access="public" output="false" returntype="string">
		<cfargument name="tablename" required="true">
		<cfset var qPrimaryKeys = "" />
		<cfset var lstPrimaryKeys = "" />
		<cfquery name="qPrimaryKeys" datasource="#variables.dsn#">
			SELECT COLUMN_NAME
			FROM information_schema.COLUMNS
			WHERE TABLE_SCHEMA = Database()
			AND TABLE_NAME = <cfqueryparam cfsqltype="cf_sql_varchar" scale="128" value="#arguments.tablename#" />
			AND	COLUMN_KEY = <cfqueryparam cfsqltype="cf_sql_varchar" value="PRI" />
		</cfquery>
		<cfset lstPrimaryKeys = valueList(qPrimaryKeys.column_name) />
		<cfset variables.primaryKeyList = lstPrimaryKeys />
	</cffunction>
	<!--- MySQL 4.1 support thanks to Josh Nathanson --->
	<cffunction name="setPrimaryKeyList_41" access="public" output="false" returntype="void">
		<cfargument name="tablename" required="true">
		<cfset var qPrimaryKeys_pre = "" />
		<cfset var qPrimaryKeys = "" />
		<cfset var lstPrimaryKeys = "" />
		
		<cfquery name="qPrimaryKeys_pre" datasource= "#variables.dsn#">
		DESCRIBE #arguments.tablename#
		</cfquery>
		
		<cfquery name="qPrimaryKeys" dbtype="query">
		SELECT Field AS COLUMN_NAME FROM qPrimaryKeys_pre
		WHERE [Key] = <cfqueryparam cfsqltype="cf_sql_varchar" value="PRI" />
		</cfquery>

		<cfset lstPrimaryKeys = valueList(qPrimaryKeys.column_name) />
		<cfset variables.primaryKeyList = lstPrimaryKeys />
	</cffunction>

</cfcomponent>