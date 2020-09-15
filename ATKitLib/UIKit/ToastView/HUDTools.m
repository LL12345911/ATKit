//
//  HUDTools.m
//  AtsmartHome
//
//  Created by shengxiao on 15/8/20.
//  Copyright (c) 2015年 Atsmart. All rights reserved.
//

#import "HUDTools.h"

static MBProgressHUD    *hudView;
static HUDHandlerBlock  _handlerBlock;

@implementation HUDTools

+(MBProgressHUD *) showHUDWithLabel:(NSString *) labelText withView:(UIView *) view {
    hudView = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hudView];
    
    hudView.label.text = labelText;
    hudView.label.font = [UIFont systemFontOfSize:16.0f];
    [hudView showAnimated:YES];
    
    return hudView;
}

+(MBProgressHUD *) showHUDWithDetailLabel:(NSString *) detailLabelText withView:(UIView *) view {
    hudView = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hudView];
    
    hudView.detailsLabel.text = detailLabelText;
    hudView.detailsLabel.font = [UIFont systemFontOfSize:16.0f];
    [hudView showAnimated:YES];
    
    return hudView;
}

+(MBProgressHUD *) showHUDOnWindowWithLabel:(NSString *) labelText {
    hudView = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
    //HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[UIApplication sharedApplication].keyWindow addSubview:hudView];
    
    hudView.label.text = labelText;
    [hudView showAnimated:YES];
    
    return hudView;
}

+(MBProgressHUD *) showHUDWithLabel:(NSString *) labelText withView:(UIView *) view withColor:(UIColor *) color {
    hudView = [self showHUDWithLabel:labelText withView:view];
    hudView.bezelView.color = color;

    return hudView;
}

+(MBProgressHUD *) showHUDOnWindowWithLabel:(NSString *) labelText withColor:(UIColor *) color {
    hudView = [self showHUDOnWindowWithLabel:labelText];
    hudView.bezelView.color = color;//.bezelView.color
    
    return hudView;
}

+(MBProgressHUD *) showTransparentHUDWithLabel:(NSString *) labelText withView:(UIView *) view {
    hudView = [self showHUDWithLabel:labelText withView:view];
    hudView.bezelView.color = [UIColor clearColor];
    
    return hudView;

}

+(MBProgressHUD *) showTransparentHUDOnWindowWithLabel:(NSString *) labelText withLabelTextColor:(UIColor *) textColor {
    hudView = [self showHUDOnWindowWithLabel:labelText];
    hudView.bezelView.color = [UIColor clearColor];
    hudView.label.textColor = textColor;
    
    return hudView;
}

+(MBProgressHUD *) showTransparentHUDOnWindowWithLabel:(NSString *) labelText {
    hudView = [self showHUDOnWindowWithLabel:labelText];
    hudView.bezelView.color = [UIColor clearColor];
    
    return hudView;
}

+(MBProgressHUD *) changeLabelText:(NSString *) labelText {
    if (hudView == nil) {
        return nil;
    }
    hudView.label.text = labelText;
    
    return hudView;
}

+(MBProgressHUD *) changeDetailLabelText:(NSString *) labelText {
    if (hudView == nil) {
        return nil;
    }
    hudView.detailsLabel.text = labelText;
    
    return hudView;
}

+ (void) removeHUD {
    [hudView removeFromSuperview];
    [hudView hideAnimated:YES afterDelay:0];
    [hudView removeFromSuperViewOnHide];
    hudView = nil;
}

+ (void) removeHUDAfterDelay:(float) time {
     [hudView hideAnimated:YES afterDelay:time];
    [hudView removeFromSuperViewOnHide];
}

+ (void) removeHUDAfterDelay:(float) time withAfterDelayHandler:(HUDHandlerBlock) handler {
    [self removeHUDAfterDelay:time];
    _handlerBlock = handler;
    [self performSelector:@selector(handleAction)
               withObject:nil
               afterDelay:time];
}

+ (void)showText:(NSString *) text withView:(UIView *) view withDelay:(float) time {
     [self hidden];
    dispatch_async(dispatch_get_main_queue(), ^{
        hudView = [self createMBProgressHUD];
        hudView.label.text = text;
        [hudView hideAnimated:YES afterDelay:time];
    });
}

/**
 @description 显示详情信息(多行)
 
 @param text 文本信息
 */
+ (void)showTextAlignmentLeft:(NSString *)text{
     [self hidden];
    dispatch_async(dispatch_get_main_queue(), ^{
        hudView = [self createMBProgressHUD];
        hudView.label.text = text;
        hudView.label.textAlignment = NSTextAlignmentLeft;
        [hudView hideAnimated:YES afterDelay:2.f];
    });
}




/**
 @description 显示详情信息(多行)
 
 @param text 文本信息
 @param time 消失时间
 */
+ (void)showTextAlignmentLeft:(NSString *)text withDelay:(float) time{
     [self hidden];
    dispatch_async(dispatch_get_main_queue(), ^{
        hudView = [self createMBProgressHUD];
        hudView.label.text = text;
        hudView.label.textAlignment = NSTextAlignmentLeft;
        [hudView hideAnimated:YES afterDelay:time];
    });
}

/**
 @description 显示详情信息(多行)
 
 @param text 文本信息
 */
+ (void)showTextNonAutomaticHidden:(NSString *)text{
    dispatch_async(dispatch_get_main_queue(), ^{
        hudView = [self createMBProgressHUD];
        hudView.label.text = text;
        [hudView hideAnimated:YES afterDelay:MAXFLOAT];
    });
}


/**
 隐藏
 */
+ (void)hidden{
    [hudView removeFromSuperview];
    [hudView hideAnimated:YES afterDelay:0];
    [hudView removeFromSuperViewOnHide];
    hudView = nil;
}



/**
 @description 显示详情信息(多行)
 
 @param text 文本信息
 */
+ (void)showText:(NSString *)text{
     [self hidden];
    dispatch_async(dispatch_get_main_queue(), ^{
        hudView = [self createMBProgressHUD];
        hudView.label.text = text;
        [hudView hideAnimated:YES afterDelay:2.f];
    });
}
/**
 @description 显示详情信息(多行)
 
 @param text 文本信息
 @param time 消失时间
 */
+ (void)showText:(NSString *)text withDelay:(float) time{
     [self hidden];
    dispatch_async(dispatch_get_main_queue(), ^{
        hudView = [self createMBProgressHUD];
        hudView.label.text = text;
        [hudView hideAnimated:YES afterDelay:time];
    });
}

/**
 @description 显示详情信息(多行)
 
 @param text 文本信息
 @param time 消失时间
 */
+ (void)showDetailText:(NSString *)text withDelay:(float) time{
    hudView = [self createMBProgressHUD];
    hudView.detailsLabel.text = text;
    [hudView hideAnimated:YES afterDelay:time];
}


+ (MBProgressHUD *)createMBProgressHUD{
    [self hidden];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    hudView = [MBProgressHUD showHUDAddedTo:window animated:YES];
    // Configure for text only and offset down
    hudView.mode = MBProgressHUDModeText;
    hudView.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    hudView.label.textColor = [UIColor whiteColor];
    hudView.bezelView.blurEffectStyle = UIBlurEffectStyleDark;
    hudView.label.numberOfLines = 0;
    //    hudView.margin = 10.f;
    hudView.removeFromSuperViewOnHide = YES;
    hudView.label.font = [UIFont systemFontOfSize:16.0f];
    return hudView;
}


/**
 @description 显示详情信息(多行)

 @param text 文本信息
 @param view 在哪个视图上显示
 @param time 消失时间
 */
+ (void)showDetailText:(NSString *) text withView:(UIView *) view withDelay:(float) time {
    [self hidden];
    hudView = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // Configure for text only and offset down
    hudView.mode = MBProgressHUDModeText;
    hudView.detailsLabel.text = text;
    hudView.margin = 10.f;
    hudView.removeFromSuperViewOnHide = YES;
    hudView.detailsLabel.font = [UIFont systemFontOfSize:16.0f];
    
    hudView.bezelView.color = [UIColor blackColor];
    hudView.detailsLabel.textColor = [UIColor whiteColor];
    
    [hudView hideAnimated:YES afterDelay:time];
}

+(void) handleAction {
    if (_handlerBlock != nil) {
        _handlerBlock();
        _handlerBlock = nil;
    }
}
@end
