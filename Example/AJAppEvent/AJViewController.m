//
//  AJViewController.m
//  AJAppEvent
//
//  Created by xujiebing on 11/12/2019.
//  Copyright (c) 2019 xujiebing. All rights reserved.
//

#import "AJViewController.h"
#import <AJAppEvent/AJAppEvent.h>

@interface AJViewController ()

@end

@implementation AJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
    AJWeakSelf
    [AJAppEvent didFinishLaunching:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"%@", eventModel.name);
        NSLog(@"使用ajSelf，防止内存泄漏=====%@", ajSelf.class);
    }];
    [AJAppEvent didBecomeActive:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"%@", eventModel.name);
    }];
    [AJAppEvent didEnterBackground:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"%@", eventModel.name);
    }];
    
    
}

- (void)dealloc {
    NSLog(@"没有内存泄漏哦");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
