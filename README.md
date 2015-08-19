# MixPanel Lite
A cut back implementation of MixPanel for iOS 

*Note: This is an unofficial SDK for MixPanel - I am not associated with MixPanel in any way - I do love using it though.*

The official MixPanel iOS SDK can be located here: https://mixpanel.com/help/reference/ios

It is action packed full of features... but, I didn't want to have all those features in some of my builds. I wanted a small subset - but it is difficult to extract just those features. I also had an app that had a user pressing down with 4 fingers quite often, and I didn't want MixPanel sending requests to connect the app to their portal.

So I created this small version based on their published HTTP spec: https://mixpanel.com/help/reference/http

*MixPanelLite only supports:*

- track event (with properties)
- generating a distinct id as UUID and storing it in preferences 
- No logging, or guaranteed delivery
 
# To install:

- Copy the mixpanellite folder into your xcode project folder and add the files to your project
- Set your MixPanel token in mixpanellite.m
- You're Done

# To use:

If you want to track an event, use:

    [mixpanellite track:@"App Launched"];
  
If you want to add custom properties, use:

    NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:[[UIDevice currentDevice] model], @"Device Model", nil];
    [mixpanellite track:@"App Launched" properties:properties];
    
  
