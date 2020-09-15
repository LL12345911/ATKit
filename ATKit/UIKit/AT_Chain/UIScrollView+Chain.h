//
//  UIScrollView+Chain.h
//  ChainCategory
//
//  Created by linitial on 2020/3/20.
//  Copyright © 2020 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Chain)

- (UIScrollView * (^)(BOOL))at_directionalLockEnabled;

- (UIScrollView * (^)(BOOL))at_pagingEnabled;

- (UIScrollView * (^)(BOOL))at_scrollEnabled;

- (UIScrollView * (^)(BOOL))at_alwaysBounceVertical;

- (UIScrollView * (^)(BOOL))at_alwaysBounceHorizontal;

- (UIScrollView * (^)(BOOL))at_bounces;

- (UIScrollView * (^)(BOOL))at_opaque;

- (UIScrollView * (^)(BOOL))at_showsVerticalScrollIndicator;

- (UIScrollView * (^)(BOOL))at_showsHorizontalScrollIndicator;

- (UIScrollView * (^)(BOOL))at_bouncesZoom;

- (UIScrollView * (^)(CGPoint))at_contentOffset;

- (UIScrollView * (^)(CGSize))at_contentSize;

- (UIScrollView * (^)(CGFloat))at_minimumZoomScale;

- (UIScrollView * (^)(CGFloat))at_maximumZoomScale;

- (UIScrollView * (^)(CGFloat))at_zoomScale;

- (UIScrollView * (^)(id <UIScrollViewDelegate> delegate))hf_delegate;

@end

NS_ASSUME_NONNULL_END
