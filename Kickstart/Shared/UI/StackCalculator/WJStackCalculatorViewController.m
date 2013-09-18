//
//  WJStackCalculatorViewController.m
//  Kickstart
//
//  Created by Antoni Kedracki on 9/17/13.
//  Copyright (c) 2013 Warsjava. All rights reserved.
//


#import "WJStackCalculatorViewController.h"
#import "WJStackCalculatorView.h"


@implementation WJStackCalculatorViewController {

}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)loadView {
    self.view = [[WJStackCalculatorView alloc] initWithFrame:CGRectZero];
}

@end