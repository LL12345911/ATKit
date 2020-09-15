//
//  NSMutableDictionary+HelperKit.m
//  HighwayDoctor
//
//  Created by Mars on 2019/5/30.
//  Copyright © 2019 Mars. All rights reserved.
//

#import "NSMutableDictionary+ATKit.h"

@implementation NSMutableDictionary (ATKit)

/**
 *  @brief  合并两个NSDictionary
 *
 *  @param dict1 NSDictionary
 *  @param dict2 NSDictionary
 *
 *  @return 合并后的NSDictionary
 */
+ (NSDictionary *)at_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2 {
    NSMutableDictionary * result = [NSMutableDictionary dictionaryWithDictionary:dict1];
    NSMutableDictionary * resultTemp = [NSMutableDictionary dictionaryWithDictionary:dict1];
    [resultTemp addEntriesFromDictionary:dict2];
    [resultTemp enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop) {
        if ([dict1 objectForKey:key]) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary * newVal = [[dict1 objectForKey: key] at_dictionaryByMergingWith: (NSDictionary *) obj];
                [result setObject: newVal forKey: key];
            } else {
                [result setObject: obj forKey: key];
            }
        }
        else if([dict2 objectForKey:key])
        {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary * newVal = [[dict2 objectForKey: key] at_dictionaryByMergingWith: (NSDictionary *) obj];
                [result setObject: newVal forKey: key];
            } else {
                [result setObject: obj forKey: key];
            }
        }
    }];
    return (NSDictionary *) [result mutableCopy];
    
}
/**
 *  @brief  并入一个NSDictionary
 *
 *  @param dict NSDictionary
 *
 *  @return 增加后的NSDictionary
 */
- (NSDictionary *)at_dictionaryByMergingWith:(NSDictionary *)dict {
    return [[self class] at_dictionaryByMerging:self with: dict];
}

/// 往 NSMutableDictionary 加入一个元素
/// @param i 元素 id类型
/// @param key 元素key值
-(void)at_setObj:(id)i forKey:(NSString*)key{
    if (i!=nil) {
        self[key] = i;
    }
}

/// 往 NSMutableDictionary 加入一个CGPoint元素
/// @param o 元素 CGPoint类型
/// @param key 元素key值
-(void)at_setPoint:(CGPoint)o forKey:(NSString *)key{
    self[key] = NSStringFromCGPoint(o);
}

/// 往 NSMutableDictionary 加入一个CGSize元素
/// @param o 元素 CGSize类型
/// @param key 元素key值
-(void)at_setSize:(CGSize)o forKey:(NSString *)key{
    self[key] = NSStringFromCGSize(o);
}

/// 往 NSMutableDictionary 加入一个CGRect元素
/// @param o 元素 CGRect类型
/// @param key 元素key值
-(void)at_setRect:(CGRect)o forKey:(NSString *)key{
    self[key] = NSStringFromCGRect(o);
}

@end







#pragma mark -
#pragma mark - NSDictionary

@implementation NSDictionary (ATSafeAccess)

/**
 * 根据键获取所对应的对象
 
 @param key 键
 @return object
 */
- (id)at_objectForKey:(id)key{
    if (key == nil) {
        return nil;
    }
    return [self objectForKey:key];
}

- (BOOL)at_hasKey:(NSString *)key{
    return [self objectForKey:key] != nil;
}

- (NSString*)at_stringForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    return nil;
}

- (NSNumber*)at_numberForKey:(id)key{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    return nil;
}

- (NSDecimalNumber *)at_decimalNumberForKey:(id)key {
    id value = [self objectForKey:key];
    
    if ([value isKindOfClass:[NSDecimalNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        NSNumber * number = (NSNumber*)value;
        return [NSDecimalNumber decimalNumberWithDecimal:[number decimalValue]];
    } else if ([value isKindOfClass:[NSString class]]) {
        NSString * str = (NSString*)value;
        return [str isEqualToString:@""] ? nil : [NSDecimalNumber decimalNumberWithString:str];
    }
    return nil;
}


- (NSArray*)at_arrayForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]]){
        return value;
    }
    return nil;
}

- (NSDictionary*)at_dictionaryForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null]){
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]]){
        return value;
    }
    return nil;
}

- (BOOL)at_boolForKey:(id)key{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null]){
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]]){
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]]){
        return [value boolValue];
    }
    return NO;
}

- (NSDate *)at_dateForKey:(id)key dateFormat:(NSString *)dateFormat{
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    formater.dateFormat = dateFormat;
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null]){
        return nil;
    }
    
    if ([value isKindOfClass:[NSString class]] && ![value isEqualToString:@""] && !dateFormat) {
        return [formater dateFromString:value];
    }
    return nil;
}

//CG
- (CGFloat)at_CGFloatForKey:(id)key{
    CGFloat f = [self[key] doubleValue];
    return f;
}

- (CGPoint)at_pointForKey:(id)key{
    CGPoint point = CGPointFromString(self[key]);
    return point;
}
- (CGSize)at_sizeForKey:(id)key{
    CGSize size = CGSizeFromString(self[key]);
    return size;
}
- (CGRect)at_rectForKey:(id)key{
    CGRect rect = CGRectFromString(self[key]);
    return rect;
}
@end

