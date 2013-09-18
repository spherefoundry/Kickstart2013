//
//  WJStackCalculator.m
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//

#import "WJStackCalculator.h"

@implementation WJStackCalculator {
    NSMutableArray * _stack;
}

- (id)init {
    self = [super init];
    if (self) {
        _stack = [NSMutableArray array];
    }

    return self;
}


- (NSUInteger)stackDepth {
    return [_stack count];
}

- (CGFloat)stackX {
    if([_stack count] == 0){
        return 0;
    }
    return [[_stack lastObject] floatValue];
}

- (CGFloat)stackY {
    if([_stack count] <= 1){
        return 0;
    }
    return [[_stack objectAtIndex:[_stack count] - 2] floatValue];
}

- (void)push:(CGFloat)a {
    [_stack addObject:[NSNumber numberWithFloat:a]];
}

- (CGFloat)pop {
    if([_stack count] == 0){
        return 0;
    }
    CGFloat a = [[_stack lastObject] floatValue];
    [_stack removeLastObject];
    return a;
}

- (void)swap {
    if([_stack count] < 2){
        return;
    }

    [_stack exchangeObjectAtIndex:(_stack.count - 1) withObjectAtIndex:(_stack.count - 2)];
}

- (void)duplicate {
    if([_stack count] == 0){
        return;
    }

    [_stack addObject:[_stack lastObject]];
}

- (void)add {
    [self pop2push1op:^CGFloat(CGFloat a, CGFloat b) {
         return a + b;
    }];
}

- (void)substract {
    [self pop2push1op:^CGFloat(CGFloat a, CGFloat b) {
        return b - a;
    }];
}

- (void)multiply {
    [self pop2push1op:^CGFloat(CGFloat a, CGFloat b) {
        return a * b;
    }];
}

- (void)divide {
    [self pop2push1op:^CGFloat(CGFloat a, CGFloat b) {
        return b / a;
    }];
}

- (void)multiplyAdd {
    [self pop3push1op:^CGFloat(CGFloat a, CGFloat b, CGFloat c) {
        return c * b + a;
    }];
}

- (void)sqrt {
    [self pop1push1op:^CGFloat(CGFloat a) {
        return sqrtf(a);
    }];
}

- (void)sqr {
    [self pop1push1op:^CGFloat(CGFloat a) {
        return a * a;
    }];
}

-(void)pop1push1op:(CGFloat (^)(CGFloat a))op{
    CGFloat a = [self pop];

    [self push:op(a)];
}

-(void)pop2push1op:(CGFloat (^)(CGFloat a, CGFloat b))op{
    CGFloat a = [self pop];
    CGFloat b = [self pop];

    [self push:op(a, b)];
}

-(void)pop3push1op:(CGFloat (^)(CGFloat a, CGFloat b, CGFloat c))op{
    CGFloat a = [self pop];
    CGFloat b = [self pop];
    CGFloat c = [self pop];

    [self push:op(a, b, c)];
}


@end
