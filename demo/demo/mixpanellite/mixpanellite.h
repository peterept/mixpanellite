//
//  mixpanellite
//
//  Created by Peter Koch
//

#import <Foundation/Foundation.h>

@interface mixpanellite : NSObject

+(void)track:(NSString*)event;
+(void)track:(NSString*)event properties:(NSDictionary*)properties;
+(NSString*)distinctIdentifier;

@end
