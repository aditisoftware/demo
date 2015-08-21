<cfoutput><%cfscript%>
component displayname="#variables.table.getComponentName()#Service" output="false" extends="coldbox.system.orm.hibernate.VirtualEntityService" {

	function init(
		required string entityname = "#variables.table.getComponentName()#",
		string queryCacheRegion,
		boolean useQueryCaching,
		boolean eventHandling,
		boolean useTransactions,
		boolean defaultAsQuery,
		string datasource
	){
		Super.init(argumentcollection=arguments);
		return this;
	};
	
	function get#variables.table.getComponentName()#s(string type="query"<cfloop array="#variables.table.getColumns()#" index="column">, #column.getDataType()# #column.getName()#</cfloop>, string orderby){
		var qList = "";
		var hql = "from #variables.table.getTableName()# where 0=0";
		var queryParam = {};
		var arrList = arrayNew(1);
		var i = 1;
		
		<cfloop array="#variables.table.getColumns()#" index="column">if(structKeyExists(arguments,"#column.getName()#") and len(arguments.#column.getName()#)){
			hql = hql & " and #column.getName()#=:#column.getName()#";
			queryParam.#column.getName()# = arguments.#column.getName()#;
		}
		</cfloop>if(structKeyExists(arguments, "orderby") and len(arguments.orderBy)){
			hql = hql & " order by %arguments.orderby%";
		}
		
		qList = EntityToQuery(ORMexecuteQuery(hql,queryParam));
		
		if(arguments.type eq "query"){
			return qList;	
		}
		else{
			loop from="1" to="%qList.recordCount%" index="i" {
				arrayAppend(arrList,queryRowToStruct(qList,i));
			}
			return arrList;
		}
	}

	function getByPage(numeric page=0, numeric pagesize=0, string gridsortcolumn="#listPKs#", string gridstartdirection){
		var gridstruct = {};
		var isPaging = 0;
		var pageRecordStart = "";
		var queryParam = {};
		var queryObj = new query();
		var sqlText = "";
		
		savecontent variable="sqlText" { WriteOutput("
			SELECT * FROM #variables.table.getComponentName()# 
		");}
		
		if(len(trim(arguments.gridsortcolumn))){
			sqlText = sqlText & " ORDER BY %arguments.gridsortcolumn% %arguments.gridstartdirection%";
		}
		
		if(arguments.page gt 0){
			pageRecordStart = (arguments.page - 1) * arguments.pageSize;
			sqlText = sqlText & " LIMIT %pageRecordStart%, %arguments.pageSize%";
			isPaging = 1;
		}

		gridstruct.query = queryObj.execute(sql=sqlText).getResult();

		if(isPaging){
			queryObj.clear();
			savecontent variable="sqlText" { WriteOutput("
				SELECT COUNT(*) AS CountAll FROM #variables.table.getComponentName()# 
			");}
			gridstruct.totalrowcount = queryObj.execute(sql=sqlText).getResult().CountAll;
		}
		else{
			gridstruct.totalrowcount = gridstruct.query.recordCount;
		}

		return gridstruct;
	}
	
	private struct function queryRowToStruct(required query qry){
		var row = 1;
		var ii = 1;
		var cols = listToArray(lcase(qry.columnList));
		var stReturn = structnew();
		if(arrayLen(arguments) GT 1)
			row = arguments[2];
		for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
			stReturn[cols[ii]] = qry[cols[ii]][row];
		}		
		return stReturn;
	}
}
<%/cfscript%></cfoutput>