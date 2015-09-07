component{

	// Configure ColdBox Application
	function configure(){

		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= "Your app name here",
			eventName 				= "event",

			//Development Settings
			reinitPassword			= "1",
			handlersIndexAutoReload = true,

			//Implicit Events
			defaultEvent			= "general.login",
			requestStartHandler		= "Main.onRequestStart",
			requestEndHandler		= "",
			applicationStartHandler = "Main.onAppInit",
			applicationEndHandler	= "",
			sessionStartHandler 	= "",
			sessionEndHandler		= "",
			missingTemplateHandler	= "",

			//Extension Points
			applicationHelper 			= "includes/helpers/ApplicationHelper.cfm",
			viewsHelper					= "",
			coldboxExtensionsLocation 	= "",
			modulesExternalLocation		= [],
			viewsExternalLocation		= "",
			layoutsExternalLocation 	= "",
			handlersExternalLocation  	= "",
			requestContextDecorator 	= "",

			//Error/Exception Handling
			exceptionHandler		= "Main.onException",
			onInvalidEvent			= "Main.onException",
			customErrorTemplate		= "/includes/templates/generic_error.cfm",

			//Application Aspects
			handlerCaching 			= false,
			eventCaching			= false,
			proxyReturnCollection 	= false,
			PagingMaxRows = 10,
			PagingBandGap = 4,
			
			PageSizes = [20, 30, 50]
		};

		// custom settings
		settings = {
			coldboxversion = 4
		};

		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			development = "^demo\.local"
		};

		// Module Directives
		modules = {
			//Turn to false in production
			autoReload = false,
			// An array of modules names to load, empty means all of them
			include = [],
			// An array of modules names to NOT load, empty means none
			exclude = []
		};

		logBox = {
			appenders = {
				emailLog = {
					class="coldbox.system.logging.appenders.EmailAppender",
					properties = {
						from="jani.parixit@gmail.com",
						to="jani.praixit@gmail.com",
						subject="Error occured.",
						mailserver = "127.0.0.1",
						mailusername = "",
						mailpassword = "",
						useSSL = false,
						mailport = 25
					},
					layout="models.logging.errorLogLayout"
				}
			},
			// Root Logger
			root = { levelmax="Warning",levelmin="FATAL", appenders="*" },
			categories = {
				 "emaillogger" = { levelMin="FATAL", levelMax= "FATAL", appenders="emailLog" }
			}
		};

		//Layout Settings
		layoutSettings = {
			defaultLayout = "layout.admin",
			defaultView   = ""
		};

		//Interceptor Settings
		interceptorSettings = {
			throwOnInvalidStates = false,
			customInterceptionPoints = ""
		};

		//Register interceptors as an array, we need order
		interceptors = [
			//SES
			{class="coldbox.system.interceptors.SES",
			 properties={}
			}
		];

		mailSettings = {
			server = "127.0.0.1",
			username = "",
			password = "",
			useSSL = false,
			port = 25
		};
		
		datasources = {
			demo = {name="rahienquiry", dbType="mysql", username="rahienquiry", password="enquiryrahi12$"}
		};

	}

	/**104.194.14.25
	* Development environment
	*/
	function development(){
		structAppend(datasources,{demo = {name="demo", dbType="mysql", username="root", password="##isummation1"}});
		mailSettings ={
			protocol = {
				class = "cbmailservices.models.protocols.FileProtocol",
				properties = {
					filePath = expandPath("/includes/mailspool"),
					autoExpand = false
				}
			}
		};
	}

}