//
//  UILabel+EffectSize.m
//  CSS
//
//  Created by mac on 2018/11/29.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "UILabel+EffectSize.h"
#import <objc/runtime.h>

@implementation UILabel (EffectSize)

- (void)lineSpace:(CGFloat)lineSpace {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
}

- (void)wordSpace:(CGFloat)wordSpace {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
}

- (void)lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace {
    NSString *labelText = self.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    self.attributedText = attributedString;
}

/**
 行间距
 */
- (void)setLineSpacing:(CGFloat)qsLineSpacing{
    objc_setAssociatedObject(self, @selector(lineSpacing), [NSNumber numberWithFloat:qsLineSpacing], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)lineSpacing{
    return [objc_getAssociatedObject(self, @selector(lineSpacing)) floatValue];
}

/**
 最大显示宽度
 */
- (void)setConstrainedWidth:(CGFloat)qsConstrainedWidth{
    objc_setAssociatedObject(self, @selector(constrainedWidth), [NSNumber numberWithFloat:qsConstrainedWidth], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)constrainedWidth{
    return [objc_getAssociatedObject(self, @selector(constrainedWidth)) floatValue];
}
/**
 文本适应于指定的行数
 @return 文本是否被numberOfLines限制
 */
- (BOOL)adjustTextToFitLines:(NSInteger)numberOfLines{
    
    if (!self.text || self.text.length == 0) {
        return NO;
    }
    
    self.numberOfLines = numberOfLines;
    BOOL isLimitedToLines = NO;
    
    CGSize textSize = [self textSizeWithFont:self.font text:self.text numberOfLines:self.numberOfLines lineSpacing:self.lineSpacing constrainedWidth:self.constrainedWidth isLimitedToLines:&isLimitedToLines];
    
    
    //单行的情况
    if (fabs(textSize.height - self.font.lineHeight) < 0.00001f) {
        self.lineSpacing = 0.0f;
    }
    
    //设置文字的属性
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:self.lineSpacing];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    [attributedString addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, [self.text length])];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [self.text length])];
    
    
    [self setAttributedText:attributedString];
    self.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
    return isLimitedToLines;
}

/**
 根据字体、行数、行间距和constrainedWidth计算文本占据的size
 
 @param font 字体
 @param numberOfLines 显示文本行数，值为0不限制行数
 @param lineSpacing 行间距
 @param constrainedWidth 文本受限的宽度
 @param isLimitedToLines 记录文本是否被numberOfLines限制
 @return 返回文本占据的size
 */
/**
 根据字体、行数、行间距和constrainedWidth计算文本占据的size
 **/
- (CGSize)textSizeWithFont:(UIFont*)font
                      text:(NSString *)text
             numberOfLines:(NSInteger)numberOfLines
               lineSpacing:(CGFloat)lineSpacing
          constrainedWidth:(CGFloat)constrainedWidth
          isLimitedToLines:(BOOL *)isLimitedToLines{
    
    if (text.length == 0) {
        return CGSizeZero;
    }
    CGFloat oneLineHeight = font.lineHeight;
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(constrainedWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    
    CGFloat rows = textSize.height / oneLineHeight;
    CGFloat realHeight = oneLineHeight;
    // 0 不限制行数
    if (numberOfLines == 0) {
        if (rows >= 1) {
            realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
        }
    }else{
        if (rows > numberOfLines) {
            rows = numberOfLines;
            if (isLimitedToLines) {
                *isLimitedToLines = YES;  //被限制
            }
        }
        realHeight = (rows * oneLineHeight) + (rows - 1) * lineSpacing;
    }
    
    return CGSizeMake(constrainedWidth, realHeight);
}

- (void)setTextChanged:(void (^)(BOOL))textChanged {
    objc_setAssociatedObject(self, @selector(textChanged), textChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(BOOL))textChanged {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAttributeTextChanged:(void (^)(BOOL))attributeTextChanged {
    objc_setAssociatedObject(self, @selector(attributeTextChanged), attributeTextChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(BOOL))attributeTextChanged {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)startMonitorText {
    object_setClass(self, [EffectSizeLabel class]);
}

@end


@implementation EffectSizeLabel

- (void)setText:(NSString *)text {
    NSString * oldString = self.text;
    [super setText:text];
    if ([oldString isEqualToString:text]) {
        !self.textChanged ?: self.textChanged(NO);
    } else {
        !self.textChanged ?: self.textChanged(YES);
    }
}

/// 富文本变动的标准不能完全统一 暂时定为文字
- (void)setAttributedText:(NSAttributedString *)attributedText {
    NSString * oldString = self.attributedText.string;
    [super setAttributedText:attributedText];
    if ([oldString isEqualToString:attributedText.string]) {
        !self.textChanged ?: self.textChanged(NO);
    } else {
        !self.textChanged ?: self.textChanged(YES);
    }
}

- (instancetype)init {
    assert(false);
    return [super init];
}
- (instancetype)initWithFrame:(CGRect)frame {
    assert(false);
    return [super initWithFrame:frame];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    assert(false);
    return [super initWithCoder:aDecoder];
}

@end
