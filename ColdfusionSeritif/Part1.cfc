
<cfcomponent>

<cffunction name="CreateSigantureRequest">

        <cfset var apicode="YOUR-API-ID">

        <cfset var createsignaturerequestxml="">

        

        <cfsavecontent variable="CreateSignatureRequestXML">

        <cfoutput>

            <soap:envelope xmlns:ser="http://apps.sertifi.net/services/" xmlns:soap="http://www.w3.org/2003/05/soap-envelope">

               <soap:header>

               <soap:body>

                  <ser:createsignaturerequest>

                     <ser:pstr_apicode>#apiCode#</ser:pstr_apicode>

                     <ser:pstr_senderemail>SendingEmail@EMAIL.COM</ser:pstr_senderemail>

                     <ser:pstr_sendername>Sending Mail</ser:pstr_sendername>

                     <ser:pstr_filename>A FILE NAME</ser:pstr_filename>

                     <ser:pstr_signers>TOEMAIL@EMAIL.COM</ser:pstr_signers>

                     <ser:pstr_secondsigners></ser:pstr_secondsigners>

                     <ser:pstr_ccs>If You Want None Signing CC</ser:pstr_ccs>

                     <ser:pstr_signtype>elec</ser:pstr_signtype>

                     <ser:pstr_password></ser:pstr_password>

                     <ser:pstr_field1></ser:pstr_field1>

                     <ser:pstr_field2></ser:pstr_field2>

                     <ser:pstr_field3></ser:pstr_field3>

                     <ser:pstr_field4></ser:pstr_field4>

                     <ser:pstr_emailmessage>Email Message</ser:pstr_emailmessage>

                  </ser:createsignaturerequest>

               </soap:body>

            </soap:header></soap:envelope>

               </cfoutput>

        </cfsavecontent>

        <cfset var createsignaturerequestresultresponse="">

            <cfhttp method="post" result="CreateSignatureRequestResultResponse" url="https://sandbox.sertifi.net/yourcompany/Services/Gateway.asmx">

                <cfhttpparam name="SOAPAction" type="header" value="http://apps.sertifi.net/services/CreateSignatureRequest">

                <cfhttpparam type="xml" value="#trim(CreateSignatureRequestXML)#">

           </cfhttp>

    <cfset var soapresponse= XmlParse(CreateSignatureRequestResultResponse.filecontent)>    

        

    <!--- FileID Generated After Making A SignatureRequest--->

           <cfset var resultfileid="#soapResponse.Envelope.Body.CreateSignatureRequestResponse.CreateSignatureRequestResult.xmltext#">

    <!--- Choose Either Document From Library Or Upload One--->

    <!--- For Now We Will Do Document From Library--->    

    <cfinvoke method="AddPrepopulatedPdfToRequest">

        <cfinvokeargument name="FileId" value="#resultFileID#">    

    </cfinvoke>

    <!--- Or Upload Document

    <cfinvoke method="AddDocumentToRequest"  >

        <cfinvokeargument name="FileId" value="#resultFileID#" >    

    </cfinvoke>--->

</cffunction>
<!---Using Document In Sertifi Library---->

<cffunction name="AddPrepopulatedPdfToRequest">

    <cfargument name="FileId">

    

    <cfset var apicode="YOUR-API-ID" >

        

          <cfset var addprepopulatedpdftorequestxml="">        

          <cfsavecontent variable="AddPrepopulatedPdfToRequestXML">

              <cfoutput>

            <soap:envelope xmlns:ser="http://apps.sertifi.net/services/" xmlns:soap="http://www.w3.org/2003/05/soap-envelope">

              <soap:header>

              <soap:body>

                <ser:addprepopulatedpdftorequest xmlns="http://apps.sertifi.net/services/">

                 <ser:pstr_apicode>#apiCode#</ser:pstr_apicode>

                 <ser:pstr_fileid>#arguments.FileId#</ser:pstr_fileid>

                  <ser:pstr_pdfid>APIFILEIDOFDOCUMENTINLIBRARY</ser:pstr_pdfid>

                 <ser:pstr_title>Title Of Document</ser:pstr_title>

                 <ser:pstr_xml></ser:pstr_xml>

                </ser:addprepopulatedpdftorequest>

              </soap:body>

            </soap:header></soap:envelope>

              </cfoutput>

          </cfsavecontent>

          <cfset var addprepopulatedpdftorequestresultresponse="">

          <cfhttp method="post" result="AddPrepopulatedPdfToRequestResultResponse" url="https://sandbox.sertifi.net/yourcompany/Services/Gateway.asmx">

                <cfhttpparam name="SOAPAction" type="header" value="http://apps.sertifi.net/services/AddPrepopulatedPdfToRequest">

                <cfhttpparam type="xml" value="#trim(AddPrepopulatedPdfToRequestXML )#">

            </cfhttpparam></cfhttpparam></cfhttp>

        <cfset var soapresponse = XmlParse(AddPrepopulatedPdfToRequestResultResponse.filecontent)>  

           

    <!--- DocumentID Generated After Sending AddPrepopulatedPdfToRequest --->

        <cfset var documentid="#soapResponse.Envelope.Body.AddPrepopulatedPdfToRequestResponse.AddPrepopulatedPdfToRequestResult.xmltext#">

</cffunction>

<!---Adding Your Own Document To Request---->

<cffunction name="AddDocumentToRequest">

    <cfargument name="FileId">

    

    <cfset var apicode="YOUR-API-ID">

    <cfset var PdfFile="">

    <cffile action="readbinary" file="/path/tofile.pdf" variable="PdfFile">

    <cfset var AddDocumentToRequestXML="" >        

          <cfsavecontent variable="AddDocumentToRequestXML">

            <cfoutput>

            <soap:envelope xmlns:ser="http://apps.sertifi.net/services/" xmlns:soap="http://www.w3.org/2003/05/soap-envelope">

              <soap:header>

              <soap:body>

                <ser:adddocumenttorequest xmlns="http://apps.sertifi.net/services/">

                 <ser:pstr_apicode>#apiCode#</ser:pstr_apicode>

                 <ser:pstr_fileid>#arguments.FileId#</ser:pstr_fileid>

                   <ser:pbyt_file>#ToBase64(PdfFile)# </ser:pbyt_file>

                 <ser:pstr_filename>FileName.pdf</ser:pstr_filename>

                 <ser:pstr_title>File Title</ser:pstr_title>

                 <ser:pstr_xml></ser:pstr_xml>

                </ser:adddocumenttorequest>

              </soap:body>

            </soap:header></soap:envelope>

              </cfoutput>

          </cfsavecontent>

          <cfset var adddocumenttorequestresponse="">

          <cfhttp method="post"  result="AddDocumentToRequestResponse" url="https://sandbox.sertifi.net/yourcompany/Services/Gateway.asmx">

                <cfhttpparam name="SOAPAction" type="header" value="http://apps.sertifi.net/services/AddDocumentToRequest">

                <cfhttpparam type="xml" value="#trim(AddDocumentToRequestXML )#">

        </cfhttp>

           <cfset var soapresponse= xmlParse(AddDocumentToRequestResponse.filecontent)>    

           

    <!--- DocumentID Generated After Sending AddPrepopulatedPdfToRequest --->

        <cfset var documentid="#soapResponse.Envelope.Body.AddDocumentToRequestResponse.AddDocumentToRequestResult.xmltext#">

</cffunction>            

    

    

</cfcomponent>
