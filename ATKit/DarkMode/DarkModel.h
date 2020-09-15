//
//  DarkModel.h
//  EngineeringCool
//
//  Created by Mars on 2020/3/13.
//  Copyright © 2020 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/** 暗黑模式
 *
 *#warning ⚠️⚠️⚠️⚠️⚠️⚠️⚠️ 这里我们需要特别注意 当模式发生变化的时候 只有在以下情况下才能监听模式发生了变化
 *
 *第一：在UIView中 以下四个方法
 *draw();  layoutSubview();  traitCollectionDidChange();   tintColorDidChange()
 *
 *第二：在UIViewController中 以下三个方法中
 *viewWillLayoutSubviews();   viewDidLayoutSubviews() ;     traitCollectionDidChange()
 *
 *第三：UIPresentationController  以下三个方法
 *containerViewWillLayoutSubviews()；    containerViewDidLayoutSubviews()； traitCollectionDidChange()
 */

@interface DarkModel : NSObject

/**
 是否 暗景模式
 */
+ (BOOL)isDarkMode;

/**
 暗景模式 传入RGBColor 或者 UIColor
 */
+ (UIColor *)adaptColor:(UIColor *)color darkColor:(UIColor *)darkColor;

/**
 暗景模式 16进制  默认 alpha=1
 */
+ (UIColor *)adaptHexColor:(NSString *)hexColor darkColor:(NSString *)hexDarkColor;


/// 暗景模式
/// @param lightColor 0xffffff
/// @param darkColor 0xffffff
+ (UIColor *)initWithLightColor:(NSInteger)lightColor darkColor:(NSInteger)darkColor;


/**
 暗景模式 16进制  自定义alpha
 */
+ (UIColor *)adaptHexColor:(NSString *)hexColor darkColor:(NSString *)hexDarkColor alpha:(CGFloat)alpha;

/// 适配暗黑模式颜色   颜色传入的是16进制字符串 还有颜色的透明度
/// @param lightColor 普通模式颜色
/// @param lightAlpha 普通模式颜色透明度
/// @param darkColor 暗黑模式颜色透明度
/// @param darkAlpha 暗黑模式颜色
+ (UIColor *)colorWithLightColorStr:(NSString *)lightColor WithLightColorAlpha:(CGFloat)lightAlpha DarkColor:(NSString *)darkColor WithDarkColorAlpha:(CGFloat)darkAlpha;




@end

NS_ASSUME_NONNULL_END
