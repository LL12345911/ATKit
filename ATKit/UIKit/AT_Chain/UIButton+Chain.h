
#import <UIKit/UIKit.h>

@interface UIButton (Chain)

+ (UIButton *(^)(UIButtonType))at_buttonWithType;

- (UIButton *(^)(UIColor *))at_backgroundColor;

- (UIButton *(^)(CGRect))at_frame;

- (UIButton *(^)(UIView *))at_addToSuperView;

- (UIButton *(^)(BOOL))at_clipsToBounds;

- (UIButton *(^)(BOOL))at_hidden;

- (UIButton *(^)(BOOL))at_userInteractionEnabled;

- (UIButton *(^)(CGFloat))at_alpha;

- (UIButton *(^)(UIEdgeInsets))at_contentEdgeInsets;

- (UIButton *(^)(UIEdgeInsets))at_titleEdgeInsets;

- (UIButton *(^)(UIEdgeInsets))at_imageEdgeInsets;

- (UIButton * (^)(UIFont *))at_titleLabelFont;

- (UIButton * (^)(NSString *,UIControlState))at_stateTitle;

- (UIButton * (^)(UIColor  *,UIControlState))at_stateTitleColor;

- (UIButton * (^)(UIImage  *,UIControlState))at_stateImage;

/// 向Button上添加 Activity loading
- (UIButton * (^)(UIColor *bg, UIActivityIndicatorViewStyle st))at_loading;
/// 向Button上添加 Activity loading 自设坐标
- (UIButton * (^)(UIColor *bg, UIColor *act, UIActivityIndicatorViewStyle st, CGPoint po))at_loadingC;
/// 将 loading remove
- (UIButton * (^)(void))at_loadingHidden;

/// 向Button上添加 自定义 loading
- (UIButton * (^)(void (^)(void)))at_loadingCustom;
/// 将 指定 loading remove 配合 at_loadingCustom 使用
- (UIButton * (^)(NSInteger))at_loadingHiddenTag;




//#pragma clang diagnostic push
//#pragma clang diagnostic ignored"-Wignored-attributes"
//
//
///**
// 设置 标题
// */
//- (UIButton * (NS_NOESCAPE ^)(NSString *))at_title;
///**
// 设置 标题 和状态
// */
//- (UIButton * (NS_NOESCAPE ^)(NSString *, UIControlState))at_titleState;
///**
// 设置 文字颜色
// */
//- (UIButton * (NS_NOESCAPE ^)(UIColor *))at_titleColor;
///**
// 设置 文字颜色 和 状态
// */
//- (UIButton * (NS_NOESCAPE ^)(UIColor *, UIControlState))at_titleColorState;
///**
// 设置 字体
// */
//- (UIButton * (NS_NOESCAPE ^)(UIFont *))at_titleFont;
///**
// 设置 是否可用
// */
//- (UIButton * (NS_NOESCAPE ^)(BOOL))at_enabled;
//
///**
// 设置 图片
// */
//- (UIButton * (NS_NOESCAPE ^)(UIImage *))at_image;
//- (UIButton * (NS_NOESCAPE ^)(UIImage *, UIControlState))at_imageState;
//- (UIButton * (NS_NOESCAPE ^)(UIImage *))at_bgImage;
//- (UIButton * (NS_NOESCAPE ^)(UIImage *, UIControlState))at_bgImageState;
//- (UIButton * (NS_NOESCAPE ^)(NSAttributedString *))at_attributedTitle;
//- (UIButton * (NS_NOESCAPE ^)(NSAttributedString *, UIControlState))at_attributedTitleState;
////- (UIButton * (NS_NOESCAPE ^)(CGFloat , CGFloat, CGFloat, CGFloat))at_titleEdgeInsets;
////- (UIButton * (NS_NOESCAPE ^)(CGFloat , CGFloat, CGFloat, CGFloat))at_imageEdgeInsets;
//- (UIButton * (NS_NOESCAPE ^)(UIControlContentHorizontalAlignment))at_contentHorizontalAlignment;
//- (UIButton * (NS_NOESCAPE ^)(UIControlContentVerticalAlignment))at_contentVerticalAlignment;
//- (UIButton * (NS_NOESCAPE ^)(BOOL))at_reversesTitleShadowWhenHighlighted;
//- (UIButton * (NS_NOESCAPE ^)(BOOL))at_adjustsImageWhenHighlighted;
//- (UIButton * (NS_NOESCAPE ^)(BOOL))at_adjustsImageWhenDisabled;
//- (UIButton * (NS_NOESCAPE ^)(BOOL))at_showsTouchWhenHighlighted;
//
//
//
/////// 向Button上添加 Activity loading
////- (UIButton * (NS_NOESCAPE ^)(UIColor *bg, UIActivityIndicatorViewStyle st))at_loading;
/////// 向Button上添加 Activity loading 自设坐标
////- (UIButton * (^)(UIColor *bg, UIColor *act, UIActivityIndicatorViewStyle st, CGPoint po))at_loadingC;
/////// 将 loading remove
////- (UIButton * (NS_NOESCAPE ^)(void))at_loadingHidden;
////
/////// 向Button上添加 自定义 loading
////- (UIButton * (NS_NOESCAPE ^)(void (^)(void)))at_loadingCustom;
/////// 将 指定 loading remove 配合 at_loadingCustom 使用
////- (UIButton * (NS_NOESCAPE ^)(NSInteger))at_loadingHiddenTag;
//
//
//#pragma clang diagnostic pop


@end
