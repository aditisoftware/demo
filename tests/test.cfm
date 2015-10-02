<cfset mailAttributes = {
server="smtp.gmail.com",
username="infotojani@gmail.com",
password="!immortal007",
from="infotojani@gmail.com",
to="infotojani@gmail.com",
subject="This is Error Test"
}
/>

<cfmail port="465" useSSL="true"
attributeCollection="#mailAttributes#"
><cfdump var="#now()#" /></cfmail>
<cfdump var="send" /><cfabort />