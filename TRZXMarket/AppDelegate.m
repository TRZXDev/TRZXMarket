//
//  AppDelegate.m
//  TRZXMarket
//
//  Created by N年後 on 2017/2/20.
//  Copyright © 2017年 TRZX. All rights reserved.
//

#import "AppDelegate.h"
#import "TRZXMap.h"
#import "TRZXNetwork.h"

#define kAMapAppKey @"f1060ef1f62bef18731182fa5983ddf8"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    /** 高德地图平台 */
    [AMapServices sharedServices].apiKey = kAMapAppKey;


    NSMutableDictionary *headers = [[NSMutableDictionary alloc]init];
    [headers setValue:@"7a06aecbda8db7cb30665e919cdf8433" forKey:@"token"];
    [headers setValue:@"d8c86c8f343e4de6a9faab7e148bed63" forKey:@"userId"];


    [TRZXNetwork configWithBaseURL:@"http://test.mmwipo.com:8088/"];
    [TRZXNetwork configWithNewBaseURL:@"http://123.56.228.107:8081/"];

    // 配置请求头
    [TRZXNetwork configHttpHeaders:headers];

    [[TRZXMapManage sharedManager] startLocation:^(AMapLocationReGeocode *regeocode) {

        NSLog(@">>>>>>>>>>>>>>>>%@",regeocode.city);
        
        
    }];


    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
