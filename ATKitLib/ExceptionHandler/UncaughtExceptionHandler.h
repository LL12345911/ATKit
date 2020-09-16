//
//  UncaughtExceptionHandler.h
//  EngineeringCool
//
//  Created by Mars on 2019/12/24.
//  Copyright © 2019 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UncaughtExceptionHandler : NSObject

/*!
 *  异常的处理方法
 *
 *  @param install   是否开启捕获异常
 *  @param showAlert 是否在发生异常时弹出alertView
 */
+ (void)installUncaughtExceptionHandler:(BOOL)install showAlert:(BOOL)showAlert;

@end
