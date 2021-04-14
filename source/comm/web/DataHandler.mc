using Toybox.Communications;

function WheelLog_getData(dataType) {
    if (dataType == :main) {
        var options = {
			:method => Communications.HTTP_REQUEST_METHOD_GET,
			:headers => {},
			:responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
		};
        Communications.makeWebRequest("http://127.0.0.1" + WheelData.webServerPort + "/data?type=main", null, options, method(:onHttpResponse));
    } else if (dataType == :details) {
        
    }
}

function WheelLog_onHttpResponse(responseCode, data) {
    if (responseCode == 200) {
        parseDataFromWheelLog(data);
    }
}