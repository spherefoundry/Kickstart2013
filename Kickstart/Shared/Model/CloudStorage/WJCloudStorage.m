//
//  WJCloudStorage.m
//  Kickstart
//
//  Created by Antoni Kedracki on 10/11/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//

#import "WJCloudStorage.h"
#import "AFHTTPRequestOperationManager.h"


@implementation WJCloudStorage {
    AFHTTPRequestOperationManager * _manager;
}

- (id)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPRequestOperationManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }

    return self;
}

- (NSString *)localIdentifier {
    return @"abcdefgh";
}

- (NSString *)baseUrl{
    return @"http://ioskickstart2013.appspot.com";
}

- (void)getStackOnSuccess:(void (^)(NSArray *))onSuccess onFailure:(void (^)(NSError *error))onFailure {
    [_manager GET:[NSString stringWithFormat:@"%@/json/%@", self.baseUrl, self.localIdentifier]
       parameters:@{}
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if(onSuccess == nil){
                  return;
              }

              NSDictionary * responseDict = responseObject;
              onSuccess(responseDict[@"values"]);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if(onFailure == nil){
                  return;
              }

              onFailure(error);
          }
    ];
}

- (void)putStack:(NSArray *)stack onSuccess:(void (^)())onSuccess onFailure:(void (^)(NSError *error))onFailure {
    NSString * jsonValueString = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:stack options:0 error:nil] encoding:NSUTF8StringEncoding];

    [_manager POST:[NSString stringWithFormat:@"%@/json/%@", self.baseUrl, self.localIdentifier]
       parameters:@{ @"values" : jsonValueString}
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if(onSuccess == nil){
                  return;
              }
              onSuccess();
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              if(onFailure == nil){
                  return;
              }

              onFailure(error);
          }
    ];
}

@end