//
//  RuntimeKit.m
//  EngineeringCool
//
//  Created by Mars on 2019/10/8.
//  Copyright © 2019 Mars. All rights reserved.
//

#import "RuntimeKit.h"

@implementation RuntimeKit

/**
 获取类名
 
 @param isClass 相应类
 @return NSString：类名
 */
+ (NSString *)fetchClassName:(Class)isClass {
    const char *className = class_getName(isClass);
    return [NSString stringWithUTF8String:className];
}

/**
 获取成员变量
 
 @param isClass Class
 @return NSArray
 */
+ (NSArray *)fetchIvarList:(Class)isClass {
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(isClass, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dic[@"type"] = [NSString stringWithUTF8String: ivarType];
        dic[@"ivarName"] = [NSString stringWithUTF8String: ivarName];
        
        [mutableList addObject:dic];
    }
    free(ivarList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取类的属性列表, 包括私有和公有属性，以及定义在延展中的属性
 
 @param isClass Class
 @return 属性列表数组
 */
+ (NSArray *)fetchPropertyList:(Class)isClass {
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(isClass, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutableList addObject:[NSString stringWithUTF8String: propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableList];
}


/**
 获取类的实例方法列表：getter, setter, 对象方法等。但不能获取类方法
 
 @param isClass <#class description#>
 @return <#return value description#>
 */
+ (NSArray *)fetchMethodList:(Class)isClass {
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(isClass, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取协议列表
 
 @param isClass <#class description#>
 @return <#return value description#>
 */
+ (NSArray *)fetchProtocolList:(Class)isClass {
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(isClass, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++ ) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutableList addObject:[NSString stringWithUTF8String: protocolName]];
    }
    
    return [NSArray arrayWithArray:mutableList];
    return nil;
}


/**
 往类上添加新的方法与其实现
 
 @param isClass 相应的类
 @param methodSel 方法的名
 @param methodSelImpl 对应方法实现的方法名
 */
+ (void)addMethod:(Class)isClass method:(SEL)methodSel method:(SEL)methodSelImpl {
    Method method = class_getInstanceMethod(isClass, methodSelImpl);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(isClass, methodSel, methodIMP, types);
}

/**
 方法交换
 
 @param isClass 交换方法所在的类
 @param method1 方法1
 @param method2 方法2
 */
+ (void)methodSwap:(Class)isClass firstMethod:(SEL)method1 secondMethod:(SEL)method2 {
    Method firstMethod = class_getInstanceMethod(isClass, method1);
    Method secondMethod = class_getInstanceMethod(isClass, method2);
    method_exchangeImplementations(firstMethod, secondMethod);
}
@end
