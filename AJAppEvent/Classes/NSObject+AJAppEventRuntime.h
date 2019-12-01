//
//  NSObject+AJAppEventRuntime.h
//  AJAppEvent
//
//  Created by 徐结兵 on 2019/11/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject ()

@property (nonatomic, strong, readwrite) NSMutableArray *ajEventArray;
@property (nonatomic, strong, readwrite) NSMutableDictionary *ajEventDictionary;

@end

@interface NSObject (AJAppEventRuntime)

/// 交换实例方法
/// - Parameters:
///   - origMethod: 原有的方法
///   - withMethod: 替换的方法
+ (BOOL (^)(SEL origMethod, SEL withMethod))ajAppEventSwizzleMethod;

@end

NS_ASSUME_NONNULL_END
