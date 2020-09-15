//
//  UITextField+Chain.h
//  ChainCategory
//
//  Created by linitial on 2020/3/20.
//  Copyright © 2020 linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Chain)

- (UITextField *(^)(UIColor *))at_backgroundColor;

- (UITextField *(^)(CGRect))at_frame;

- (UITextField *(^)(UIView *))at_addToSuperView;

- (UITextField *(^)(CGFloat))at_alpha;

- (UITextField *(^)(BOOL))at_clipsToBounds;

- (UITextField *(^)(BOOL))at_hidden;

- (UITextField *(^)(BOOL))at_userInteractionEnabled;

- (UITextField *(^)(UIFont *))at_font;

- (UITextField *(^)(UIColor *))at_textColor;

- (UITextField *(^)(NSTextAlignment))at_textAlignment;

- (UITextField *(^)(NSString *))at_text;

- (UITextField *(^)(NSAttributedString *))at_attributedText;

- (UITextField *(^)(NSString *))at_placeholder;

- (UITextField *(^)(NSAttributedString *))at_attributedPlaceholder;
@end

NS_ASSUME_NONNULL_END
