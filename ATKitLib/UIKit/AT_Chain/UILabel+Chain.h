

#import <UIKit/UIKit.h>

@interface UILabel (Chain)

- (UILabel *(^)(UIColor *))at_backgroundColor;

- (UILabel *(^)(CGRect))at_frame;

- (UILabel *(^)(UIView *))at_addToSuperView;

- (UILabel *(^)(BOOL))at_clipsToBounds;

- (UILabel *(^)(BOOL))at_hidden;

- (UILabel *(^)(CGFloat))at_alpha;

- (UILabel *(^)(NSString *))at_text;

- (UILabel *(^)(UIFont *))at_font;

- (UILabel *(^)(UIColor *))at_textColor;

- (UILabel *(^)(NSTextAlignment))at_textAlignment;

- (UILabel *(^)(NSLineBreakMode))at_lineBreakMode;

- (UILabel *(^)(NSAttributedString *))at_attributedText;

- (UILabel *(^)(NSInteger))at_numberOfLines;

- (UILabel *(^)(BOOL))at_userInteractionEnabled;

//#pragma clang diagnostic push
//#pragma clang diagnostic ignored"-Wignored-attributes"
//
//- (UILabel * (NS_NOESCAPE ^)(NSString *))at_text;
//- (UILabel * (NS_NOESCAPE ^)(UIColor *))at_textColor;
//- (UILabel * (NS_NOESCAPE ^)(UIFont *))at_font;
//- (UILabel * (NS_NOESCAPE ^)(NSTextAlignment))at_alignment;
//- (UILabel * (NS_NOESCAPE ^)(NSInteger))at_numberOfLines;
//- (UILabel * (NS_NOESCAPE ^)(NSAttributedString *))at_attributedText;
///// 行间距、会将lab.text 转化为 lab.attributedText
//- (UILabel * (NS_NOESCAPE ^)(CGFloat))at_lineSpacing;
//- (UILabel * (NS_NOESCAPE ^)(NSLineBreakMode))at_lineBreakMode;
//- (UILabel * (NS_NOESCAPE ^)(UIBaselineAdjustment))at_baselineAdjustment;
//
//- (UILabel * (NS_NOESCAPE ^)(BOOL))at_allowsDefaultTighteningForTruncation;
//
//- (UILabel * (NS_NOESCAPE ^)(CGFloat))at_preferredMaxLayoutWidth;
//
//- (UILabel * (NS_NOESCAPE ^)(BOOL))at_adjustsFontSizeToFitWidth;
//
//- (UILabel * (NS_NOESCAPE ^)(UIColor *))at_highlightedTextColor;
//
//- (UILabel * (NS_NOESCAPE ^)(CGFloat))at_minimumScaleFactor;
//
//#pragma clang diagnostic pop


@end
