//
//  ViewController.m
//  demo
//
//  Created by Peter Koch on 8/19/15.
//  Copyright (c) 2015 Peter Koch. All rights reserved.
//

#import "ViewController.h"
#import "mixpanellite.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // MixPanel examples:
    
    // Launched event
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[[UIDevice currentDevice] model] forKey:@"Device Model"];
    [dict setObject:[[UIDevice currentDevice] systemName] forKey:@"Device System Name"];
    [dict setObject:[[UIDevice currentDevice] systemVersion] forKey:@"Device System Version"];
    [dict setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:@"App Identifier"];
    [dict setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey] forKey:@"App Build"];
    [dict setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:@"App Version"];
    [dict setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey] forKey:@"App Name"];
    [mixpanellite track:@"Launched" properties:dict];
    
    // First ever run date time
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    NSString *nowDateString = [dateFormatter stringFromDate:[NSDate date]];
    NSDictionary *setOnceProperties = [NSDictionary dictionaryWithObjectsAndKeys:nowDateString, @"First Launched", nil];
    [mixpanellite identifySetOnce:setOnceProperties];

    // Last Launch
    NSDictionary *setProperties = [NSDictionary dictionaryWithObjectsAndKeys:nowDateString, @"Last Launched", nil];
    [mixpanellite identifySet:setProperties];
    
    // Increment Run Count
    NSDictionary *addProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1], @"Launch Count", nil];
    [mixpanellite identifyAdd:addProperties];
  
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
