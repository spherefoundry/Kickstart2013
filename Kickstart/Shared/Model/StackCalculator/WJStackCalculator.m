//
//  WJStackCalculator.m
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//

#import "WJStackCalculator.h"

@implementation WJStackCalculator {
    NSMutableArray *_stack;
    NSUInteger _transactionDepth;
}

- (id)init {
    self = [super init];
    if (self) {
        _stack = [NSMutableArray array];
        _transactionDepth = 0;
    }

    return self;
}

- (void)beginTransaction {
    if(_transactionDepth == 0){
        [self willChangeValueForKey:@"stackDepth"];
        [self willChangeValueForKey:@"stackX"];
        [self willChangeValueForKey:@"stackY"];
    }
    ++_transactionDepth;
}

- (void)endTransaction {
    if(_transactionDepth == 0){
        return;
    }

    if(_transactionDepth == 1){
        [self didChangeValueForKey:@"stackY"];
        [self didChangeValueForKey:@"stackX"];
        [self didChangeValueForKey:@"stackDepth"];
    }
    --_transactionDepth;
}

- (NSUInteger)stackDepth {
    return [_stack count];
}

- (CGFloat)stackX {
    if ([_stack count] == 0) {
        return 0;
    }
    return [[_stack lastObject] floatValue];
}

- (CGFloat)stackY {
    if ([_stack count] <= 1) {
        return 0;
    }
    return [[_stack objectAtIndex:[_stack count] - 2] floatValue];
}

- (CGFloat)valueAtDepth:(NSUInteger)depth {
    if(depth > self.stackDepth){
        @throw [NSException exceptionWithName:NSRangeException reason:@"depth is out of range" userInfo:nil];
    }

    return [[_stack objectAtIndex:[_stack count] - 1 - depth] floatValue];
}


- (void)push:(CGFloat)a {
    [self beginTransaction];

    [_stack addObject:[NSNumber numberWithFloat:a]];

    [self endTransaction];
}

- (CGFloat)pop {
    if ([_stack count] == 0) {
        return 0;
    }

    [self beginTransaction];

    CGFloat a = [[_stack lastObject] floatValue];
    [_stack removeLastObject];

    [self endTransaction];
    return a;
}

- (void)swap {
    if([_stack count] < 2){
        return;
    }

    [self beginTransaction];

    [_stack exchangeObjectAtIndex:(_stack.count - 1) withObjectAtIndex:(_stack.count - 2)];

    [self endTransaction];
}

- (void)duplicate {
    if ([_stack count] == 0) {
        return;
    }

    [self beginTransaction];

    [_stack addObject:[_stack lastObject]];

    [self endTransaction];
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

- (void)pop1push1op:(CGFloat (^)(CGFloat a))op {
    [self beginTransaction];

    CGFloat a = [self pop];

    [self push:op(a)];

    [self endTransaction];
}

- (void)pop2push1op:(CGFloat (^)(CGFloat a, CGFloat b))op {
    [self beginTransaction];

    CGFloat a = [self pop];
    CGFloat b = [self pop];

    [self push:op(a, b)];

    [self endTransaction];
}

- (void)pop3push1op:(CGFloat (^)(CGFloat a, CGFloat b, CGFloat c))op {
    [self beginTransaction];

    CGFloat a = [self pop];
    CGFloat b = [self pop];
    CGFloat c = [self pop];

    [self push:op(a, b, c)];

    [self endTransaction];
}


@end
