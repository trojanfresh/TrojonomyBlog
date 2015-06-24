<cfcomponent>

<cffunction name="AddSignLocation">
<cfset var AddSignLocationXML = "">		
          <cfsavecontent variable="AddSignLocationXML ">
          	<cfoutput>
				<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:ser="http://apps.sertifi.net/services/">
					   <soap:Header/>
				  <soap:Body>
				    <ser:AddSigningLocation xmlns="http://apps.sertifi.net/services/">
				       <ser:pstr_APICode>YOURAPI</ser:pstr_APICode>
			      		<ser:pstr_FileID>YOURFILEID</ser:pstr_FileID>
				      <ser:pstr_DocumentID>YOURDOCUMENTID</ser:pstr_DocumentID>
				      <ser:pint_Page>THEPAGEYOURWANTSIGNATUREON</ser:pint_Page>
				      <ser:pint_Top>TOPCOORDINATESONTHEPAGE</ser:pint_Top>
				      <ser:pint_Left>LEFTCOORDINATES</ser:pint_Left>
				      <ser:pstr_SignerEmail>WHATEMAILSHOULDSIGNHERE</ser:pstr_SignerEmail>
				      <ser:pstr_Caption>CAPTIONIFYOUWANTONE</ser:pstr_Caption>
				    </ser:AddSigningLocation>
				  </soap:Body>
				</soap:Envelope>
          	</cfoutput>
          </cfsavecontent>
          <cfset var AddSigningLocation="">
          <cfhttp url="https://apps.sertifi.net/Services/Gateway.asmx" method="post" result="AddSigningLocation">
    			<cfhttpparam type="header" name="SOAPAction" value="http://apps.sertifi.net/services/AddSigningLocation"/>
    			<cfhttpparam type="xml" value="#trim(AddSignLocationXML )#"/>
    		</cfhttp>
    		<cftry>
            	        <cfset var soapResponse = XmlParse(AddSigningLocation.fileContent) /> 
      </cffunction>            

    

    

</cfcomponent>   	
