//
//  NSObject+AJAppEvent.m
//  AJAppEvent
//
//  Created by 徐结兵 on 2019/11/27.
//

#import "NSObject+AJAppEvent.h"

static NSString * const ajDictionaryKey = @"ajEventDictionary";

@interface NSObject ()

@property (nonatomic, strong, readwrite) NSMutableDictionary *ajEventDictionary;

@end

@implementation NSObject (AJAppEvent)

#pragma mark - 系统方法

- (void)setAjEventDictionary:(NSMutableDictionary *)eventDictionary {
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(ajDictionaryKey), eventDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)ajEventDictionary {
    return objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(ajDictionaryKey));
}

#pragma mark - 内部方法

- (void)p_ajSetObserviceEventName:(NSNotificationName)name block:(AJAppEventBlock)block {
    if (!block || !name) {
        return;
    }
    [self p_ajHandleEventDictionaryWithName:name block:block];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(p_ajNotificationEvent:) name:name object:nil];
}

- (void)p_ajNotificationEvent:(NSNotification *)obj {
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
    model.userInfo = obj.userInfo;
    model.name = obj.name;
    NSDictionary *dic = self.ajEventDictionary;
    if (!dic) {
        return;
    }
    NSArray *blockArray = [dic objectForKey:model.name];
    [blockArray enumerateObjectsUsingBlock:^(AJAppEventBlock block, NSUInteger idx, BOOL * _Nonnull stop) {
        block(model);
    }];
}

- (void)p_ajHandleEventDictionaryWithName:(NSString *)name block:(AJAppEventBlock)block {
    if (!block || !name) {
        return;
    }
    NSMutableDictionary *dic = self.ajEventDictionary;
    if (!dic) {
        dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    NSArray *keyArray = [dic allKeys];
    if ([keyArray containsObject:name]) {
        NSMutableArray *blockArray = [dic objectForKey:name];
        [blockArray addObject:block];
        [dic setObject:blockArray forKey:name];
    }
    NSMutableArray *blockArray = [NSMutableArray arrayWithArray:@[block]];
    [dic setObject:blockArray forKey:name];
    [self setAjEventDictionary:dic];
}

- (void)p_ajRemoveObserverName:(NSString *)name {
    if (!name) {
        [NSNotificationCenter.defaultCenter removeObserver:self];
        [self setAjEventDictionary:nil];
        return;
    }
    [NSNotificationCenter.defaultCenter removeObserver:self name:name object:nil];
    NSMutableDictionary *dic = self.ajEventDictionary;
    if (!dic) {
        return;
    }
    NSArray *keyArray = [dic allKeys];
    if ([keyArray containsObject:name]) {
        [dic removeObjectForKey:name];
    }
    [self setAjEventDictionary:dic];
}

#pragma mark - 对外方法

- (void)ajAddObserverName:(NSString *)name block:(AJAppEventBlock)block {
    [self p_ajSetObserviceEventName:name block:block];
}

- (void)ajPostNotificationName:(NSString *)name {
    [NSNotificationCenter.defaultCenter postNotificationName:name object:nil];
}

- (void)ajPostNotificationName:(NSString *)name userInfo:(NSDictionary *)userInfo {
    [NSNotificationCenter.defaultCenter postNotificationName:name object:nil userInfo:userInfo];
}

- (void)ajRemoveObserver {
    [self p_ajRemoveObserverName:nil];
}

- (void)ajRemoveObserverName:(NSString *)name {
    [self p_ajRemoveObserverName:name];
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
