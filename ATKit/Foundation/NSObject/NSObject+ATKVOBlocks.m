//
//  NSObject+ATKVOBlocks.m
//  HighwayDoctor
//
//  Created by Mars on 2019/5/15.
//  Copyright © 2019 Mars. All rights reserved.
//

#import "NSObject+ATKVOBlocks.h"
#import <objc/runtime.h>

@implementation NSObject (ATKVOBlocks)

-(void)at_addObserver:(NSObject *)observer
           forKeyPath:(NSString *)keyPath
              options:(NSKeyValueObservingOptions)options
              context:(void *)context
            withBlock:(ATKVOBlock)block {
    
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), block, OBJC_ASSOCIATION_COPY);
    [self addObserver:observer forKeyPath:keyPath options:options context:context];
}

-(void)at_removeBlockObserver:(NSObject *)observer
                   forKeyPath:(NSString *)keyPath {
    objc_setAssociatedObject(observer, (__bridge const void *)(keyPath), nil, OBJC_ASSOCIATION_COPY);
    [self removeObserver:observer forKeyPath:keyPath];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context {
    
    ATKVOBlock block = objc_getAssociatedObject(self, (__bridge const void *)(keyPath));
    if (block) {
        block(change, context);
    }
}

-(void)at_addObserverForKeyPath:(NSString *)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void *)context
                      withBlock:(ATKVOBlock)block {
    
    [self at_addObserver:self forKeyPath:keyPath options:options context:context withBlock:block];
}

-(void)at_removeBlockObserverForKeyPath:(NSString *)keyPath {
    [self at_removeBlockObserver:self forKeyPath:keyPath];
}

@end
