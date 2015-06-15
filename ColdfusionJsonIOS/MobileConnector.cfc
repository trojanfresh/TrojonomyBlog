component
{
	remote any  function getComputerParts() returnFormat="JSON"{
		
		/*This is the main object going to be returned*/
		var mainReturn = [];	
		/*Actually result set of data being returned */
		var result = [];
		/*Status this is added to help give a reference to the device if things went successfull*/
		var status = [];
		
		/*Create Array Length 1 For mainReturn*/
				mainReturn[arrayLen(mainReturn) + 1] = {};
		/*Create Array Length 1 For status*/
				status[arrayLen(status) + 1] = {};
				
		/*By default we will always return Success 200 In this example But this will give you the ability
		to can the return like Failed  Reason -- Invalid Login and so on */
		/* Create Status Object*/
				status[arrayLen(status)]["Status"] = "Success";
				status[arrayLen(status)]["Reason"] = "";
				status[arrayLen(status)]["Code"] = "200";
		/* Now we have an Object For Status We Add It To the To Any Array For Object Main Return*/
				mainReturn[arrayLen(mainReturn)]["Status"] = "#status#";
			
		/* Okay data yum fun stuff*/
		/* Here you can loop many records or just have one below is just a sample*/	
					result[arrayLen(result) + 1] = {};
					result[arrayLen(result)]["name"] = "RAM";
					result[arrayLen(result)]["price"] = "100";
					result[arrayLen(result)]["brand"] = "Kingston";
			
					result[arrayLen(result) + 1] = {};
					result[arrayLen(result)]["name"] = "CPU";
					result[arrayLen(result)]["price"] = "200";
					result[arrayLen(result)]["brand"] = "Intel";
			/* now we have to records for our result*/
			/* add the results to mainReturn*/
					mainReturn[arrayLen(mainReturn) + 1] = {};
					mainReturn[arrayLen(mainReturn)]["results"] = "#result#";
					mainReturn[arrayLen(mainReturn) + 1] = {};
			/* add recordcount mainReturn giving us an easy way to tell how many records there are*/
					mainReturn[arrayLen(mainReturn)]["rowcounts"] = "#arraylen(result)#";
					
					
			/* So how it will look is this 
				ARRAY["STATUSOBJECT{ARRAYSTAUTS}","RESULTSOBJECT{ARRAYRESULTS[OBJECTPERRESULT]}","ROWCOUNTOBECT{JUSTSTRING}"]*/
				
					return serializeJson(mainReturn);
	}
}