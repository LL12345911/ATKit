//
//  UIScrollView+Chain.m
//  ChainCategory
//
//  Created by linitial on 2020/3/20.
//  Copyright © 2020 linitial. All rights reserved.
//

#import "UIScrollView+Chain.h"

@implementation UIScrollView (Chain)

- (UIScrollView * (^)(BOOL))at_directionalLockEnabled {
    return ^(BOOL directionalLockEnabled){
        self.directionalLockEnabled = directionalLockEnabled;
        return self;
    };
}

- (UIScrollView * (^)(BOOL))at_pagingEnabled {
    return ^(BOOL pagingEnabled){
        self.pagingEnabled = pagingEnabled;
        return self;
    };
}

- (UIScrollView * (^)(BOOL))at_scrollEnabled {
    return ^(BOOL scrollEnabled){
        self.scrollEnabled = scrollEnabled;
        return self;
    };
}

- (UIScrollView * (^)(BOOL))at_alwaysBounceVertical {
    return ^(BOOL alwaysBounceVertical){
        self.alwaysBounceVertical = alwaysBounceVertical;
        return self;
    };
}

- (UIScrollView * (^)(BOOL))at_alwaysBounceHorizontal {
    return ^(BOOL alwaysBounceHorizontal){
        self.alwaysBounceHorizontal = alwaysBounceHorizontal;
        return self;
    };
}

- (UIScrollView * (^)(BOOL))at_bounces {
    return ^(BOOL bounces){
        self.bounces = bounces;
        return self;
    };
}

- (UIScrollView * (^)(BOOL))at_opaque {
    return ^(BOOL opaque){
        self.opaque = opaque;
        return self;
    };
}

- (UIScrollView * (^)(BOOL))at_showsVerticalScrollIndicator {
    return ^(BOOL showsVerticalScrollIndicator){
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator;
        return self;
    };
}

- (UIScrollView * (^)(BOOL))at_showsHorizontalScrollIndicator {
    return ^(BOOL showsHorizontalScrollIndicator) {
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
        return self;
    };
}

- (UIScrollView * (^)(BOOL))at_bouncesZoom {
    return ^(BOOL bouncesZoom) {
        self.bouncesZoom = bouncesZoom;
        return self;
    };
}

- (UIScrollView * (^)(CGPoint))at_contentOffset {
    return ^(CGPoint contentOffset) {
        self.contentOffset = contentOffset;
        return self;
    };
}

- (UIScrollView * (^)(CGSize))at_contentSize {
    return ^(CGSize contentSize) {
        self.contentSize = contentSize;
        return self;
    };
}

- (UIScrollView * (^)(CGFloat))at_minimumZoomScale {
    return ^(CGFloat minimumZoomScale) {
        self.minimumZoomScale = minimumZoomScale;
        return self;
    };
}

- (UIScrollView * (^)(CGFloat))at_maximumZoomScale {
    return ^(CGFloat maximumZoomScale) {
        self.maximumZoomScale = maximumZoomScale;
        return self;
    };
}

- (UIScrollView * (^)(CGFloat))at_zoomScale {
    return ^(CGFloat zoomScale) {
        self.zoomScale = zoomScale;
        return self;
    };
}

- (UIScrollView * (^)(id<UIScrollViewDelegate>))hf_delegate {
    return ^(id<UIScrollViewDelegate>delegate){
        self.delegate = delegate;
        return self;
    };
}
@end
