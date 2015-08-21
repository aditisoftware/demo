<cfcomponent>
	<cffunction name="init" access="public" output="false" returntype="ValidatorService">
		<cfset variables.supportedValidators = "required,email,url,creditcard,maxlength,minlength,number,digits,max,min,date">
		<cfreturn this>
	</cffunction>

	<cffunction name="getValidatorsByColumn" access="public" output="false" returntype="Array">
		<cfargument name="column" required="true" type="column" />
		<cfscript>
			var validators = ArrayNew(1);
			if(column.getRequired()){
				ArrayAppend(validators,createValidator('required',true));
			}
			switch(column.getCfSqlType()){
				case "cf_sql_bigint":
				case "cf_sql_integer":
				case "cf_sql_smallint":
					ArrayAppend(validators,createValidator('digits',true));
					break;
				case "cf_sql_tinyint":
					ArrayAppend(validators,createValidator('digits',true));
					break;
				case "cf_sql_timestamp":
				case "cf_sql_date":
					ArrayAppend(validators,createValidator('date',true));
					break;
				case "cf_sql_decimal":
				case "cf_sql_numeric":
				case "cf_sql_float":
				case "cf_sql_money":
				case "cf_sql_real":
					ArrayAppend(validators,createValidator('number',true));
					break;
				case "cf_sql_char":
				case "cf_sql_varchar":
					if(column.getLength() neq -1) //settings for VARCHAR(MAX)
						ArrayAppend(validators,createValidator('maxlength',column.getLength()));
					break;
			}
			return validators;
		</cfscript>
	</cffunction>

	<cffunction name="createValidator" access="public" output="false" returntype="validator">
		<cfargument name="validatorType" required="true" type="string">
		<cfargument name="validatorValue" required="true" type="string" default="">
		<cfargument name="validatorMsg" required="true" type="string" default="">
		<cfscript>
			var validator = createObject("component","Validator").init();
			switch(arguments.validatorType){
				case "required":
					validator.setName("required");
					validator.setErrorMessage("This field is required");
					validator.setValue(arguments.validatorValue);
					break;
				case "email":
					validator.setName("email");
					validator.setErrorMessage("Please enter a valid email address");
					validator.setValue(arguments.validatorValue);
					break;
				case "url":
					validator.setName("url");
					validator.setErrorMessage("Please enter a valid URL");
					validator.setValue(arguments.validatorValue);
					break;
				case "creditcard":
					validator.setName("creditcard");
					validator.setErrorMessage("Please enter a valid credit card number");
					validator.setValue(arguments.validatorValue);
					break;
				case "maxlength":
					validator.setName("maxlength");
					validator.setErrorMessage("This field no more than {0} characters");
					validator.setValue(arguments.validatorValue);
					break;
				case "minlength":
					validator.setName("minlength");
					validator.setErrorMessage("Please enter at least {0} characters");
					validator.setValue(arguments.validatorValue);
					break;
				case "number":
					validator.setName("number");
					validator.setErrorMessage("This field must be numeric");
					validator.setValue(arguments.validatorValue);
					break;
				case "digits":
					validator.setName("digits");
					validator.setErrorMessage("This field must be numeric");
					validator.setValue(arguments.validatorValue);
					break;
				case "max":
					validator.setName("max");
					validator.setErrorMessage("Please enter a value less than or equal to {0}");
					validator.setValue(arguments.validatorValue);
					break;
				case "min":
					validator.setName("min");
					validator.setErrorMessage("Please enter a value greater than or equal to {0}");
					validator.setValue(arguments.validatorValue);
					break;
				case "date":
					validator.setName("date");
					validator.setErrorMessage("This field is not a valid date");
					validator.setValue(arguments.validatorValue);
					break;
			}
			//Override defualt message if passed as argument
			if(len(arguments.validatorMsg))
				validator.setErrorMessage(arguments.validatorMsg);
			return validator;
		</cfscript>
	</cffunction>

	<cffunction name="getAllValidators" access="public" output="false" returntype="Array">
		<cfscript>
			var arrValidators = ArrayNew(1);
			var i=1;
			for(i=1;i<=listlen(variables.supportedValidators);i=i+1){
				ArrayAppend(arrValidators,createValidator(listGetAt(variables.supportedValidators,i)));
			}
			return arrValidators;
		</cfscript>
	</cffunction>
</cfcomponent>