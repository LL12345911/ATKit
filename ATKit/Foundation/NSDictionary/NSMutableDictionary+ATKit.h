//
//  NSMutableDictionary+HelperKit.h
//  HighwayDoctor
//
//  Created by Mars on 2019/5/30.
//  Copyright © 2019 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableDictionary (ATKit)

/**
 *  @brief  合并两个NSDictionary
 *  @param dict1 NSDictionary
 *  @param dict2 NSDictionary
 *  @return 合并后的NSDictionary
 */
+ (NSDictionary *)at_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
/**
 *  @brief  并入一个NSDictionary
 *  @param dict NSDictionary
 *  @return 增加后的NSDictionary
 */
- (NSDictionary *)at_dictionaryByMergingWith:(NSDictionary *)dict;



/// 往 NSMutableDictionary 加入一个元素
/// @param i 元素 id类型
/// @param key 元素key值
-(void)at_setObj:(id)i forKey:(NSString*)key;

/// 往 NSMutableDictionary 加入一个CGPoint元素
/// @param o 元素 CGPoint类型
/// @param key 元素key值
-(void)at_setPoint:(CGPoint)o forKey:(NSString*)key;

/// 往 NSMutableDictionary 加入一个CGSize元素
/// @param o 元素 CGSize类型
/// @param key 元素key值
-(void)at_setSize:(CGSize)o forKey:(NSString*)key;

/// 往 NSMutableDictionary 加入一个CGRect元素
/// @param o 元素 CGRect类型
/// @param key 元素key值
-(void)at_setRect:(CGRect)o forKey:(NSString*)key;


@end



#pragma mark -
#pragma mark - NSDictionary
@interface NSDictionary (ATSafe)
/**
 * 根据键获取所对应的对象
 
 @param key 键
 @return object
 */
- (id)at_objectForKey:(id)key;

/**
 根据键获取所对应的对象
 
 @param key 键
 @return bool
 */
- (BOOL)at_hasKey:(NSString *)key;

/**
 * 根据键获取所对应的值 返回NSString类型
 
 @param key 键
 @return NSString
 */
- (NSString*)at_stringForKey:(id)key;

/**
 * 根据键获取所对应的值 返回NSNumber类型
 
 @param key 键
 @return NSNumber
 */
- (NSNumber*)at_numberForKey:(id)key;
/**
 * 根据键获取所对应的值 返回NSDecimalNumber类型
 
 @param key 键
 @return NSDecimalNumber
 */
- (NSDecimalNumber *)at_decimalNumberForKey:(id)key;
/**
 * 根据键获取所对应的值 返回NSArray类型
 
 @param key 键
 @return NSArray
 */
- (NSArray*)at_arrayForKey:(id)key;
/**
 * 根据键获取所对应的值 返回NSDictionary类型
 
 @param key 键
 @return NSDictionary
 */
- (NSDictionary*)at_dictionaryForKey:(id)key;

/**
 * 根据键获取所对应的值 返回BOOL类型
 
 @param key 键
 @return BOOL
 */
- (BOOL)at_boolForKey:(id)key;

/**
 * 根据键获取所对应的值 返回NSDate类型
 
 @param key 键
 @return NSDate
 */
- (NSDate *)at_dateForKey:(id)key dateFormat:(NSString *)dateFormat;

/**
 * 根据键获取所对应的值 返回CGFloat类型
 
 @param key 键
 @return CGFloat
 */
- (CGFloat)at_CGFloatForKey:(id)key;
/**
 * 根据键获取所对应的值 返回CGPoint类型
 
 @param key 键
 @return CGPoint
 */
- (CGPoint)at_pointForKey:(id)key;
/**
 * 根据键获取所对应的值 返回CGSize类型
 
 @param key 键
 @return CGSize
 */
- (CGSize)at_sizeForKey:(id)key;
/**
 * 根据键获取所对应的值 返回CGRect类型
 
 @param key 键
 @return CGRect
 */
- (CGRect)at_rectForKey:(id)key;


@end
