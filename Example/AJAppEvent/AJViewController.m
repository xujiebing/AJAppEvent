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
    NSString *name = @"wwwwwwww";
    [self ajAddObserverName:name block:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"%@", eventModel.name);
    }];
    [self ajAddObserverName:name block:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"%@", eventModel.name);
    }];
    [self ajPostNotificationName:name object:@"111" userInfo:@{@"22":@"22"}];
}

- (IBAction)push:(id)sender {
    NSLog(@"");
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
