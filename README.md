## Nuwan's weatherbot

This is a simple weather app written in Ballerina that fetches daily forecast from accuWeather and send an update to whatsapp

### Configure

in `ballerina.conf` please add the required API keys

```
TWILIO_ACCOUNT_SID=""
TWILIO_AUTH_TOKEN=""
DESTINATION_PHONE_NUMBER=""
TWILIO_SANDBOX_NUMBER="+14155238886"
YOUR_NAME=""
YOUR_ZIP=""
```

For this sample to work, @miyurud has done some fixes to wso2/twillio Ballerina module. You can get that from - https://github.com/miyurud/module-twilio

and add it to `Ballerina.toml` or push to central and refer it.

### Run
`$ballerina run weatherbottask`