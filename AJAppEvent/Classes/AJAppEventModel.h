//
//  AJAppEventModel.h
//  AJAppEvent
//
//  Created by 徐结兵 on 2019/11/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJAppEventModel : NSObject

/// 时间名称
@property (nonatomic, copy, readwrite) NSString *name;

/// application对象
@property (nonatomic, strong, readwrite) UIApplication *application;

/// 传递对象
@property (nonatomic, strong, readwrite) UIApplication *object;

/// 参数
@property (nonatomic, strong, readwrite) NSDictionary *launchOptions;

@end

NS_ASSUME_NONNULL_END
