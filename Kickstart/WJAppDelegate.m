//
//  WJAppDelegate.m
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//

#import "WJAppDelegate.h"
#import "WJStackCalculatorViewController.h"
#import "WJCloudStorage.h"

@implementation WJAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _cloudStorage = [[WJCloudStorage alloc] init];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    self.window.rootViewController = [WJStackCalculatorViewController new];

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end

@implementation WJCloudStorage(SharedInstanceAccessor)

+ (WJCloudStorage *)sharedInstance {
    WJAppDelegate * appDelegate = (WJAppDelegate *) [UIApplication sharedApplication].delegate;
    return appDelegate.cloudStorage;
}

@end