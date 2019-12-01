//
//  NSObject+AJAppEvent.m
//  AJAppEvent
//
//  Created by 徐结兵 on 2019/11/27.
//

#import "NSObject+AJAppEvent.h"

@implementation NSObject (AJAppEvent)

#pragma mark - 系统方法

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSObject.ajAppEventSwizzleMethod(NSSelectorFromString(@"dealloc"), @selector(ajAppEvent_dealloc));
    });
}

- (void)ajAppEvent_dealloc {
    NSMutableArray *array = self.ajEventArray;
    if (!array) {
        [self ajAppEvent_dealloc];
        return;
    }
    NSString *className = NSStringFromClass([self class]);
    if (![array containsObject:className]) {
        [self ajAppEvent_dealloc];
        return;
    }
    [NSNotificationCenter.defaultCenter removeObserver:self];
    [array removeObject:className];
    [self ajAppEvent_dealloc];
}

#pragma mark - 内部方法

- (void)p_setObserviceEventName:(NSNotificationName)name block:(AJAppEventBlock)block {
    if (!block || !name) {
        return;
    }
    [self p_handleEventArray];
    [self p_handleEventDictionaryWithName:name block:block];
    [self ajRemoveObserverName:name];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(p_notificationEvent:) name:name object:nil];
}

- (void)p_notificationEvent:(NSNotification *)obj {
    if (!obj) {
        return ;
    }
    AJAppEventModel *model = [[AJAppEventModel alloc] init];
    id object = obj.object;
    if ([object isKindOfClass:[UIApplication class]]) {
        model.application = object;
    } else {
        model.object = obj.object;
    }
    model.launchOptions = obj.userInfo;
    model.name = obj.name;
    NSDictionary *dic = self.ajEventDictionary;
    if (!dic) {
        return;
    }
    AJAppEventBlock block = [dic objectForKey:model.name];
    if (!block) {
        return;
    }
    block(model);
}

- (void)p_handleEventArray {
    NSMutableArray *array = self.ajEventArray;
    if (!array) {
        array = [[NSMutableArray alloc] initWithCapacity:0];
    }
    NSString *className = NSStringFromClass([self class]);
    if (![array containsObject:className]) {
        [array addObject:className];
    }
    [self setAjEventArray:array];
}

- (void)p_handleEventDictionaryWithName:(NSString *)name block:(AJAppEventBlock)block {
    if (!block || !name) {
        return;
    }
    NSMutableDictionary *dic = self.ajEventDictionary;
    if (!dic) {
        dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    NSArray *keyArray = [dic allKeys];
    if ([keyArray containsObject:name]) {
        [dic removeObjectForKey:name];
    }
    [dic setObject:block forKey:name];
    [self setAjEventDictionary:dic];
}

#pragma mark - 对外方法

- (void)ajAddObserverName:(NSString *)name block:(AJAppEventBlock)block {
    [self p_setObserviceEventName:name block:block];
}

- (void)ajPostNotificationName:(NSString *)name {
    [NSNotificationCenter.defaultCenter postNotificationName:name object:nil];
}

- (void)ajPostNotificationName:(NSString *)name object:(id)object userInfo:(NSDictionary *)userInfo {
    [NSNotificationCenter.defaultCenter postNotificationName:name object:object userInfo:userInfo];
}

- (void)ajRemoveObserverName:(NSString *)name {
    if (!name) {
        return;
    }
    [NSNotificationCenter.defaultCenter removeObserver:self name:name object:nil];
}

- (void)ajDidEnterBackground:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationDidEnterBackgroundNotification block:block];
}

- (void)ajWillEnterForeground:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationWillEnterForegroundNotification block:block];
}

- (void)ajDidFinishLaunching:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationDidFinishLaunchingNotification block:block];
}

- (void)ajDidBecomeActive:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationDidBecomeActiveNotification block:block];
}

- (void)ajWillResignActive:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationWillResignActiveNotification block:block];
}

- (void)ajWillTerminate:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationWillTerminateNotification block:block];
}

- (void)ajDidReceiveMemoryWarning:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationDidReceiveMemoryWarningNotification block:block];
}

- (void)ajSignificantTimeChange:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationSignificantTimeChangeNotification block:block];
}

- (void)ajWillChangeStatusBarOrientation:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationWillChangeStatusBarOrientationNotification block:block];
}

- (void)ajDidChangeStatusBarOrientation:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationDidChangeStatusBarOrientationNotification block:block];
}

- (void)ajWillChangeStatusBarFrame:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationWillChangeStatusBarFrameNotification block:block];
}

- (void)ajDidChangeStatusBarFrame:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationDidChangeStatusBarFrameNotification block:block];
}

- (void)ajBackgroundRefreshStatusDidChange:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationBackgroundRefreshStatusDidChangeNotification block:block];
}

- (void)ajProtectedDataWillBecomeUnavailable:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationProtectedDataWillBecomeUnavailable block:block];
}

- (void)ajProtectedDataDidBecomeAvailable:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationProtectedDataDidBecomeAvailable block:block];
}

- (void)ajUserDidTakeScreenshot:(AJAppEventBlock)block {
    [self ajAddObserverName:UIApplicationUserDidTakeScreenshotNotification block:block];
}

@end
