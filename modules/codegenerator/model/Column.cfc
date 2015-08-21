<cfcomponent>
	<cfproperty name="name" default="" type="string">
	<cfproperty name="FormLabel" default="" type="string">
	<cfproperty name="displayOnForm" default="true" type="boolean">
	<cfproperty name="displayInGrid" default="true" type="boolean">
	<cfproperty name="inputType" default="text" type="string">
	<cfproperty name="inputSourceType" default="" type="string">
	<cfproperty name="inputSourceProperty" default="" type="string">
	<cfproperty name="validators" type="Validator[]">
	<cfproperty name="description" default="" type="string">
	<cfproperty name="dataType" default="" type="string">
	<cfproperty name="cfsqltype" default="" type="string">
	<cfproperty name="required" default="" type="string">
	<cfproperty name="primaryKey" default="false" type="Boolean">
	<cfproperty name="length" default="0" type="Numeric">
	<cfproperty name="identity" default="0" type="Boolean">
	<cfproperty name="numeric_scale" default="" type="string">
	<cfproperty name="PKTable" default="" type="string">
	<cfproperty name="PKTableColumn" default="" type="string">
	<cfproperty name="defaultValue" default="" type="string">

	<cfset variables.instance = structNew()>
	<cffunction name="init" access="public" output="false" returntype="column">
		<cfargument name="name" default="" type="string">
		<cfargument name="FormLabel" default="" type="string">
		<cfargument name="displayOnForm" default="true" type="boolean">
		<cfargument name="displayInGrid" default="true" type="boolean">
		<cfargument name="inputType" default="" type="string">
		<cfargument name="inputSourceType" default="" type="string">
		<cfargument name="inputSourceProperty" default="" type="string">
		<cfargument name="validators" default="#arrayNew(1)#" type="Validator[]">
		<cfargument name="description" default="" type="string">
		<cfargument name="dataType" default="" type="string">
		<cfargument name="cfsqltype" default="" type="string">
		<cfargument name="required" default="false" type="Boolean">
		<cfargument name="primaryKey" default="false" type="Boolean">
		<cfargument name="length" default="false" type="Numeric">
		<cfargument name="identity" default="false" type="Boolean">
		<cfargument name="numeric_scale" default="" type="string">
		<cfargument name="PKTable" default="" type="string">
		<cfargument name="PKTableColumn" default="" type="string">
		<cfargument name="defaultValue" default="" type="string">
		<cfscript>
			variables.instance.name = arguments.name;
			variables.instance.FormLabel = arguments.FormLabel;
			variables.instance.displayOnForm = arguments.displayOnForm;
			variables.instance.displayInGrid = arguments.displayInGrid;
			variables.instance.inputType = arguments.inputType;
			variables.instance.inputSourceType = arguments.inputSourceType;
			variables.instance.inputSourceProperty = arguments.inputSourceProperty;
			variables.instance.validators = arguments.validators;
			variables.instance.description = arguments.description;
			variables.instance.dataType = arguments.dataType;
			variables.instance.cfsqltype = arguments.cfsqltype;
			variables.instance.required = arguments.required;
			variables.instance.primaryKey = arguments.primaryKey;
			variables.instance.length = arguments.length;
			variables.instance.identity = arguments.identity;
			variables.instance.numeric_scale = arguments.numeric_scale;
			variables.instance.PKTable =arguments.PKTable;
			variables.instance.PKTableColumn =arguments.PKTableColumn;
			variables.instance.defaultValue =arguments.defaultValue;
			return this;
		</cfscript>
	</cffunction>

	<cffunction name="getMeta" access="public" returntype="struct" output="false" >
		<cfreturn  getMetaData(this)/>
	</cffunction>
	
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>
	
	<cffunction name="setMemento" access="public" returntype="column" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>


	<cffunction name="getName" access="public" output="false" returntype="string">
		<cfreturn variables.instance.Name>
	</cffunction>

	<cffunction name="setName" access="public" output="false" returntype="void">
		<cfargument name="mName" type="string">
		<cfset variables.instance.Name = arguments.mName>
	</cffunction>

	<cffunction name="getFormLabel" access="public" output="false" returntype="string">
		<cfreturn variables.instance.FormLabel>
	</cffunction>

	<cffunction name="setFormLabel" access="public" output="false" returntype="void">
		<cfargument name="mFormLabel" type="string">
		<cfset variables.instance.FormLabel = arguments.mFormLabel>
	</cffunction>

	<cffunction name="getDisplayOnForm" access="public" output="false" returntype="boolean">
		<cfreturn variables.instance.DisplayOnForm>
	</cffunction>

	<cffunction name="setDisplayOnForm" access="public" output="false" returntype="void">
		<cfargument name="mDisplayOnForm" type="boolean">
		<cfset variables.instance.DisplayOnForm = arguments.mDisplayOnForm>
	</cffunction>

	<cffunction name="getdisplayInGrid" access="public" output="false" returntype="boolean">    
    	<cfreturn variables.instance.displayInGrid>    
    </cffunction>    
    
    <cffunction name="setdisplayInGrid" access="public" output="false" returntype="void">    
    	<cfargument name="mdisplayInGrid" type="boolean">    
    	<cfset variables.instance.displayInGrid = arguments.mdisplayInGrid>    
    </cffunction>

	<cffunction name="getInputType" access="public" output="false" returntype="string">
		<cfreturn variables.instance.InputType>
	</cffunction>

	<cffunction name="setInputType" access="public" output="false" returntype="void">
		<cfargument name="mInputType" type="string">
		<cfset variables.instance.InputType = arguments.mInputType>
	</cffunction>

	<cffunction name="getInputSourceType" access="public" output="false" returntype="string">
		<cfreturn variables.instance.InputSourceType>
	</cffunction>

	<cffunction name="setInputSourceType" access="public" output="false" returntype="void">
		<cfargument name="mInputSourceType" type="string">
		<cfset variables.instance.InputSourceType = arguments.mInputSourceType>
	</cffunction>

	<cffunction name="getInputSourceProperty" access="public" output="false" returntype="string">
		<cfreturn variables.instance.InputSourceProperty>
	</cffunction>

	<cffunction name="setInputSourceProperty" access="public" output="false" returntype="void">
		<cfargument name="mInputSourceProperty" type="string">
		<cfset variables.instance.InputSourceProperty = arguments.mInputSourceProperty>
	</cffunction>

	<cffunction name="getValidators" access="public" output="false" returntype="Array">
		<cfreturn variables.instance.Validators>
	</cffunction>

	<cffunction name="setValidators" access="public" output="false" returntype="void">
		<cfargument name="mValidators" type="Array">
		<cfset variables.instance.Validators = arguments.mValidators>
	</cffunction>

	<cffunction name="addValidator" access="public" output="false" returntype="void">
		<cfargument name="mValidator" required="true" type="validator">
		<cfset ArrayAppend(variables.instance.Validators,arguments.mValidator)>
	</cffunction>

	<cffunction name="getDescription" access="public" output="false" returntype="string">
		<cfreturn variables.instance.Description>
	</cffunction>

	<cffunction name="setDescription" access="public" output="false" returntype="void">
		<cfargument name="mDescription" type="string">
		<cfset variables.instance.Description = arguments.mDescription>
	</cffunction>

	<cffunction name="getDataType" access="public" output="false" returntype="string">
		<cfreturn variables.instance.DataType>
	</cffunction>

	<cffunction name="setDataType" access="public" output="false" returntype="void">
		<cfargument name="mDataType" type="string">
		<cfset variables.instance.DataType = arguments.mDataType>
	</cffunction>

	<cffunction name="getRequired" access="public" output="false" returntype="boolean">
		<cfreturn variables.instance.Required>
	</cffunction>

	<cffunction name="setRequired" access="public" output="false" returntype="void">
		<cfargument name="mRequired" type="boolean">
		<cfset variables.instance.Required = arguments.mRequired>
	</cffunction>

	<cffunction name="getPrimaryKey" access="public" output="false" returntype="boolean">
		<cfreturn variables.instance.PrimaryKey>
	</cffunction>

	<cffunction name="setPrimaryKey" access="public" output="false" returntype="void">
		<cfargument name="mPrimaryKey" type="boolean">
		<cfset variables.instance.PrimaryKey = arguments.mPrimaryKey>
	</cffunction>

	<cffunction name="getLength" access="public" output="false" returntype="Numeric">
		<cfreturn variables.instance.Length>
	</cffunction>

	<cffunction name="setLength" access="public" output="false" returntype="void">
		<cfargument name="mLength" type="Numeric">
		<cfset variables.instance.Length = arguments.mLength>
	</cffunction>

	<cffunction name="getIdentity" access="public" output="false" returntype="Boolean">
		<cfreturn variables.instance.Identity>
	</cffunction>

	<cffunction name="setIdentity" access="public" output="false" returntype="void">
		<cfargument name="mIdentity" type="Boolean">
		<cfset variables.instance.Identity = arguments.mIdentity>
	</cffunction>

	<cffunction name="getcfsqltype" access="public" output="false" returntype="string">
		<cfreturn variables.instance.cfsqltype>
	</cffunction>

	<cffunction name="setcfsqltype" access="public" output="false" returntype="void">
		<cfargument name="mcfsqltype" type="string">
		<cfset variables.instance.cfsqltype = arguments.mcfsqltype>
	</cffunction>
	
	<cffunction name="getnumeric_scale" access="public" output="false" returntype="string">
		<cfreturn variables.instance.numeric_scale>
	</cffunction>

	<cffunction name="setnumeric_scale" access="public" output="false" returntype="void">
		<cfargument name="mnumeric_scale" type="string">
		<cfset variables.instance.numeric_scale = arguments.mnumeric_scale>
	</cffunction>
	
	<cffunction name="getPKTable" access="public" output="false" returntype="string">
		<cfreturn variables.instance.PKTable>
	</cffunction>

	<cffunction name="setPKTable" access="public" output="false" returntype="void">
		<cfargument name="mPKTable" type="string">
		<cfset variables.instance.PKTable = arguments.mPKTable>
	</cffunction>
	
	<cffunction name="getPKTableColumn" access="public" output="false" returntype="string">
		<cfreturn variables.instance.PKTableColumn>
	</cffunction>

	<cffunction name="setPKTableColumn" access="public" output="false" returntype="void">
		<cfargument name="mPKTableColumn" type="string">
		<cfset variables.instance.PKTableColumn = arguments.mPKTableColumn>
	</cffunction>

	<cffunction name="getdefaultValue" access="public" output="false" returntype="string">
		<cfreturn variables.instance.defaultValue>
	</cffunction>

	<cffunction name="setdefaultValue" access="public" output="false" returntype="void">
		<cfargument name="mdefaultValue" type="string">
		<cfset variables.instance.defaultValue = arguments.mdefaultValue>
	</cffunction>
	
</cfcomponent>