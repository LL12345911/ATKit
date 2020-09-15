
#import "UIButton+Chain.h"

@implementation UIButton (Chain)

+ (UIButton *(^)(UIButtonType))at_buttonWithType {
    return ^(UIButtonType buttonType) {
        return [UIButton buttonWithType:buttonType];
    };
}

- (UIButton *(^)(UIColor *))at_backgroundColor {
    return ^(UIColor *backgroundColor) {
        self.backgroundColor = backgroundColor;
        return self;
    };
}

- (UIButton *(^)(CGRect))at_frame {
    return  ^(CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UIButton *(^)(UIView *))at_addToSuperView {
    return ^(UIView *view) {
        [view addSubview:self];
        return self;
    };
}

- (UIButton *(^)(BOOL))at_clipsToBounds {
    return ^(BOOL clipsToBounds) {
        self.clipsToBounds = clipsToBounds;
        return self;
    };
}

- (UIButton *(^)(BOOL))at_hidden {
    return ^(BOOL hidden) {
        self.hidden = hidden;
        return self;
    };
}

- (UIButton *(^)(BOOL))at_userInteractionEnabled {
    return ^(BOOL userInteractionEnabled) {
        self.userInteractionEnabled = userInteractionEnabled;
        return self;
    };
}

- (UIButton *(^)(CGFloat))at_alpha {
    return ^(CGFloat alpha) {
        self.alpha = alpha;
        return self;
    };
}

- (UIButton *(^)(UIEdgeInsets))at_contentEdgeInsets {
    return ^(UIEdgeInsets contentEdgeInsets) {
        self.contentEdgeInsets = contentEdgeInsets;
        return self;
    };
}

- (UIButton *(^)(UIEdgeInsets))at_titleEdgeInsets {
    return ^(UIEdgeInsets titleEdgeInsets) {
        self.titleEdgeInsets = titleEdgeInsets;
        return self;
    };
}

- (UIButton *(^)(UIEdgeInsets))at_imageEdgeInsets {
    return ^(UIEdgeInsets imageEdgeInsets) {
        self.imageEdgeInsets = imageEdgeInsets;
        return self;
    };
}

- (UIButton * (^)(UIFont *))at_titleLabelFont {
    return ^(UIFont *font){
        self.titleLabel.font = font;
        return self;
    };
}

- (UIButton * (^)(NSString *, UIControlState))at_stateTitle {
    return ^(NSString *title, UIControlState state) {
        [self setTitle:title forState:state];
        return self;
    };
}

- (UIButton * (^)(UIColor *,UIControlState))at_stateTitleColor {
    return ^(UIColor *titleColor, UIControlState state) {
        [self setTitleColor:titleColor forState:state];
        return self;
    };
}

- (UIButton * (^)(UIImage *,UIControlState))at_stateImage {
    return ^(UIImage *image, UIControlState state) {
        [self setImage:image forState:state];
        return self;
    };
}


- (UIButton * (^)(UIColor *bg, UIActivityIndicatorViewStyle st))at_loading{
    return ^(UIColor * b, UIActivityIndicatorViewStyle s){
        self.enabled = NO;
        UIView * v = [UIView new];
        v.frame = self.bounds;
        v.tag = -8668;
        v.backgroundColor = b;
        [self addSubview:v];
        UIActivityIndicatorView * act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:s];
        act.frame = v.bounds;
        [act startAnimating];
        [v addSubview:act];
        ///超时
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.at_loadingHidden();
        });
        return self;
    };
}

- (UIButton * (^)(UIColor *bg, UIColor *act, UIActivityIndicatorViewStyle st, CGPoint po))at_loadingC{
    return ^(UIColor * b, UIColor *act, UIActivityIndicatorViewStyle s, CGPoint p){
        self.enabled = NO;
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:s];
        [activity startAnimating];
        UIView * v = [UIView new];
        v.center = p;
        v.bounds = activity.bounds;
        v.tag = -8668;
        v.backgroundColor = b;
        if (act) {
            activity.color = act;
        }
        activity.frame = v.bounds;
        [self addSubview:v];
        [v addSubview:activity];
        ///超时
        __weak typeof(self) weakSelf = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.at_loadingHidden();
        });
        return self;
    };
}
/// 向Button上添加 Activity loading 自定义Activity
- (UIButton * (^)(void (^)(void)))at_loadingCustom{
    return ^( void (^custom)(void)){
        if (custom) {
            custom();
        }
        return self;
    };
}

- (UIButton * (^)(void))at_loadingHidden{
    return ^(void){
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.tag == -8668) {
                [obj removeFromSuperview];
                *stop = YES;
            }
        }];
        self.enabled = YES;
        return self;
    };
}

- (UIButton * (^)(NSInteger))at_loadingHiddenTag{
    return ^(NSInteger tag){
        __block NSInteger t = tag;
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.tag == t) {
                [obj removeFromSuperview];
                *stop = YES;
            }
        }];
        self.enabled = YES;
        return self;
    };
}


#pragma mark -
//- (UIButton * (^)(NSString *))at_title{
//    return ^(NSString * a){
//        self.at_titleState(a,UIControlStateNormal);
//        return self;
//    };
//}
//
//- (UIButton * (^)(NSString *, UIControlState))at_titleState{
//    return ^(NSString *a, UIControlState b){
//        [self setTitle:a forState:b];
//        return self;
//    };
//}
//
//- (UIButton * (^)(UIColor *))at_titleColor{
//    return ^(UIColor * a){
//        self.at_titleColorState(a,UIControlStateNormal);
//        return self;
//    };
//}
//
//- (UIButton * (^)(UIColor *, UIControlState))at_titleColorState{
//    return ^(UIColor *a, UIControlState b){
//        [self setTitleColor:a forState:b];
//        return self;
//    };
//}
//
//- (UIButton * (^)(UIFont *))at_titleFont{
//    return ^(UIFont *a){
//        self.titleLabel.font = a;
//        return self;
//    };
//}
//- (UIButton * (^)(BOOL))at_enabled{
//    return ^(BOOL a){
//        self.enabled = a;
//        return self;
//    };
//}
//
//- (UIButton * (^)(UIImage *))at_image{
//    return ^(UIImage *a){
//        [self setImage:a forState:UIControlStateNormal];
//        return self;
//    };
//}
//
//- (UIButton * (^)(UIImage *, UIControlState))at_imageState{
//    return ^(UIImage *a, UIControlState b){
//        [self setImage:a forState:b];
//        return self;
//    };
//}
//
//- (UIButton * (^)(UIImage *))at_bgImage{
//    return ^(UIImage *a){
//        [self setBackgroundImage:a forState:UIControlStateNormal];
//        return self;
//    };
//}
//
//- (UIButton * (^)(UIImage *, UIControlState))at_bgImageState{
//    return ^(UIImage *a, UIControlState b){
//        [self setBackgroundImage:a forState:b];
//        return self;
//    };
//}
//
//- (UIButton * (^)(NSAttributedString *))at_attributedTitle{
//    return ^(NSAttributedString * a){
//        [self setAttributedTitle:a forState:UIControlStateNormal];
//        return self;
//    };
//}
//- (UIButton * (^)(NSAttributedString *, UIControlState))at_attributedTitleState{
//    return ^(NSAttributedString * a, UIControlState b){
//        [self setAttributedTitle:a forState:b];
//        return self;
//    };
//}
////
////- (UIButton * (^)(CGFloat , CGFloat, CGFloat, CGFloat))at_titleEdgeInsets{
////    return ^(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right){
////        self.titleEdgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
////        return self;
////    };
////}
////
////- (UIButton * (^)(CGFloat , CGFloat, CGFloat, CGFloat))at_imageEdgeInsets{
////    return ^(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right){
////        self.imageEdgeInsets = UIEdgeInsetsMake(top, left, bottom, right);;
////        return self;
////    };
////}
//
//
//- (UIButton * (^)(UIControlContentHorizontalAlignment))at_contentHorizontalAlignment{
//    return ^(UIControlContentHorizontalAlignment a){
//        self.contentHorizontalAlignment = a;
//        return self;
//    };
//}
//- (UIButton * (^)(UIControlContentVerticalAlignment))at_contentVerticalAlignment{
//    return ^(UIControlContentVerticalAlignment a){
//        self.contentVerticalAlignment = a;
//        return self;
//    };
//}
//
//
//- (UIButton * (^)(BOOL))at_reversesTitleShadowWhenHighlighted{
//    return ^(BOOL a){
//        self.reversesTitleShadowWhenHighlighted = a;
//        return self;
//    };
//}
//- (UIButton * (^)(BOOL))at_adjustsImageWhenHighlighted{
//    return ^(BOOL a){
//        self.adjustsImageWhenHighlighted = a;
//        return self;
//    };
//}
//- (UIButton * (^)(BOOL))at_adjustsImageWhenDisabled{
//    return ^(BOOL a){
//        self.adjustsImageWhenDisabled = a;
//        return self;
//    };
//}
//- (UIButton * (^)(BOOL))at_showsTouchWhenHighlighted{
//    return ^(BOOL a){
//        self.showsTouchWhenHighlighted = a;
//        return self;
//    };
//}
//
////
////- (UIButton * (^)(UIColor *bg, UIActivityIndicatorViewStyle st))at_loading{
////    return ^(UIColor * b, UIActivityIndicatorViewStyle s){
////        self.enabled = NO;
////        UIView * v = [UIView new];
////        v.frame = self.bounds;
////        v.tag = -8668;
////        v.backgroundColor = b;
////        [self addSubview:v];
////        UIActivityIndicatorView * act = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:s];
////        act.frame = v.bounds;
////        [act startAnimating];
////        [v addSubview:act];
////        ///超时
////        __weak typeof(self) weakSelf = self;
////        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            __strong typeof(weakSelf) strongSelf = weakSelf;
////            strongSelf.at_loadingHidden();
////        });
////        return self;
////    };
////}
////
////- (UIButton * (^)(UIColor *bg, UIColor *act, UIActivityIndicatorViewStyle st, CGPoint po))at_loadingC{
////    return ^(UIColor * b, UIColor *act, UIActivityIndicatorViewStyle s, CGPoint p){
////        self.enabled = NO;
////        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:s];
////        [activity startAnimating];
////        UIView * v = [UIView new];
////        v.center = p;
////        v.bounds = activity.bounds;
////        v.tag = -8668;
////        v.backgroundColor = b;
////        if (act) {
////            activity.color = act;
////        }
////        activity.frame = v.bounds;
////        [self addSubview:v];
////        [v addSubview:activity];
////        ///超时
////        __weak typeof(self) weakSelf = self;
////        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            __strong typeof(weakSelf) strongSelf = weakSelf;
////            strongSelf.at_loadingHidden();
////        });
////        return self;
////    };
////}
/////// 向Button上添加 Activity loading 自定义Activity
////- (UIButton * (^)(void (^)(void)))at_loadingCustom{
////    return ^( void (^custom)(void)){
////        if (custom) {
////            custom();
////        }
////        return self;
////    };
////}
////
////- (UIButton * (^)(void))at_loadingHidden{
////    return ^(void){
////        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////            if (obj.tag == -8668) {
////                [obj removeFromSuperview];
////                *stop = YES;
////            }
////        }];
////        self.enabled = YES;
////        return self;
////    };
////}
////
////- (UIButton * (^)(NSInteger))at_loadingHiddenTag{
////    return ^(NSInteger tag){
////        __block NSInteger t = tag;
////        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
////            if (obj.tag == t) {
////                [obj removeFromSuperview];
////                *stop = YES;
////            }
////        }];
////        self.enabled = YES;
////        return self;
////    };
////}

@end
