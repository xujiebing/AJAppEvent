//
//  AJAppEvent.h
//  AJAppEvent
//
//  Created by 徐结兵 on 2019/11/13.
//

#import <Foundation/Foundation.h>
@class AJAppEventModel;

NS_ASSUME_NONNULL_BEGIN

typedef void(^AJAppEventBlock)(AJAppEventModel *eventModel);

@interface AJAppEvent : NSObject

+ (void)didFinishLaunching:(AJAppEventBlock)block;


@end

NS_ASSUME_NONNULL_END
