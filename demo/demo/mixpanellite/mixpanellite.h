//
//  mixpanellite
//
//  Created by Peter Koch
//

#import <Foundation/Foundation.h>

@interface mixpanellite : NSObject

+(void)track:(NSString*)event;
+(void)track:(NSString*)event properties:(NSDictionary*)properties;
+(void)identifySetOnce:(NSDictionary*)properties;
+(void)identifySet:(NSDictionary*)properties;
+(void)identifyAdd:(NSDictionary*)properties;
+(NSString*)distinctIdentifier;

@end
