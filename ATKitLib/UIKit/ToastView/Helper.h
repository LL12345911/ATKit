//
//  Helper.h
//  ZenCushion
//
//  Created by Mars on 16/8/23.
//  Copyright © 2016年 Mars. All rights reserved.
//

//#import <Foundation/Foundation.h>


#import <Foundation/Foundation.h>

/**   记录App打开次数  */
static NSString * const kAppOpenTimes = @"kAppOpenTimes";

static NSString * const USER_CanOpenApp = @"user_CanOpenApp"; //1 是从其他APP唤醒 0自己打开
static NSString * const USER_AppName = @"user_AppName"; //从哪个APP打开


//是否开启采集服务
static NSString * const StartTrackServerNSNoti = @"startTrackServerNSNotificationCenter";
//通知开启鹰眼服务
static NSString * const StartBTKServerNSNoti = @"startBTKServerNSNotificationCenter";

//鹰眼采集服务是否已经开启 1采集已经开启 0采集开启失败
static NSString * const TrackServerFlag = @"TrackServerFlag";
//鹰眼服务是否已经开启 1已经开启 0采集开启失败
static NSString * const BTKServerFlag = @"BTKServerFlag";
//通知 鹰眼服务 和 采集 状态的变化
static NSString * const TrackServerStatus = @"TrackServerStatus";

//查询半径
static NSString * const User_Distance = @"User_Distance";



@interface Helper : NSObject

/**
 *  记录App打开次数
 */
+ (void)recordAppOpenTimes;
/**
 *  返回App打开次数
 */
+ (NSInteger)appOpenTimes;
/**
 *  是否是第一次打开App
 */
+ (BOOL)isFirstOpenApp;


//+ (void)setUserKeyValue:(id)value forKey:(NSString *)key;

+ (void)setUserObject:(id)object forkey:(NSString *)key;

+ (id)getObjectForKey:(NSString *)key;

+ (void)removeObjectForKey:(NSString *)key;

+ (void)removeAll;



@end
