//
//  AJViewController1.m
//  AJAppEvent_Example
//
//  Created by 徐结兵 on 2019/11/27.
//  Copyright © 2019 xujiebing. All rights reserved.
//

#import "AJViewController1.h"
#import <AJAppEvent/AJAppEvent.h>

@interface AJViewController1 ()

@end

@implementation AJViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self ajAddObserverName:@"AJViewController1" block:^(AJAppEventModel * _Nonnull eventModel) {
        NSLog(@"2222222==%@", eventModel.name);
    }];
    [self ajPostNotificationName:@"AJViewController1"];
}

- (void)dealloc {
    NSLog(@"AJViewController1没有内存泄漏哦");
}

@end
