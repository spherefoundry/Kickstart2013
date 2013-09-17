//
//  WJCalculator.h
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface WJCalculator : NSObject

@property(nonatomic, assign, readwrite) CGFloat accumulator;

- (void)sqr;
- (void)sqrt;

- (void)add:(CGFloat)a;
- (void)substract:(CGFloat)a;
- (void)multiply:(CGFloat)a;
- (void)divide:(CGFloat)a;

- (void)multiply:(CGFloat)m add:(CGFloat)a;

@end