<cfcomponent>
	<cfproperty name="validatorService" inject="model:ValidatorService" scope="instance">

	<cffunction name="createColumn" access="public" returntype="Column" output="false">
		<cfargument name="name" default="" type="string">
		<cfargument name="FormLabel" default="" type="string">
		<cfargument name="displayOnForm" default="true" type="string">
		<cfargument name="inputType" default="" type="string">
		<cfargument name="inputSourceType" default="" type="string">
		<cfargument name="inputSourceProperty" default="" type="string">
		<cfargument name="description" default="" type="string">
		<cfargument name="dataType" default="" type="string">
		<cfargument name="cfsqltype" default="" type="string">
		<cfargument name="required" default="false" type="Boolean">
		<cfargument name="primaryKey" default="false" type="Boolean">
		<cfargument name="length" default="false" type="Numeric">
		<cfargument	name="identity" default="false" type="Boolean">
		<cfargument	name="numeric_scale" default="" type="string">
		<cfargument	name="PKTable" default="" type="string">
		<cfargument	name="PKTableColumn" default="" type="string">
		<cfargument	name="defaultValue" default="" type="string">

		<cfscript>
			var objColumn = createObject("component","column").init(argumentCollection = arguments);
			objColumn.setFormLabel(arguments.name);
			objColumn.setDisplayOnForm(true);
			//set up defaults for input source type
			if(NOT len(arguments.inputType)){
				switch (arguments.cfsqltype){
					case "cf_sql_bit":
						objColumn.setInputType("radio");
						objColumn.setinputSourceType("Array");
						objColumn.setinputSourceProperty('{"0":"No","1":"Yes"}');
						break;
					case "cf_sql_date":
						objColumn.setInputType("date");
						break;
					case "cf_sql_timestamp":
						objColumn.setInputType("datetime");
						break;
					case "cf_sql_time":
						objColumn.setInputType("time");
						break;
					case "cf_sql_longvarchar":
						objColumn.setInputType("textarea");
						break;
					default:
						objColumn.setInputType('text');
				}
				if (len(arguments.PKTable)){
					objColumn.setInputType("select");
					objColumn.setinputSourceType("cfc");
				}
			}
			if(arguments.identity)
				objColumn.setInputType('hidden');
			
			//generate default validator by column property
			objColumn.setValidators(instance.validatorService.getValidatorsByColumn(objColumn));
			return objColumn;
		</cfscript>
	</cffunction>

</cfcomponent>