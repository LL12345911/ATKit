

#import "UILabel+Chain.h"

@implementation UILabel (Chain)

- (UILabel *(^)(UIColor *))at_backgroundColor {
    return ^(UIColor *backgroundColor) {
        self.backgroundColor = backgroundColor;
        return self;
    };
}

- (UILabel *(^)(CGRect))at_frame {
    return  ^(CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UILabel *(^)(UIView *))at_addToSuperView {
    return ^(UIView *view) {
        [view addSubview:self];
        return self;
    };
}

- (UILabel *(^)(BOOL))at_clipsToBounds {
    return ^(BOOL clipsToBounds) {
        self.clipsToBounds = clipsToBounds;
        return self;
    };
}

- (UILabel *(^)(BOOL))at_hidden {
    return ^(BOOL hidden) {
        self.hidden = hidden;
        return self;
    };
}

- (UILabel *(^)(CGFloat))at_alpha {
    return ^(CGFloat alpha) {
        self.alpha = alpha;
        return self;
    };
}

- (UILabel *(^)(NSString *))at_text {
    return ^(NSString *text) {
        self.text = text;
        return self;
    };
}

- (UILabel *(^)(UIFont *))at_font {
    return ^(UIFont *font) {
        self.font = font;
        return self;
    };
}

- (UILabel *(^)(UIColor *))at_textColor {
    return ^(UIColor *textColor) {
        self.textColor = textColor;
        return self;
    };
}

- (UILabel *(^)(NSTextAlignment))at_textAlignment {
    return ^(NSTextAlignment textAlignment) {
        self.textAlignment = textAlignment;
        return self;
    };
}

- (UILabel *(^)(NSLineBreakMode))at_lineBreakMode {
    return ^(NSLineBreakMode lineBreakMode) {
        self.lineBreakMode = lineBreakMode;
        return self;
    };
}

- (UILabel *(^)(NSAttributedString *))at_attributedText {
    return ^(NSAttributedString *attributedText) {
        self.attributedText = attributedText;
        return self;
    };
}

- (UILabel *(^)(NSInteger))at_numberOfLines {
    return ^(NSInteger numberOfLines) {
        self.numberOfLines = numberOfLines;
        return self;
    };
}

- (UILabel *(^)(BOOL))at_userInteractionEnabled {
    return ^(BOOL userInteractionEnabled) {
        self.userInteractionEnabled = userInteractionEnabled;
        return self;
    };
}


//- (UILabel * (^)(NSString *))at_text{
//    return ^(NSString * a){
//        self.text = a;
//        return self;
//    };
//}
//
//- (UILabel * (^)(UIColor *))at_textColor{
//    return ^(UIColor * a){
//        self.textColor = a;
//        return self;
//    };
//}
//- (UILabel * (^)(UIFont *))at_font{
//    return ^(UIFont * a){
//        self.font = a;
//        return self;
//    };
//}
//- (UILabel * (^)(NSTextAlignment))at_alignment{
//    return ^(NSTextAlignment a){
//        self.textAlignment = a;
//        return self;
//    };
//}
//- (UILabel * (^)(NSInteger))at_numberOfLines{
//    return ^(NSInteger a){
//        self.numberOfLines = a;
//        return self;
//    };
//}
//
//- (UILabel * (^)(NSAttributedString *))at_attributedText{
//    return ^(NSAttributedString * a){
//        self.attributedText = a;
//        return self;
//    };
//}
//- (UILabel * (^)(CGFloat))at_lineSpacing{
//    return ^(CGFloat a){
//        //富文本属性
//        NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
//        //基本属性设置
//        //字体颜色
//        textDict[NSForegroundColorAttributeName] = self.textColor;
//        //字号大小
//        textDict[NSFontAttributeName] = self.font;
//        //段落样式
//        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
//        //行间距
//        paraStyle.lineSpacing = a;
//        //文本段落样式
//        textDict[NSParagraphStyleAttributeName] = paraStyle;
//        if(self.text.length > 0 ) {
//            self.attributedText = [[NSAttributedString alloc] initWithString:self.text attributes:textDict];
//        }else if(self.attributedText.length > 0){
//            NSMutableAttributedString * atext = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
//            [atext setAttributes:textDict range:NSMakeRange(0, self.attributedText.length)];
//            self.attributedText = atext;
//        }
//        return self;
//    };
//}
//
//- (UILabel * (^)(NSLineBreakMode))at_lineBreakMode{
//    return ^(NSLineBreakMode a){
//        self.lineBreakMode = a;
//        return self;
//    };
//}
//
//- (UILabel * (^)(UIBaselineAdjustment))at_baselineAdjustment{
//    return ^(UIBaselineAdjustment a){
//        self.baselineAdjustment = a;
//        return self;
//    };
//}
//
//- (UILabel * (^)(BOOL))at_allowsDefaultTighteningForTruncation{
//    return ^(BOOL a){
//        if (@available(iOS 9.0, *)) {
//            self.allowsDefaultTighteningForTruncation = a;
//        } else {
//            // Fallback on earlier versions
//        }
//        return self;
//    };
//}
//
//- (UILabel * (^)(CGFloat))at_preferredMaxLayoutWidth{
//    return ^(CGFloat a){
//        self.preferredMaxLayoutWidth = a;
//        return self;
//    };
//}
//
//- (UILabel * (^)(BOOL))at_adjustsFontSizeToFitWidth{
//    return ^(BOOL a){
//        self.adjustsFontSizeToFitWidth = a;
//        return self;
//    };
//}
//
//- (UILabel * (^)(UIColor *))at_highlightedTextColor{
//    return ^(UIColor *a){
//        self.highlightedTextColor = a;
//        return self;
//    };
//}
//
//- (UILabel * (^)(CGFloat))at_minimumScaleFactor{
//    return ^(CGFloat a){
//        self.minimumScaleFactor = a;
//        return self;
//    };
//}

@end
