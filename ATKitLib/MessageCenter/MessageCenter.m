//
//  MessageCenter.m
//  EngineeringCool
//
//  Created by Mars on 2020/1/15.
//  Copyright © 2020 Mars. All rights reserved.
//

#import "MessageCenter.h"
#import "NSObject+MessageCenter.h"

#define DEFAULT_MESSAGE_ID  @"DEFAULT_MESSAGE_ID"

static NSMapTable  *weakMessageCenterMapTable = nil;



@implementation MessageCenter

+ (void)initialize{
    
    if (self == [MessageCenter class]){
        
        // 强引用key & 值弱引用object
        weakMessageCenterMapTable = [NSMapTable strongToWeakObjectsMapTable];
    }
}

#pragma mark - 添加 && 删除
/**
 添加消息接收者
 */
+ (void)addMessageReceiver:(id<MessageCenterDelegate>)msgReceiver receiverKey:(NSString *)receiverKey{
    
    if ([weakMessageCenterMapTable objectForKey:receiverKey] == nil){
        // 添加对象进weak集合
        [weakMessageCenterMapTable setObject:msgReceiver forKey:receiverKey];
    }
}

/**
 发送消息
 */
+ (void)sendMessage:(id)msg messageId:(NSString *)msgId receiverKey:(NSString *)receiverKey{
    
    if (!CHECK_VALID_STRING(receiverKey)) {
        return;
    }
    
    id<MessageCenterDelegate> object = [weakMessageCenterMapTable objectForKey:receiverKey];
    if (!object){
        //对象未添加或对象已被释放,则移除掉这个键值
        [weakMessageCenterMapTable removeObjectForKey:receiverKey];
    }else{
        
        if ([object respondsToSelector:@selector(receiveMessage:messageId:)]) {
            if (!CHECK_VALID_STRING(msgId)) {
                msgId = DEFAULT_MESSAGE_ID;
            }
            [object receiveMessage:msg messageId:msgId];
        }
    }
}

/**
 删除消息接收者
 */
+ (void)removeMessageReceiverWithKey:(NSString *)receiverKey{
    
    if (!CHECK_VALID_STRING(receiverKey)){
        return;
    }
    
    // 移除掉键值
    [weakMessageCenterMapTable removeObjectForKey:receiverKey];
}

#pragma mark - private methods
+ (void)printMessageCenterMapTable{
    
    NSArray *keys = [[weakMessageCenterMapTable keyEnumerator] allObjects];
    [keys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        
        id  obj = [weakMessageCenterMapTable objectForKey:key];
        NSLog(@"(key)%@-->(value)%@",key,obj);
    }];
}


@end
