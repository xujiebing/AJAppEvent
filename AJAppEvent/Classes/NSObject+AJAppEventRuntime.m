//
//  NSObject+AJAppEventRuntime.m
//  AJAppEvent
//
//  Created by 徐结兵 on 2019/11/27.
//

#import "NSObject+AJAppEventRuntime.h"

static NSString * const ajArrayKey = @"ajEventArray";
static NSString * const ajDictionaryKey = @"ajEventDictionary";

@implementation NSObject (AJAppEventRuntime)

+ (BOOL (^)(SEL _Nonnull, SEL _Nonnull))ajAppEventSwizzleMethod {
    AJAppEventWeakSelf
    BOOL (^block)(SEL, SEL) = ^(SEL origMethod, SEL withMethod){
        Method origMethodInstance = class_getInstanceMethod(ajSelf, origMethod);
        if (!origMethod) {
            return NO;
        }
        Method altMethodInstance = class_getInstanceMethod(ajSelf, withMethod);
        if (!withMethod) {
            return NO;
        }
        class_addMethod(ajSelf,
                        origMethod,
                        class_getMethodImplementation(ajSelf, origMethod),
                        method_getTypeEncoding(origMethodInstance));
        class_addMethod(ajSelf,
                        withMethod,
                        class_getMethodImplementation(ajSelf, withMethod),
                        method_getTypeEncoding(altMethodInstance));
        method_exchangeImplementations(class_getInstanceMethod(ajSelf, origMethod), class_getInstanceMethod(ajSelf, withMethod));
        return YES;
    };
    return block;
}

- (void)setAjEventArray:(NSMutableArray *)eventArray {
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(ajArrayKey), eventArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)ajEventArray {
    return objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(ajArrayKey));
}

- (void)setAjEventDictionary:(NSMutableDictionary *)eventDictionary {
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(ajDictionaryKey), eventDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)ajEventDictionary {
    return objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(ajDictionaryKey));
}

@end
