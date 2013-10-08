//
//  WJStackCalculatorButtonSequenceTranslator.m
//  Kickstart
//
//  Created by Antoni Kedracki on 10/8/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//


#import "WJStackCalculatorButtonSequenceTranslator.h"


@interface WJStackCalculatorButtonSequenceTranslator ()

@property (nonatomic, assign, readwrite) CGFloat value;

@end

@implementation WJStackCalculatorButtonSequenceTranslator {
    BOOL _dotPressed;
    CGFloat _fractionModifier;
}

@synthesize value = _value;

- (id)init {
    self = [super init];
    if (self) {
        [self clear];
    }

    return self;
}


- (void)inputDigit:(NSUInteger)digit {
    if(digit > 9){
        @throw [NSException exceptionWithName:@"IllegalArgumentException" reason:@"digit out of valid range[0..9]" userInfo:nil];
    }

    if(!_dotPressed){
        self.value = _value * 10.0f + digit;
    } else {
        _fractionModifier *= 0.1f;
        self.value = _value + (float)digit * _fractionModifier;
    }
}

- (void)inputDot {
    _dotPressed = YES;
}

- (void)clear {
    _dotPressed = NO;
    _fractionModifier = 1;
    self.value = 0;
}


@end