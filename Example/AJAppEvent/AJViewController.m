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
	// Do any additional setup after loading the view, typically from a nib.
    [AJAppEvent didFinishLaunching:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"%@", eventModel.name);
    }];
    [AJAppEvent didBecomeActive:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"%@", eventModel.name);
    }];
    [AJAppEvent didEnterBackground:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"%@", eventModel.name);
    }];

    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(p_didFinishLaunching:) name:UIApplicationDidFinishLaunchingNotification object:nil];
    
}

- (void)p_didFinishLaunching:(NSNotification *)obj {
    // TODO:处理业务代码
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
