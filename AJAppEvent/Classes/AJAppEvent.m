//
//  AJAppEvent.m
//  AJAppEvent
//
//  Created by 徐结兵 on 2019/11/13.
//

#import "AJAppEvent.h"

@interface AJAppEvent ()

+ (AJAppEvent *)shared;

@property (nonatomic, weak, readwrite) AJAppEventBlock didFinishLaunchingBlock;
@property (nonatomic, strong, readwrite) NSMutableDictionary *eventDic;
@end

@implementation AJAppEvent

#pragma mark - 内部方法

static AJAppEvent *shared = nil;
+ (AJAppEvent *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[super allocWithZone:NULL] init];
        [shared p_addObservice];
    });
    return shared;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)p_addObservice {
    NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
    // 应用程序进入后台
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationDidEnterBackgroundNotification
                 object:nil];
    // 应用程序将要进入前台
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationWillEnterForegroundNotification
                 object:nil];
    // 应用程序完成启动
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationDidFinishLaunchingNotification
                 object:nil];
    // 应用程序由挂起变的活跃
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationDidBecomeActiveNotification
                 object:nil];
    // 应用程序挂起(有电话进来或者锁屏)
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationWillResignActiveNotification
                 object:nil];
    // 应用程序终止(后台杀死、手机关机等)
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationWillTerminateNotification
                 object:nil];
    // 应用程序收到内存警告
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    // 当有重大时间改变(凌晨0点，设备时间被修改，时区改变等)
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationSignificantTimeChangeNotification
                 object:nil];
    // 设备方向将要改变
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationWillChangeStatusBarOrientationNotification
                 object:nil];
    // 设备方向改变
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationDidChangeStatusBarOrientationNotification
                 object:nil];
    // 设备状态栏frame将要改变
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationWillChangeStatusBarFrameNotification
                 object:nil];
    // 设备状态栏frame改变
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationDidChangeStatusBarFrameNotification
                 object:nil];
    // 应用程序在后台下载内容的状态发生变化
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationBackgroundRefreshStatusDidChangeNotification
                 object:nil];
    // 本地受保护的文件被锁定,无法访问
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationProtectedDataWillBecomeUnavailable
                 object:nil];
    // 本地受保护的文件可用了
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationProtectedDataDidBecomeAvailable
                 object:nil];
    // 截屏通知
    [center addObserver:self
               selector:@selector(p_notificationEvent:)
                   name:UIApplicationUserDidTakeScreenshotNotification
                 object:nil];
}

- (void)p_notificationEvent:(NSNotification *)obj {
    if (!obj) {
        return ;
    }
    AJAppEventModel *model = [[AJAppEventModel alloc] init];
    model.application = obj.object;
    model.launchOptions = obj.userInfo;
    model.name = obj.name;
    AJAppEventBlock block = [self.eventDic objectForKey:model.name];
    if (!block) {
        return;
    }
    block(model);
}

- (void)p_setObserviceEventBlock:(AJAppEventBlock)block name:(NSNotificationName)name {
    if (!block || !name) {
        return;
    }
    [AJAppEvent.shared.eventDic setObject:block forKey:name];
}

#pragma mark - 对外方法

+ (void)didEnterBackground:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationDidEnterBackgroundNotification];
}

+ (void)willEnterForeground:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationWillEnterForegroundNotification];
}

+ (void)didFinishLaunching:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationDidFinishLaunchingNotification];
}

+ (void)didBecomeActive:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationDidBecomeActiveNotification];
}

+ (void)willResignActive:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationWillResignActiveNotification];
}

+ (void)willTerminate:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationWillTerminateNotification];
}

+ (void)didReceiveMemoryWarning:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationDidReceiveMemoryWarningNotification];
}

+ (void)significantTimeChange:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationSignificantTimeChangeNotification];
}

+ (void)willChangeStatusBarOrientation:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationWillChangeStatusBarOrientationNotification];
}

+ (void)didChangeStatusBarOrientation:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationDidChangeStatusBarOrientationNotification];
}

+ (void)willChangeStatusBarFrame:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationWillChangeStatusBarFrameNotification];
}

+ (void)didChangeStatusBarFrame:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationDidChangeStatusBarFrameNotification];
}

+ (void)backgroundRefreshStatusDidChange:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationBackgroundRefreshStatusDidChangeNotification];
}

+ (void)protectedDataWillBecomeUnavailable:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationProtectedDataWillBecomeUnavailable];
}

+ (void)protectedDataDidBecomeAvailable:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationProtectedDataDidBecomeAvailable];
}

+ (void)userDidTakeScreenshot:(AJAppEventBlock)block {
    [AJAppEvent.shared p_setObserviceEventBlock:block name:UIApplicationUserDidTakeScreenshotNotification];
}


#pragma mark - 懒加载方法
- (NSMutableDictionary *)eventDic {
    if (!_eventDic) {
        _eventDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    }
    return _eventDic;
}

@end
