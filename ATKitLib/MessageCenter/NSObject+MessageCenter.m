//
//  NSObject+MessageCenter.m
//  EngineeringCool
//
//  Created by Mars on 2020/1/15.
//  Copyright © 2020 Mars. All rights reserved.
//

#import "NSObject+MessageCenter.h"
#import "MessageCenter.h"
#import <objc/runtime.h>

@interface NSObject ()<MessageCenterDelegate>

@property (nonatomic, weak) id<MessageCenterDelegate> messageDelegate;

@end

@implementation NSObject (MessageCenter)

- (void)setMessageDelegate:(id<MessageCenterDelegate>)messageDelegate{
    objc_setAssociatedObject(self, @selector(messageDelegate), messageDelegate, OBJC_ASSOCIATION_ASSIGN);

}

- (id<MessageCenterDelegate>)messageDelegate{
    return objc_getAssociatedObject(self, @selector(messageDelegate));
}



#pragma mark - 成为 & 取消成为 消息接受者
/**
 成为消息接受者
 */
- (void)registerMessageReceiverWithKey:(NSString *)receiverKey{
    
    //将自己设置成为代理
    self.messageDelegate = self;
    if (!CHECK_VALID_STRING(receiverKey)) {
        receiverKey = [self getClassName];
    }
    
    [MessageCenter addMessageReceiver:self.messageDelegate receiverKey:receiverKey];
}

/**
 发送者发送消息，并指定接收者
 */
- (void)sendMessage:(id)msg messageId:(NSString *)msgId receiverKey:(NSString *)receiverKey{
    
    if (!CHECK_VALID_STRING(receiverKey)) {
        receiverKey = [self getClassName];
    }
    
    [MessageCenter sendMessage:msg messageId:msgId receiverKey:receiverKey];
}

/**
 删除消息接收者
 */
- (void)removeMessageReceiverWithKey:(NSString *)receiverKey{
    
    if (!CHECK_VALID_STRING(receiverKey)) {
        receiverKey = NSStringFromClass([self class]);
    }
    
    [MessageCenter removeMessageReceiverWithKey:receiverKey];
}


#pragma mark - private methods
- (NSString *)getClassName{
    return NSStringFromClass([self class]);
}




@end
