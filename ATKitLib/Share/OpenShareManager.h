//
//  OpenShareManager.h
//  EngineeringCool
//
//  Created by Mars on 2019/8/27.
//  Copyright © 2019 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenShareManager : NSObject

///  邀请加入
/// @param linkUrl link
/// @param desc 详细说明
+ (void)invitedToJoinUs:(NSString *)linkUrl desc:(NSString *)desc image:(NSString *)imageName;

//+ (void)shareMessage_LinkUrl:(NSString *)linkUrl title:(NSString *)title;


+ (void)shareMessage_LinkUrl:(NSString *)linkUrl title:(NSString *)title image:(UIImage *)image;


//邀请加入
+ (void)sharePDF:(NSString *)linkUrl;


@end

NS_ASSUME_NONNULL_END
