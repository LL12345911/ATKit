

#import <UIKit/UIKit.h>

@interface UIView (Chain)

- (UIView *(^)(UIColor *))at_backgroundColor;

- (UIView *(^)(CGRect))at_frame;

- (UIView *(^)(UIView *))at_addToSuperView;

- (UIView *(^)(CGFloat))at_alpha;

- (UIView *(^)(BOOL))at_clipsToBounds;

- (UIView *(^)(BOOL))at_hidden;

- (UIView *(^)(BOOL))at_userInteractionEnabled;




+ (instancetype)at_init;

//- (UIView *(^)(CGRect))at_frame;
- (UIView *(^)(CGRect ))at_bounds;
- (UIView *(^)(CGPoint ))at_center;
- (UIView *(^)(NSInteger))at_tag;
//- (UIView *(^)(BOOL))at_hidden;
//- (UIView *(^)(BOOL))at_userInteractionEnabled;
- (UIView *(^)(UIViewContentMode))at_contentMode;
/// 背景颜色
- (UIView *(^)(UIColor*))at_bgColor;

- (UIView *(^)(UIColor*))at_tintColor;
- (UIView *(^)(CGFloat))at_borderWidth;
- (UIView *(^)(UIColor*))at_borderColor;
- (UIView *(^)(CGFloat))at_cornerRadius;
//- (UIView *(^)(BOOL))at_clipsToBounds;
- (UIView *(^)(CGFloat, BOOL))at_radius_clips;
/**
 *  设置部分圆角(绝对布局)
 *
 *  param corners 圆角类型组 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  param radii   圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 */
/// 设置部分圆角(绝对布局)
- (UIView *(^)(UIRectCorner, CGSize))at_byRoundedCornersRadii;
/**
 *  设置部分圆角(相对布局)
 *  param rect    圆角view的rect
 *  param corners 圆角类型组 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
 *  param radii   圆角大小 例如 CGSizeMake(20.0f, 20.0f)
 *
 */
/// 设置部分圆角(相对布局)
- (UIView *(^)(UIRectCorner, CGSize, CGRect))at_byRoundedRectCornersRadii;

/// 变形属性(平移\缩放\旋转)
- (UIView *(^)(CGAffineTransform))at_transform;
/// 自动调整子视图尺寸，默认YES则会根据autoresizingMask属性自动调整子视图尺寸
- (UIView *(^)(BOOL))at_autoresizesSubviews;
/// 自动调整子视图与父视图的位置，默认UIViewAutoresizingNone
- (UIView *(^)(UIViewAutoresizing))at_autoresizingMask;

- (UIView *(^)(UIColor *))at_shadowColor;
- (UIView *(^)(CGSize))at_shadowOffset;
- (UIView *(^)(float))at_shadowOpacity;
- (UIView *(^)(CGFloat))at_shadowRadius;
- (UIView *(^)(CGPathRef))at_shadowPath;
- (UIView *(^)(UIView *))at_addSubView;


- (UIView * (^)(BOOL))at_opaque;
//- (UIView * (^)(CGFloat))at_alpha;
- (UIView * (^)(BOOL))at_masksToBounds;
- (UIView * (^)(UIEdgeInsets))at_layoutMargins;

- (UIView * (^)(UIGestureRecognizer *))at_addGestureRecognizer;
- (UIView * (^)(NSLayoutConstraint *))at_addConstraint;
- (UIView * (^)(NSArray<__kindof NSLayoutConstraint *> *))at_addConstraints;


//
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored"-Wignored-attributes"
//#pragma clang diagnostic ignored"-Wincomplete-implementation"
//
//
//
////- (UIView *(NS_NOESCAPE ^)(CGRect))at_frame;
//- (UIView *(NS_NOESCAPE ^)(CGRect ))at_bounds;
//- (UIView *(NS_NOESCAPE ^)(CGPoint ))at_center;
//- (UIView *(NS_NOESCAPE ^)(NSInteger))at_tag;
////- (UIView *(NS_NOESCAPE ^)(BOOL))at_hidden;
////- (UIView *(NS_NOESCAPE ^)(BOOL))at_userInteractionEnabled;
//- (UIView *(NS_NOESCAPE ^)(UIViewContentMode))at_contentMode;
///// 背景颜色
//- (UIView *(NS_NOESCAPE ^)(UIColor*))at_bgColor;
//
//- (UIView *(NS_NOESCAPE ^)(UIColor*))at_tintColor;
//- (UIView *(NS_NOESCAPE ^)(CGFloat))at_borderWidth;
//- (UIView *(NS_NOESCAPE ^)(UIColor*))at_borderColor;
//- (UIView *(NS_NOESCAPE ^)(CGFloat))at_cornerRadius;
////- (UIView *(NS_NOESCAPE ^)(BOOL))at_clipsToBounds;
//- (UIView *(NS_NOESCAPE ^)(CGFloat, BOOL))at_radius_clips;
///**
// *  设置部分圆角(绝对布局)
// *
// *  param corners 圆角类型组 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
// *  param radii   圆角大小 例如 CGSizeMake(20.0f, 20.0f)
// */
///// 设置部分圆角(绝对布局)
//- (UIView *(NS_NOESCAPE ^)(UIRectCorner, CGSize))at_byRoundedCornersRadii;
///**
// *  设置部分圆角(相对布局)
// *  param rect    圆角view的rect
// *  param corners 圆角类型组 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
// *  param radii   圆角大小 例如 CGSizeMake(20.0f, 20.0f)
// *
// */
///// 设置部分圆角(相对布局)
//- (UIView *(NS_NOESCAPE ^)(UIRectCorner, CGSize, CGRect))at_byRoundedRectCornersRadii;
//
///// 变形属性(平移\缩放\旋转)
//- (UIView *(NS_NOESCAPE ^)(CGAffineTransform))at_transform;
///// 自动调整子视图尺寸，默认YES则会根据autoresizingMask属性自动调整子视图尺寸
//- (UIView *(NS_NOESCAPE ^)(BOOL))at_autoresizesSubviews;
///// 自动调整子视图与父视图的位置，默认UIViewAutoresizingNone
//- (UIView *(NS_NOESCAPE ^)(UIViewAutoresizing))at_autoresizingMask;
//
//- (UIView *(NS_NOESCAPE ^)(UIColor *))at_shadowColor;
//- (UIView *(NS_NOESCAPE ^)(CGSize))at_shadowOffset;
//- (UIView *(NS_NOESCAPE ^)(float))at_shadowOpacity;
//- (UIView *(NS_NOESCAPE ^)(CGFloat))at_shadowRadius;
//- (UIView *(NS_NOESCAPE ^)(CGPathRef))at_shadowPath;
//- (UIView *(NS_NOESCAPE ^)(UIView *))at_addSubView;
//
//
//- (UIView * (NS_NOESCAPE ^)(BOOL))at_opaque;
////- (UIView * (NS_NOESCAPE ^)(CGFloat))at_alpha;
//- (UIView * (NS_NOESCAPE ^)(BOOL))at_masksToBounds;
//- (UIView * (^)(UIEdgeInsets))at_layoutMargins;
//
//- (UIView * (NS_NOESCAPE ^)(UIGestureRecognizer *))at_addGestureRecognizer;
//- (UIView * (NS_NOESCAPE ^)(NSLayoutConstraint *))at_addConstraint;
//- (UIView * (NS_NOESCAPE ^)(NSArray<__kindof NSLayoutConstraint *> *))at_addConstraints;
//
//
//#pragma clang diagnostic pop

@end
