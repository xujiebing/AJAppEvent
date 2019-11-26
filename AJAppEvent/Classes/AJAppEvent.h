//
//  AJAppEvent.h
//  AJAppEvent
//
//  Created by 徐结兵 on 2019/11/13.
//

#import <Foundation/Foundation.h>
#import <AJAppEvent/AJAppEventModel.h>

#define AJWeakSelf __weak __typeof(self)ajSelf = self;

NS_ASSUME_NONNULL_BEGIN

typedef void(^AJAppEventBlock)(AJAppEventModel *eventModel);

@interface AJAppEvent : NSObject

+ (void)addObserverName:(NSString * _Nonnull)name block:(AJAppEventBlock)block;

+ (void)postNotificationName:(NSString * _Nonnull)name
                      object:(id _Nullable)object
                    userInfo:(NSDictionary * _Nullable)userInfo;

+ (void)didEnterBackground:(AJAppEventBlock)block;

+ (void)willEnterForeground:(AJAppEventBlock)block;

+ (void)didFinishLaunching:(AJAppEventBlock)block;

+ (void)didBecomeActive:(AJAppEventBlock)block;

+ (void)willResignActive:(AJAppEventBlock)block;

+ (void)willTerminate:(AJAppEventBlock)block;

+ (void)didReceiveMemoryWarning:(AJAppEventBlock)block;

+ (void)significantTimeChange:(AJAppEventBlock)block;

+ (void)willChangeStatusBarOrientation:(AJAppEventBlock)block;

+ (void)didChangeStatusBarOrientation:(AJAppEventBlock)block;

+ (void)willChangeStatusBarFrame:(AJAppEventBlock)block;

+ (void)didChangeStatusBarFrame:(AJAppEventBlock)block;

+ (void)backgroundRefreshStatusDidChange:(AJAppEventBlock)block;

+ (void)protectedDataWillBecomeUnavailable:(AJAppEventBlock)block;

+ (void)protectedDataDidBecomeAvailable:(AJAppEventBlock)block;

+ (void)userDidTakeScreenshot:(AJAppEventBlock)block;

@end

NS_ASSUME_NONNULL_END
