<cfcomponent>

<cffunction name="InviteSigner">
<cfset var InviteSigner = "">		
     <cfsavecontent variable="InviteSigner">
      <cfoutput>
	  <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ser="http://apps.sertifi.net/services/">
		<soap:Header/>
			<soap:Body>
				<ser:InviteSigner xmlns="http://apps.sertifi.net/services/">
				   <ser:pstr_APICode>YOURAPICODE</ser:pstr_APICode>
			      	<ser:pstr_FileID>FILEIDOFSIGNATUREREQUEST</ser:pstr_FileID>
				    <ser:pstr_EmailMessage>MessageForEmail</ser:pstr_EmailMessage>
				    <ser:pstr_Signer>EmailToInviteSigner</ser:pstr_Signer>
				  </ser:InviteSigner>
			</soap:Body>
	   </soap:Envelope>
       </cfoutput>
      </cfsavecontent>
      <cfset var httpResponse="">    
          <cfhttp url="YOURURL"  method="post" result="httpResponse">
    			<cfhttpparam type="header" name="SOAPAction" value="http://apps.sertifi.net/services/InviteSigner"/>
    			<cfhttpparam type="xml" value="#trim(InviteSigner )#"/>
    		</cfhttp>
    		<cftry>
            	        <cfset soapResponse = XmlParse(httpResponse.fileContent) />    
            	       
            <cfcatch type="Any" >
<!---come try and catch love to catch any errors--->
						<cfdump var="#httpResponse#">
						<cfdump var="#cfcatch#">
            		<cfabort>
            </cfcatch>
            </cftry>
            </cffunction>            

    

    

</cfcomponent>
