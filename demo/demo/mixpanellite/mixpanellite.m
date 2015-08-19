//
//  mixpanellite
//
//  Created by Peter Koch
//

#import "mixpanellite.h"
#import "NSData+MPbase64.h"

#define MIXPANELLITE_TOKEN @"MY_TOKEN"


@implementation mixpanellite


+(void)track:(NSString*)event {
    return [mixpanellite track:event properties:nil];
}


+(void)track:(NSString*)event properties:(NSDictionary*)properties {
    
    NSMutableDictionary *allProperties = [NSMutableDictionary dictionaryWithObjectsAndKeys:[mixpanellite distinctIdentifier],@"distinct_id", MIXPANELLITE_TOKEN, @"token", nil];
    if (properties != nil) {
      [allProperties addEntriesFromDictionary:properties];
    }
    NSMutableDictionary *eventDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:event,@"event", allProperties, @"properties", nil];
    
    [mixpanellite mixPanelHttpEndpoint:@"track" data:eventDict];
}


+(void)identifySetOnce:(NSDictionary*)properties {
    [mixpanellite identifyUpdate:@"$set_once" properties:properties];
}


+(void)identifySet:(NSDictionary*)properties {
    [mixpanellite identifyUpdate:@"$set" properties:properties];
}


+(void)identifyAdd:(NSDictionary*)properties {
    [mixpanellite identifyUpdate:@"$add" properties:properties];
}


+(void)identifyUpdate:(NSString*)operation properties:(NSDictionary*)properties {

    NSMutableDictionary *eventDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[mixpanellite distinctIdentifier],@"$distinct_id", MIXPANELLITE_TOKEN, @"$token", properties, operation, nil];
    
    [mixpanellite mixPanelHttpEndpoint:@"engage" data:eventDict];
}


+(NSString*)distinctIdentifier {
    
    NSString *UUID = [[NSUserDefaults standardUserDefaults] objectForKey:MIXPANELLITE_TOKEN];
    if (!UUID) {
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        UUID = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
        
        [[NSUserDefaults standardUserDefaults] setObject:UUID forKey:MIXPANELLITE_TOKEN];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return UUID;
}


+(void)mixPanelHttpEndpoint:(NSString*)endpoint data:(NSDictionary*)data {
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:0 error:&error];
    if (error == nil)
    {
        NSLog(@"[MIXPANELLITE] %@ %@", endpoint, [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
        
        NSString *urlTemplate = @"http://api.mixpanel.com/%@/?data=%@";
        NSString *url = [NSString stringWithFormat:urlTemplate, endpoint, [jsonData mp_base64EncodedString]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:nil];
    }
}


@end
