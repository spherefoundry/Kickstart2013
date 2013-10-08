//
//  WJStackCalculatorViewController.m
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//


#import "WJStackCalculatorViewController.h"
#import "WJStackCalculatorView.h"
#import "WJStackCalculatorButtonSequenceTranslator.h"
#import "WJStackCalculator.h"


@interface WJStackCalculatorViewController () <WJStackCalculatorViewDelegate>

@property (nonatomic, readonly) WJStackCalculatorView * calculatorView;

@end

@implementation WJStackCalculatorViewController {
    WJStackCalculatorButtonSequenceTranslator *_translator;
    WJStackCalculator * _calculator;
}

- (id)init {
    self = [super init];
    if (self) {
        _translator = [WJStackCalculatorButtonSequenceTranslator new];
        [_translator addObserver:self
                      forKeyPath:@"value"
                         options:NSKeyValueObservingOptionNew
                         context:nil];

        _calculator = [WJStackCalculator new];
        [_calculator addObserver:self
                      forKeyPath:@"stackX"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
        [_calculator addObserver:self
                      forKeyPath:@"stackY"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    }

    return self;
}

- (void)dealloc {
    [_translator removeObserver:self forKeyPath:@"value"];
    [_calculator removeObserver:self forKeyPath:@"stackX"];
    [_calculator removeObserver:self forKeyPath:@"stackY"];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (WJStackCalculatorView *)calculatorView {
    return (WJStackCalculatorView *) self.view;
}

- (void)loadView {
    self.view = [[WJStackCalculatorView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.calculatorView.delegate = self;
    [self synchronizeModelAndView];
}

- (void)calculatorView:(WJStackCalculatorView *)calculatorView buttonWasPressed:(WJStackCalculatorViewButtonId)buttonId {
    if (buttonId >= WJStackCalculatorViewButtonIdNumber0 && buttonId <= WJStackCalculatorViewButtonIdNumber9) {
        [_translator inputDigit:(buttonId - WJStackCalculatorViewButtonIdNumber0)];
    } else if (buttonId == WJStackCalculatorViewButtonIdNumberDot) {
        [_translator inputDot];
    } else if (buttonId == WJStackCalculatorViewButtonIdClear) {
        [_translator clear];
    } else if(buttonId == WJStackCalculatorViewButtonIdPush){
        [_calculator push:_translator.value];
        [_translator clear];
    } else if(buttonId == WJStackCalculatorViewButtonIdPop){
        [_calculator pop];
    } else if(buttonId == WJStackCalculatorViewButtonIdSwap){
        [_calculator swap];
    } else if(buttonId == WJStackCalculatorViewButtonIdDup){
        [_calculator duplicate];
    } else if(buttonId == WJStackCalculatorViewButtonIdAdd){
        [_calculator add];
    } else if(buttonId == WJStackCalculatorViewButtonIdSubstract){
        [_calculator substract];
    } else if(buttonId == WJStackCalculatorViewButtonIdMultiply){
        [_calculator multiply];
    } else if(buttonId == WJStackCalculatorViewButtonIdDivide){
        [_calculator divide];
    }
}

- (void)synchronizeModelAndView {
    if(![self isViewLoaded]){
        return;
    }

    [self.calculatorView.inputLabel setText:[NSString stringWithFormat:@"%f", _translator.value]];
    [self.calculatorView.stackLabel setText:[NSString stringWithFormat:@"%f\n%f", _calculator.stackX, _calculator.stackY]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == _translator && [keyPath isEqualToString:@"value"]) {
        [self synchronizeModelAndView];
    } else if (object == _calculator && ([keyPath isEqualToString:@"stackX"] || [keyPath isEqualToString:@"stackY"])) {
        [self synchronizeModelAndView];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end