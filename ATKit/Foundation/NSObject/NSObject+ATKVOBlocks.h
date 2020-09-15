//
//  NSObject+ATKVOBlocks.h
//  HighwayDoctor
//
//  Created by Mars on 2019/5/15.
//  Copyright © 2019 Mars. All rights reserved.
//

/*
 UIViewController *observer = self;
 if (self.observersOn) {
 // This is where the magic happens
 [self.user at_addObserver:observer forKeyPath:@"email" options:0 context:nil withBlock:^(NSDictionary *change, void *context) {
 NSLog(@"Changed email");
 }];
 
 [self.user at_addObserver:observer forKeyPath:@"username" options:0 context:nil withBlock:^(NSDictionary *change, void *context) {
 NSLog(@"Changed username");
 }];
 } else {
 [self.user at_removeBlockObserver:observer forKeyPath:@"username"];
 [self.user at_removeBlockObserver:observer forKeyPath:@"email"];
 }
 */


#import <Foundation/Foundation.h>
typedef void (^ATKVOBlock)(NSDictionary *change, void *context);

@interface NSObject (ATKVOBlocks)
/**
 添加观察者与监听属性
 
 @param observer 观察者,一般为其他对象(谁想监听)
 @param keyPath 监听的属性
 @param options 监听模式
 @param context context
 @param block  监听回调
 */
- (void)at_addObserver:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
               context:(void *)context
             withBlock:(ATKVOBlock)block;
/**
 移除观察者对属性的监听
 
 @param observer 观察者,一般为其他对象(谁想监听)
 @param keyPath 监听的属性
 */
-(void)at_removeBlockObserver:(NSObject *)observer
                   forKeyPath:(NSString *)keyPath;

/**
 对象本身作为观察者
 
 @param keyPath 监听的属性
 @param options 监听模式
 @param context context
 @param block 监听回调
 */
-(void)at_addObserverForKeyPath:(NSString *)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void *)context
                      withBlock:(ATKVOBlock)block;

/**
 移除观察者对属性的监听
 
 @param keyPath 监听的属性
 */
-(void)at_removeBlockObserverForKeyPath:(NSString *)keyPath;

@end
