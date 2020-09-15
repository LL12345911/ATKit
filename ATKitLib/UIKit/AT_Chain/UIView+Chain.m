

#import "UIView+Chain.h"

@implementation UIView (Chain)

- (UIView *(^)(UIColor *))at_backgroundColor {
    return ^(UIColor *backgroundColor) {
        self.backgroundColor = backgroundColor;
        return self;
    };
}

- (UIView *(^)(CGRect))at_frame {
    return  ^(CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UIView *(^)(UIView *))at_addToSuperView {
    return ^(UIView *view) {
        [view addSubview:self];
        return self;
    };
}

- (UIView *(^)(BOOL))at_clipsToBounds {
    return ^(BOOL clipsToBounds) {
        self.clipsToBounds = clipsToBounds;
        return self;
    };
}

- (UIView *(^)(BOOL))at_hidden {
    return ^(BOOL hidden) {
        self.hidden = hidden;
        return self;
    };
}

- (UIView *(^)(BOOL))at_userInteractionEnabled {
    return ^(BOOL userInteractionEnabled) {
        self.userInteractionEnabled = userInteractionEnabled;
        return self;
    };
}

- (UIView *(^)(CGFloat))at_alpha {
    return ^(CGFloat alpha) {
        self.alpha = alpha;
        return self;
    };
}



#pragma mark -
+ (instancetype)at_init{
    return [[self alloc] init];
}

//- (UIView *(^)(CGRect))at_frame{
//    return ^(CGRect a) {
//        self.frame = a;
//        return self;
//    };
//}

- (UIView *(^)(CGRect))at_bounds{
    return ^(CGRect a) {
        self.bounds = a;
        return self;
    };
}

- (UIView *(^)(CGPoint))at_center{
    return ^(CGPoint a) {
        self.center = a;
        return self;
    };
}

- (UIView * (^)(NSInteger))at_tag{
    return ^(NSInteger a) {
        self.tag = a;
        return self;
    };
}
//
//- (UIView * (^)(BOOL))at_hidden{
//    return ^(BOOL a) {
//        self.hidden = a;
//        return self;
//    };
//}
//
//- (UIView * (^)(BOOL))at_userInteractionEnabled{
//    return ^(BOOL a) {
//        self.userInteractionEnabled = a;
//        return self;
//    };
//}

- (UIView *(^)(UIViewContentMode))at_contentMode{
    return ^(UIViewContentMode a) {
        self.contentMode = a;
        return self;
    };
}

- (UIView *(^)(UIColor*))at_bgColor{
    return ^(UIColor* a) {
        self.backgroundColor = a;
        return self;
    };
}

- (UIView *(^)(UIColor*))at_tintColor{
    return ^(UIColor* a) {
        self.tintColor = a;
        return self;
    };
}

- (UIView *(^)(CGFloat))at_borderWidth{
    return ^(CGFloat a) {
        self.layer.borderWidth = a;
        return self;
    };
}
- (UIView *(^)(UIColor*))at_borderColor{
    return ^(UIColor* a) {
        self.layer.borderColor = a.CGColor;
        return self;
    };
}
- (UIView *(^)(CGFloat))at_cornerRadius{
    return ^(CGFloat a) {
        self.layer.cornerRadius = a;
        return self;
    };
}
//- (UIView *(^)(BOOL))at_clipsToBounds{
//    return ^(BOOL a) {
//        self.clipsToBounds = a;
//        return self;
//    };
//}

- (UIView *(^)(CGFloat, BOOL))at_radius_clips{
    return ^(CGFloat a, BOOL c) {
        self.layer.cornerRadius = a;
        self.clipsToBounds = c;
        return self;
    };
}
///设置部分圆角(绝对布局)
- (UIView *(^)(UIRectCorner, CGSize))at_byRoundedCornersRadii{
    return ^(UIRectCorner a, CGSize c) {
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:a cornerRadii:c];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        self.layer.mask = shape;
        return self;
    };
}
///设置部分圆角(相对布局)
- (UIView *(^)(UIRectCorner, CGSize, CGRect))at_byRoundedRectCornersRadii{
    return ^(UIRectCorner a,CGSize c, CGRect r) {
        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:r byRoundingCorners:a cornerRadii:c];
        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
        [shape setPath:rounded.CGPath];
        self.layer.mask = shape;
        return self;
    };
}





- (UIView *(^)(UIColor *))at_shadowColor{
    return ^(UIColor *c) {
        self.layer.shadowColor = c.CGColor;
        return self;
    };
}
- (UIView *(^)(CGSize))at_shadowOffset{
    return ^(CGSize a) {
        self.layer.shadowOffset = a;
        return self;
    };
}
- (UIView *(^)(float))at_shadowOpacity{
    return ^(float a) {
        self.layer.shadowOpacity = a;
        return self;
    };
}
- (UIView *(^)(CGFloat))at_shadowRadius{
    return ^(CGFloat a) {
        self.layer.shadowRadius = a;
        return self;
    };
}
- (UIView *(^)(CGPathRef))at_shadowPath{
    return ^(CGPathRef a) {
        self.layer.shadowPath = a;
        return self;
    };
}
/// 变形属性(平移\缩放\旋转)
- (UIView *(^)(CGAffineTransform))at_transform{
    return ^(CGAffineTransform a) {
        self.transform = a;
        return self;
    };
}
/// 自动调整子视图尺寸，默认YES则会根据autoresizingMask属性自动调整子视图尺寸
- (UIView *(^)(BOOL))at_autoresizesSubviews{
    return ^(BOOL a) {
        self.autoresizesSubviews = a;
        return self;
    };
}
/// 自动调整子视图与父视图的位置，默认UIViewAutoresizingNone
- (UIView *(^)(UIViewAutoresizing))at_autoresizingMask{
    return ^(UIViewAutoresizing a) {
        self.autoresizingMask = a;
        return self;
    };
}

- (UIView *(^)(UIView *))at_addSubView{
    return ^(UIView *a) {
        [self addSubview:a];
        return self;
    };
}

- (UIView * (^)(BOOL))at_opaque{
    return ^(BOOL a) {
        self.opaque = a;
        return self;
    };
}
//- (UIView * (^)(CGFloat))at_alpha{
//    return ^(CGFloat a) {
//        self.alpha = a;
//        return self;
//    };
//}

- (UIView * (^)(BOOL))at_masksToBounds{
    return ^(BOOL a) {
        self.layer.masksToBounds = a;
        return self;
    };
}

- (UIView * (^)(UIEdgeInsets))at_layoutMargins{
    return ^(UIEdgeInsets a) {
        self.layoutMargins = a;
        return self;
    };
}

- (UIView * (^)(UIGestureRecognizer *))at_addGestureRecognizer{
    return ^(UIGestureRecognizer *a) {
        [self addGestureRecognizer:a];
        return self;
    };
}

- (UIView * (^)(NSLayoutConstraint *))at_addConstraint{
    return ^(NSLayoutConstraint *a) {
        [self addConstraint:a];
        return self;
    };
}

- (UIView * (^)(NSArray<__kindof NSLayoutConstraint *> *))at_addConstraints{
    return ^(NSArray<__kindof NSLayoutConstraint *> *a) {
        [self addConstraints:a];
        return self;
    };
}

//#pragma mark -
//+ (instancetype)at_init{
//    return [[self alloc] init];
//}
//
////- (UIView *(^)(CGRect))at_frame{
////    return ^(CGRect a) {
////        self.frame = a;
////        return self;
////    };
////}
//
//- (UIView *(^)(CGRect))at_bounds{
//    return ^(CGRect a) {
//        self.bounds = a;
//        return self;
//    };
//}
//
//- (UIView *(^)(CGPoint))at_center{
//    return ^(CGPoint a) {
//        self.center = a;
//        return self;
//    };
//}
//
//- (UIView * (^)(NSInteger))at_tag{
//    return ^(NSInteger a) {
//        self.tag = a;
//        return self;
//    };
//}
////
////- (UIView * (^)(BOOL))at_hidden{
////    return ^(BOOL a) {
////        self.hidden = a;
////        return self;
////    };
////}
////
////- (UIView * (^)(BOOL))at_userInteractionEnabled{
////    return ^(BOOL a) {
////        self.userInteractionEnabled = a;
////        return self;
////    };
////}
//
//- (UIView *(^)(UIViewContentMode))at_contentMode{
//    return ^(UIViewContentMode a) {
//        self.contentMode = a;
//        return self;
//    };
//}
//
//- (UIView *(^)(UIColor*))at_bgColor{
//    return ^(UIColor* a) {
//        self.backgroundColor = a;
//        return self;
//    };
//}
//
//- (UIView *(^)(UIColor*))at_tintColor{
//    return ^(UIColor* a) {
//        self.tintColor = a;
//        return self;
//    };
//}
//
//- (UIView *(^)(CGFloat))at_borderWidth{
//    return ^(CGFloat a) {
//        self.layer.borderWidth = a;
//        return self;
//    };
//}
//- (UIView *(^)(UIColor*))at_borderColor{
//    return ^(UIColor* a) {
//        self.layer.borderColor = a.CGColor;
//        return self;
//    };
//}
//- (UIView *(^)(CGFloat))at_cornerRadius{
//    return ^(CGFloat a) {
//        self.layer.cornerRadius = a;
//        return self;
//    };
//}
////- (UIView *(^)(BOOL))at_clipsToBounds{
////    return ^(BOOL a) {
////        self.clipsToBounds = a;
////        return self;
////    };
////}
//
//- (UIView *(^)(CGFloat, BOOL))at_radius_clips{
//    return ^(CGFloat a, BOOL c) {
//        self.layer.cornerRadius = a;
//        self.clipsToBounds = c;
//        return self;
//    };
//}
/////设置部分圆角(绝对布局)
//- (UIView *(^)(UIRectCorner, CGSize))at_byRoundedCornersRadii{
//    return ^(UIRectCorner a, CGSize c) {
//        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:a cornerRadii:c];
//        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
//        [shape setPath:rounded.CGPath];
//        self.layer.mask = shape;
//        return self;
//    };
//}
/////设置部分圆角(相对布局)
//- (UIView *(^)(UIRectCorner, CGSize, CGRect))at_byRoundedRectCornersRadii{
//    return ^(UIRectCorner a,CGSize c, CGRect r) {
//        UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:r byRoundingCorners:a cornerRadii:c];
//        CAShapeLayer* shape = [[CAShapeLayer alloc] init];
//        [shape setPath:rounded.CGPath];
//        self.layer.mask = shape;
//        return self;
//    };
//}
//
//
//
//
//
//- (UIView *(^)(UIColor *))at_shadowColor{
//    return ^(UIColor *c) {
//        self.layer.shadowColor = c.CGColor;
//        return self;
//    };
//}
//- (UIView *(^)(CGSize))at_shadowOffset{
//    return ^(CGSize a) {
//        self.layer.shadowOffset = a;
//        return self;
//    };
//}
//- (UIView *(^)(float))at_shadowOpacity{
//    return ^(float a) {
//        self.layer.shadowOpacity = a;
//        return self;
//    };
//}
//- (UIView *(^)(CGFloat))at_shadowRadius{
//    return ^(CGFloat a) {
//        self.layer.shadowRadius = a;
//        return self;
//    };
//}
//- (UIView *(^)(CGPathRef))at_shadowPath{
//    return ^(CGPathRef a) {
//        self.layer.shadowPath = a;
//        return self;
//    };
//}
///// 变形属性(平移\缩放\旋转)
//- (UIView *(^)(CGAffineTransform))at_transform{
//    return ^(CGAffineTransform a) {
//        self.transform = a;
//        return self;
//    };
//}
///// 自动调整子视图尺寸，默认YES则会根据autoresizingMask属性自动调整子视图尺寸
//- (UIView *(^)(BOOL))at_autoresizesSubviews{
//    return ^(BOOL a) {
//        self.autoresizesSubviews = a;
//        return self;
//    };
//}
///// 自动调整子视图与父视图的位置，默认UIViewAutoresizingNone
//- (UIView *(^)(UIViewAutoresizing))at_autoresizingMask{
//    return ^(UIViewAutoresizing a) {
//        self.autoresizingMask = a;
//        return self;
//    };
//}
//
//- (UIView *(^)(UIView *))at_addSubView{
//    return ^(UIView *a) {
//        [self addSubview:a];
//        return self;
//    };
//}
//
//- (UIView * (^)(BOOL))at_opaque{
//    return ^(BOOL a) {
//        self.opaque = a;
//        return self;
//    };
//}
////- (UIView * (^)(CGFloat))at_alpha{
////    return ^(CGFloat a) {
////        self.alpha = a;
////        return self;
////    };
////}
//
//- (UIView * (^)(BOOL))at_masksToBounds{
//    return ^(BOOL a) {
//        self.layer.masksToBounds = a;
//        return self;
//    };
//}
//
//- (UIView * (^)(UIEdgeInsets))at_layoutMargins{
//    return ^(UIEdgeInsets a) {
//        self.layoutMargins = a;
//        return self;
//    };
//}
//
//- (UIView * (^)(UIGestureRecognizer *))at_addGestureRecognizer{
//    return ^(UIGestureRecognizer *a) {
//        [self addGestureRecognizer:a];
//        return self;
//    };
//}
//
//- (UIView * (^)(NSLayoutConstraint *))at_addConstraint{
//    return ^(NSLayoutConstraint *a) {
//        [self addConstraint:a];
//        return self;
//    };
//}
//
//- (UIView * (^)(NSArray<__kindof NSLayoutConstraint *> *))at_addConstraints{
//    return ^(NSArray<__kindof NSLayoutConstraint *> *a) {
//        [self addConstraints:a];
//        return self;
//    };
//}
@end
