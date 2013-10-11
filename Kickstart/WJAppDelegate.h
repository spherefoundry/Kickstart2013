//
//  WJAppDelegate.h
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJCloudStorage.h"


@interface WJAppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;

@property(strong, readonly) WJCloudStorage *cloudStorage;

@end

@interface WJCloudStorage (SharedInstanceAccessor)

+ (WJCloudStorage *)sharedInstance;

@end
