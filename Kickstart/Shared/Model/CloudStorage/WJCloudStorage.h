//
//  WJCloudStorage.h
//  Kickstart
//
//  Created by Antoni Kedracki on 10/11/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface WJCloudStorage : NSObject

-(NSString *)localIdentifier;

- (void)getStackOnSuccess:(void (^)(NSArray *))onSuccess onFailure:(void (^)(NSError * error))onFailure;
- (void)putStack:(NSArray *)stack onSuccess:(void (^)())onSuccess onFailure:(void (^)(NSError * error))onFailure;

@end