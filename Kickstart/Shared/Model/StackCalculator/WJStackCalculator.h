//
//  WJStackCalculator.h
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJStackCalculator : NSObject

@property (nonatomic, assign, readonly) NSUInteger stackDepth;

@property (nonatomic, assign, readonly) CGFloat stackX;
@property (nonatomic, assign, readonly) CGFloat stackY;

- (CGFloat)valueAtDepth:(NSUInteger)depth;

-(void) push:(CGFloat)a;
-(CGFloat) pop;
-(void) swap;
-(void) duplicate;

- (void)sqr;
- (void)sqrt;

- (void)add;
- (void)substract;
- (void)multiply;
- (void)divide;

- (void)multiplyAdd;

@end
