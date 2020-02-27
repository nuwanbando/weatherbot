import ballerina/io;
import ballerina/http;
import wso2/twilio;
import ballerina/config;

#Twilio config
twilio:TwilioConfiguration twilioConfig = {
    accountSId: config:getAsString("TWILIO_ACCOUNT_SID"),
    authToken: config:getAsString("TWILIO_AUTH_TOKEN"),
    xAuthyKey: config:getAsString("X_AUTHY_KEY")
};
twilio:Client twilioClient = new(twilioConfig);

#sending a whatsapp message with today's weather info
public function main() {
    json|error weatherData = fetchTodaysWeather();
    json[] daily = [];
    if(weatherData is json){
        daily = <json[]> weatherData.DailyForecasts;
    }
    string message = "Hello " + config:getAsString("YOUR_NAME") + " good morning!! Today is " 
        + daily[0].Day.IconPhrase.toString() + " and the night is "+ daily[0].Night.IconPhrase.toString() + ". Today's maximum temprature is " 
        + daily[0].Temperature.Maximum.Value.toString() + "F and the minimum temprature is " 
        + daily[0].Temperature.Minimum.Value.toString() + "F. Have a great day!! ~this is ur Ballerina weather bot ;)";
    error? pushToWhatsAppResult = pushToWhatsApp(message);
    if (pushToWhatsAppResult is error) {
            io:println(pushToWhatsAppResult.reason());         
    }
}

function fetchTodaysWeather() returns @tainted json|error {
    http:Client accuWeatherEP = new ("http://dataservice.accuweather.com");
    http:Response weatherResp = new;
    weatherResp = check accuWeatherEP->get("/forecasts/v1/daily/1day/"+ config:getAsString("YOUR_ZIP") +"?apikey=8dbh68Zg2J6WxAK37Cy2jVJTSMdnyAmV");
    return weatherResp.getJsonPayload();
}

function pushToWhatsApp(string message) returns error? {
    var whatsAppResponse = twilioClient->sendWhatsAppMessage("whatsapp:" + config:getAsString("TWILIO_SANDBOX_NUMBER"), 
    "whatsapp:" + config:getAsString("DESTINATION_PHONE_NUMBER"), 
    message);
}
