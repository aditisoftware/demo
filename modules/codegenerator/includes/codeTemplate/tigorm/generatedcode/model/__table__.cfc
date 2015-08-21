<cfset listPKs = "">
<cfloop array="#variables.table.getColumns()#" index="column">
	<cfif column.getPrimaryKey() eq "Yes">
		<cfset listPKs = ListAppend(listPKs, column.getName())>
	</cfif>
</cfloop>
<cfoutput><%cfscript%>
component displayname="#variables.table.getComponentName()#" output="false" persistent="true" {
	<cfloop array="#variables.table.getColumns()#" index="column">property name="#column.getName()#"<cfif column.getPrimaryKey() eq "Yes"> fieldtype="id"</cfif><cfif column.getIdentity() eq "Yes"> generator="identity"</cfif><cfif column.getPrimaryKey() neq "Yes"> type="<cfif column.getDataType() EQ "uuid">string<cfelse>#column.getDataType()#</cfif>"</cfif> default="<cfif column.getdefaultValue() neq "CURRENT_TIMESTAMP">#column.getdefaultValue()#</cfif>"<cfif column.getCfsqltype() EQ "cf_sql_timestamp"> ormtype="timestamp"</cfif>;
	</cfloop>
	function setMemento(required struct memento){
		var thisProp = getMetaData(this).properties;
		loop array="%thisProp%" index="property" {
			if(structKeyExists(arguments.memento,property.name)){
				this["set" & property.name](arguments.memento[property.name]);
			}
		}
		return this;
	}
	
	function getMemento(){
		var memento = structNew();
		var thisProp = getMetaData(this).properties;
		loop array="%thisProp%" index="property" {
			memento[property.name] = this["get" & property.name]();
		}
		return memento;
	}
	
	function validate(){
		var errors = arrayNew(1);
		var thisError = structNew();
		<cfloop array="#variables.table.getColumns()#" index="column">
			<cfloop array="#column.getValidators()#" index="validator">
				<cfswitch expression="#validator.getNAME()#">
		<cfcase value="required"><cfif #column.getIdentity()# NEQ true>
		if( NOT len(trim(get#column.getName()#())) ){
			thisError.field = "#column.getName()#";
			thisError.type = "required";
			thisError.message = "#validator.getErrorMessage()#";
			arrayAppend(errors,duplicate(thisError));
		}</cfif>
		</cfcase>
		<cfcase value="email">
		if( len(trim(get#column.getName()#())) AND (NOT isvalid("email",trim(get#column.getName()#()))) ){
			thisError.field = "#column.getName()#";
			thisError.type = "email";
			thisError.message = "#validator.getErrorMessage()#";
			arrayAppend(errors,duplicate(thisError));
		}
		</cfcase>
		<cfcase value="url">
		if( len(trim(get#column.getName()#())) AND (NOT isvalid("url",trim(get#column.getName()#()))) ){
			thisError.field = "#column.getName()#";
			thisError.type = "url";
			thisError.message = "#validator.getErrorMessage()#";
			arrayAppend(errors,duplicate(thisError));
		}
		</cfcase>
		<cfcase value="creditcard">
		if( len(trim(get#column.getName()#())) AND (NOT isvalid("creditcard",trim(get#column.getName()#()))) ){
			thisError.field = "#column.getName()#";
			thisError.type = "creditcard";
			thisError.message = "#validator.getErrorMessage()#";
			arrayAppend(errors,duplicate(thisError));
		}
		</cfcase>
		<cfcase value="maxlength">
		if( len(trim(get#column.getName()#())) AND (len(trim(get#column.getName()#())) GT #validator.getValue()#) ){
			thisError.field = "#column.getName()#";
			thisError.type = "maxlength";
			thisError.message = "#replace(validator.getErrorMessage(),'{0}', validator.getValue())#";
			arrayAppend(errors,duplicate(thisError));
		}
		</cfcase>
		<cfcase value="minlength">
		if( len(trim(get#column.getName()#())) AND (len(trim(get#column.getName()#())) LT #validator.getValue()#) ){
			thisError.field = "#column.getName()#";
			thisError.type = "minlength";
			thisError.message = "#replace(validator.getErrorMessage(),'{0}', validator.getValue())#";
			arrayAppend(errors,duplicate(thisError));
		}
		</cfcase>
		<cfcase value="number">
		if( len(trim(get#column.getName()#())) AND (NOT isvalid("float",trim(get#column.getName()#()))) ){
			thisError.field = "#column.getName()#";
			thisError.type = "number";
			thisError.message = "#validator.getErrorMessage()#";
			arrayAppend(errors,duplicate(thisError));
		}
		</cfcase>
		<cfcase value="digits">
		if( len(trim(get#column.getName()#())) AND (NOT isvalid("numeric",trim(get#column.getName()#()))) ){
			thisError.field = "#column.getName()#";
			thisError.type = "digits";
			thisError.message = "#validator.getErrorMessage()#";
			arrayAppend(errors,duplicate(thisError));
		}
		</cfcase>
		<cfcase value="max">
		if( len(trim(get#column.getName()#())) AND (NOT isvalid("numeric",trim(get#column.getName()#()))) AND (trim(get#column.getName()#()) GT #validator.getValue()#) ){
			thisError.field = "#column.getName()#";
			thisError.type = "max";
			thisError.message = "#replace(validator.getErrorMessage(),'{0}', validator.getValue())#";
			arrayAppend(errors,duplicate(thisError));
		}
		</cfcase>
		<cfcase value="min">
		if( len(trim(get#column.getName()#())) AND (NOT isvalid("numeric",trim(get#column.getName()#()))) AND (trim(get#column.getName()#()) LT #validator.getValue()#) ){
			thisError.field = "#column.getName()#";
			thisError.type = "min";
			thisError.message = "#replace(validator.getErrorMessage(),'{0}', validator.getValue())#";
			arrayAppend(errors,duplicate(thisError));
		}
		</cfcase>
		<cfcase value="date">
		if( len(trim(get#column.getName()#())) AND (NOT isvalid("date",trim(get#column.getName()#()))) ){
			thisError.field = "#column.getName()#";
			thisError.type = "date";
			thisError.message = "#validator.getErrorMessage()#";
			arrayAppend(errors,duplicate(thisError));
		}
		</cfcase>
		
				</cfswitch>
			</cfloop>
		</cfloop>
		return errors;
	}
}
<%/cfscript%></cfoutput>