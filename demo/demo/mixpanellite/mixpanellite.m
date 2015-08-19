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
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:eventDict options:0 error:&error];
    if (error == nil)
    {
        NSLog(@"[MIXPANELLITE] %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
        NSString *urlTemplate = @"http://api.mixpanel.com/track/?data=%@";
        NSString *url = [NSString stringWithFormat:urlTemplate, [jsonData mp_base64EncodedString]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:nil];
    }
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

@end
