//
//  AJAppEventModel.h
//  AJAppEvent
//
//  Created by 徐结兵 on 2019/11/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJAppEventModel : NSObject

@property (nonatomic, copy, readwrite) NSString *name;

@property (nonatomic, strong, readwrite) UIApplication *application;

@property (nonatomic, strong, readwrite) NSDictionary *launchOptions;

@end

NS_ASSUME_NONNULL_END
