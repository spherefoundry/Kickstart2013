//
//  WJStackCalculatorViewController.m
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//


#import "WJStackCalculatorViewController.h"
#import "WJStackCalculatorView.h"


@interface WJStackCalculatorViewController () <WJStackCalculatorViewDelegate>
@end

@implementation WJStackCalculatorViewController {

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)loadView {
    self.view = [[WJStackCalculatorView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    ((WJStackCalculatorView *)self.view).delegate = self;
}

- (void)calculatorView:(WJStackCalculatorView *)calculatorView buttonWasPressed:(WJStackCalculatorViewButtonId)buttonId {
    NSLog(@"button %d was pressed", buttonId);
}

@end