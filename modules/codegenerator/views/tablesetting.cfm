<cfoutput>
	<form name="frmProjectPath" action="#event.buildLink(rc.xehSaveTableSetting)#" method="post">
	
	<table border="0">
	<tr>
		<td>File Name</td>
		<td>File Location (use relative path from root)</td>
	</tr>
	<cfset fileNameList = "">
	<cfloop from="1" to="#arrayLen(rc.arrFilePaths)#" index="i">
		<cfset fileNameList = listAppend(fileNameList,rc.arrFilePaths[i].getFileName())>
		<tr>
			<td>#rc.arrFilePaths[i].getFileName()#</td>
			<td><input type="text" name="#rc.arrFilePaths[i].getFileName()#" value="#rc.arrFilePaths[i].getFileLocation()#"/></td>
		</tr>
	</cfloop>
		<tr>
			<td colspan="2">
				<input type="hidden" name="fileList" value="#fileNameList#">
				<input type="submit" name="savepath" value="Save"/>
			</td>
		</tr>
	</table>
	</form>
</cfoutput>