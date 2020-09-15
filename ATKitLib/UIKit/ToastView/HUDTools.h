//
//  HUDTools.h
//  AtsmartHome
//
//  Created by shengxiao on 15/8/20.
//  Copyright (c) 2015年 Atsmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

typedef void (^HUDHandlerBlock) (void);

@interface HUDTools : NSObject

+(MBProgressHUD *) showHUDWithLabel:(NSString *) labelText withView:(UIView *) view;

+(MBProgressHUD *) showHUDWithDetailLabel:(NSString *) detailLabelText withView:(UIView *) view;

+(MBProgressHUD *) showHUDOnWindowWithLabel:(NSString *) labelText;

+(MBProgressHUD *) showHUDWithLabel:(NSString *) labelText withView:(UIView *) view withColor:(UIColor *) color;

+(MBProgressHUD *) showHUDOnWindowWithLabel:(NSString *) labelText withColor:(UIColor *) color;

+(MBProgressHUD *) showTransparentHUDWithLabel:(NSString *) labelText withView:(UIView *) view;

+(MBProgressHUD *) showTransparentHUDOnWindowWithLabel:(NSString *) labelText withLabelTextColor:(UIColor *) textColor;

+(MBProgressHUD *) showTransparentHUDOnWindowWithLabel:(NSString *) labelText;

+(MBProgressHUD *) changeLabelText:(NSString *) labelText;

+(MBProgressHUD *) changeDetailLabelText:(NSString *) labelText;


+ (void) removeHUD;

+ (void) removeHUDAfterDelay:(float) time;

+ (void) removeHUDAfterDelay:(float) time withAfterDelayHandler:(HUDHandlerBlock) handler;

/**
 @description 显示详情信息(多行)
 不自动消失
 
 @param text 文本信息
 */
+ (void)showTextNonAutomaticHidden:(NSString *)text;

/**
    隐藏
 */
+ (void)hidden;

/**
 @description 显示详情信息(多行)
 
 @param text 文本信息
 */
+ (void)showText:(NSString *)text;

/**
 @description 显示详情信息(多行)
 
 @param text 文本信息
 */
+ (void)showTextAlignmentLeft:(NSString *)text;

/**
 @description 显示详情信息(多行)
 
 @param text 文本信息
 @param time 消失时间
 */
+ (void)showTextAlignmentLeft:(NSString *)text withDelay:(float) time;

+ (void)showText:(NSString *) text withView:(UIView *) view withDelay:(float) time;

+ (void)showDetailText:(NSString *) text withView:(UIView *) view withDelay:(float) time;


+ (void)showText:(NSString *)text withDelay:(float) time;

+ (void)showDetailText:(NSString *)text withDelay:(float) time;


@end
