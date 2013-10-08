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


@interface WJStackCalculatorViewController () <WJStackCalculatorViewDelegate>

@property (nonatomic, readonly) WJStackCalculatorView * calculatorView;

@end

@implementation WJStackCalculatorViewController {
    WJStackCalculatorButtonSequenceTranslator *_translator;
}

- (id)init {
    self = [super init];
    if (self) {
        _translator = [WJStackCalculatorButtonSequenceTranslator new];
        [_translator addObserver:self
                      forKeyPath:@"value"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    }

    return self;
}

- (void)dealloc {
    [_translator removeObserver:self forKeyPath:@"value"];
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
    NSLog(@"button %d was pressed", buttonId);

    if (buttonId >= WJStackCalculatorViewButtonIdNumber0 && buttonId <= WJStackCalculatorViewButtonIdNumber9) {
        [_translator inputDigit:(buttonId - WJStackCalculatorViewButtonIdNumber0)];
    } else if (buttonId == WJStackCalculatorViewButtonIdNumberDot) {
        [_translator inputDot];
    } else if (buttonId == WJStackCalculatorViewButtonIdClear) {
        [_translator clear];
    }
}

- (void)synchronizeModelAndView {
    if(![self isViewLoaded]){
        return;
    }

    [self.calculatorView.inputLabel setText:[NSString stringWithFormat:@"%f", _translator.value]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == _translator && [keyPath isEqualToString:@"value"]) {
        NSLog(@"translator changed value: %f", _translator.value);
        [self synchronizeModelAndView];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end