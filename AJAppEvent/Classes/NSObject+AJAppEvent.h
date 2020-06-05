//
//  NSObject+AJAppEvent.h
//  AJAppEvent
//
//  Created by 徐结兵 on 2019/11/27.
//

#import <Foundation/Foundation.h>

typedef void(^AJAppEventBlock)(AJAppEventModel * _Nullable eventModel);

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AJAppEvent)

- (void)ajAddObserverName:(NSString * _Nonnull)name
                    block:(AJAppEventBlock)block;

- (void)ajPostNotificationName:(NSString * _Nonnull)name;

- (void)ajPostNotificationName:(NSString * _Nonnull)name
                      userInfo:(NSDictionary * _Nullable)userInfo;

- (void)ajRemoveObserver;

- (void)ajRemoveObserverName:(NSString * _Nonnull)name;

- (void)ajDidEnterBackground:(AJAppEventBlock)block;

- (void)ajWillEnterForeground:(AJAppEventBlock)block;

- (void)ajDidFinishLaunching:(AJAppEventBlock)block;

- (void)ajDidBecomeActive:(AJAppEventBlock)block;

- (void)ajWillResignActive:(AJAppEventBlock)block;

- (void)ajWillTerminate:(AJAppEventBlock)block;

- (void)ajDidReceiveMemoryWarning:(AJAppEventBlock)block;

- (void)ajSignificantTimeChange:(AJAppEventBlock)block;

- (void)ajWillChangeStatusBarOrientation:(AJAppEventBlock)block;

- (void)ajDidChangeStatusBarOrientation:(AJAppEventBlock)block;

- (void)ajWillChangeStatusBarFrame:(AJAppEventBlock)block;

- (void)ajDidChangeStatusBarFrame:(AJAppEventBlock)block;

- (void)ajBackgroundRefreshStatusDidChange:(AJAppEventBlock)block;

- (void)ajProtectedDataWillBecomeUnavailable:(AJAppEventBlock)block;

- (void)ajProtectedDataDidBecomeAvailable:(AJAppEventBlock)block;

- (void)ajUserDidTakeScreenshot:(AJAppEventBlock)block;

@end

NS_ASSUME_NONNULL_END
