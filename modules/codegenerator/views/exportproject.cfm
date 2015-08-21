<cfset rc = event.getCollection()>
<cfoutput>
	<script type="text/javascript">
		function exportIt(index){
			allTables = $("input:checkbox:checked");
			if(index < allTables.length){
				$("##msg").html("Generating Code for" + allTables[index].value);
				$.ajax({
				   type: "POST",
				   url: "#event.buildLink(rc.xehGenerateCode)#",
				   data: "projectName=#trim(rc.projectName)#&tablename=" + allTables[index].value,
				   async:false,
				   success: function(msg){}
				 });
				exportIt(index+1);
			}
			else
				$("##msg").html("Exporting Code");
		}	
	</script>
	<cfset tables = rc.objProject.getTables()>
	<div id="msg"></div>
	<table>
		<tr>
			<th>Select</th>
			<th>Table Name</th>			
		</tr>		
		<cfloop from="1" to="#arrayLen(tables)#" index="i">
		<tr><cfset tblName = tables[i].getTableName()>
			<td><input type="checkbox" name="tableName" value="#tblName#" checked="checked"></td>
			<td>#tables[i].getTableName()#</td>
		</tr>					
		</cfloop>
		<tr>
			<td colspan="2"><input type="button" name="exportIt" value="Export It" onclick="exportIt(0)"/></td>			
		</tr>
	</table>
</cfoutput>