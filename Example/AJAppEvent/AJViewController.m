//
//  AJViewController.m
//  AJAppEvent
//
//  Created by xujiebing on 11/12/2019.
//  Copyright (c) 2019 xujiebing. All rights reserved.
//

#import "AJViewController.h"
#import "AJViewController1.h"
#import <AJAppEvent/AJAppEvent.h>

@interface AJViewController ()

@end

@implementation AJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.lightGrayColor;
    AJAppEventWeakSelf
    [self ajDidFinishLaunching:^(AJAppEventModel * _Nullable eventModel) {
        NSLog(@"%@", eventModel.name);
        NSLog(@"使用ajSelf，防止内存泄漏=====%@", ajSelf.class);
    }];
    [self ajDidBecomeActive:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"%@", eventModel.name);
    }];
    [self ajDidEnterBackground:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"%@", eventModel.name);
    }];
    NSString *name = @"wwwwwwww";
    [self ajAddObserverName:name block:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"%@", eventModel.name);
    }];
    [self ajPostNotificationName:name object:@"111" userInfo:@{@"22":@"22"}];
    [self ajAddObserverName:name block:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"%@", eventModel.name);
    }];
}

- (IBAction)push:(id)sender {
    [self.navigationController pushViewController:AJViewController1.new animated:YES];
}

- (IBAction)notification:(id)sender {
    [self ajPostNotificationName:@"AJViewController1" object:nil userInfo:nil];
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
