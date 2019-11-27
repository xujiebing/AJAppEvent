//
//  NSObject+AJAppEventRuntime.h
//  AJAppEvent
//
//  Created by 徐结兵 on 2019/11/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AJAppEventRuntime)

/// 交换实例方法
/// - Parameters:
///   - origMethod: 原有的方法
///   - withMethod: 替换的方法
+ (BOOL (^)(SEL origMethod, SEL withMethod))ajAppEventSwizzleMethod;

- (void)setAjEventArray:(NSMutableArray *)eventArray;

- (NSMutableArray *)ajEventArray;

- (void)setAjEventDictionary:(NSMutableDictionary *)eventDictionary;

- (NSMutableDictionary *)ajEventDictionary;

@end

NS_ASSUME_NONNULL_END
