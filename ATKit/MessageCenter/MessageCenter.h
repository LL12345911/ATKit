//
//  MessageCenter.h
//  EngineeringCool
//
//  Created by Mars on 2020/1/15.
//  Copyright © 2020 Mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MessageCenterDelegate <NSObject>

@optional

/**
 接收到message对象
 */
- (void)receiveMessage:(id)message messageId:(NSString *)msgId;

@end


@interface MessageCenter : NSObject

/**
 添加消息接收者
 @param msgReceiver 消息接收对象
 @param receiverKey 消息接收对象key
 */
+ (void)addMessageReceiver:(id<MessageCenterDelegate>)msgReceiver receiverKey:(NSString *)receiverKey;


/**
 发送消息
 @param msg 消息对象
 @param msgId 消息id
 @param receiverKey 消息接收对象key
 */
+ (void)sendMessage:(id)msg messageId:(NSString *)msgId receiverKey:(NSString *)receiverKey;


/**
 删除消息接收者
 @param receiverKey 消息接收者名
 */
+ (void)removeMessageReceiverWithKey:(NSString *)receiverKey;


@end

NS_ASSUME_NONNULL_END
