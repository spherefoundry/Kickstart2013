//
//  WJCalculator.m
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//


#import "WJCalculator.h"


@implementation WJCalculator {

}

@synthesize accumulator = _accumulator;

- (void)sqr {
    self.accumulator *= self.accumulator;
}

- (void)sqrt {
    self.accumulator = sqrtf(self.accumulator);
}

- (void)add:(CGFloat)a {
    [self willChangeValueForKey:@"accumulator"];
    _accumulator += a;
    [self didChangeValueForKey:@"accumulator"];
}

- (void)substract:(CGFloat)a {
    self.accumulator -= a;
}

- (void)multiply:(CGFloat)a {
    self.accumulator *= a;
}

- (void)divide:(CGFloat)a {
    self.accumulator /= a;
}

- (void)multiply:(CGFloat)m add:(CGFloat)a {
    self.accumulator = self.accumulator * m + a;
}


@end