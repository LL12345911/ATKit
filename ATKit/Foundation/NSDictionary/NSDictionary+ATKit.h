//
//  NSDictionary+ATKit.h
//  HighwayDoctor
//
//  Created by Mars on 2019/6/12.
//  Copyright © 2019 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ATKit)
#pragma mark -
#pragma mark - ATBlock
- (void)at_each:(void (^)(id k, id v))block;
- (void)at_eachKey:(void (^)(id k))block;
- (void)at_eachValue:(void (^)(id v))block;
- (NSArray *)at_map:(id (^)(id key, id value))block;
- (NSDictionary *)at_pick:(NSArray *)keys;
- (NSDictionary *)at_omit:(NSArray *)key;

#pragma mark -
#pragma mark -XML
/**
 *  @brief  将NSDictionary转换成XML字符串 不带XML声明 不带根节点
 *
 *  @return XML 字符串
 */
- (NSString *)at_XMLString;
/**
 *  @brief  将NSDictionary转换成XML字符串, 默认 <?xml version=\"1.0\" encoding=\"utf-8\"?> 声明   自定义根节点
 *
 *  @param rootElement 根节点
 *
 *  @return XML 字符串
 */
- (NSString *)at_XMLStringDefaultDeclarationWithRootElement:(NSString*)rootElement;
/**
 *  @brief  将NSDictionary转换成XML字符串, 自定义根节点  自定义xml声明
 *
 *  @param rootElement 根节点
 *
 *  @param declaration xml声明
 *
 *  @return 标准合法 XML 字符串
 */
- (NSString *)at_XMLStringWithRootElement:(NSString* __nullable)rootElement declaration:(NSString* __nullable)declaration;

@end

NS_ASSUME_NONNULL_END
