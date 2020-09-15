//
//  NSObject+MessageCenter.h
//  EngineeringCool
//
//  Created by Mars on 2020/1/15.
//  Copyright © 2020 Mars. All rights reserved.
//

//#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define CHECK_VALID_STRING(x)  (x && [x isKindOfClass:[NSString class]] && [x length])

/// 消息接收  消息发送
@interface NSObject (MessageCenter)

/**
 注册成为消息接受者
 
 @param receiverKey 接受者key,值为nil时，key值选用注册者对象的类名
 */
- (void)registerMessageReceiverWithKey:(NSString *)receiverKey;

/**
 发送者发送消息，并指定接收者
 @param msg 消息对象，可以是任意对象
 @param msgId 消息id
 @param receiverKey 接受者key，值为nil时,receiverKey选用发送者对象的类名
 */
- (void)sendMessage:(id)msg messageId:(NSString *)msgId receiverKey:(NSString *)receiverKey;


/**
 删除消息接收者
 */
- (void)removeMessageReceiverWithKey:(NSString *)receiverKey;

@end

NS_ASSUME_NONNULL_END


