

#import <UIKit/UIKit.h>

@interface UIImageView (Chain)

- (UIImageView *(^)(UIColor *))at_backgroundColor;

- (UIImageView *(^)(CGRect))at_frame;

- (UIImageView *(^)(UIView *))at_addToSuperView;

- (UIImageView *(^)(CGFloat))at_alpha;

- (UIImageView *(^)(BOOL))at_clipsToBounds;

- (UIImageView *(^)(BOOL))at_hidden;

- (UIImageView * (^)(UIImage *))at_image;

- (UIImageView * (^)(UIViewContentMode))at_viewContentMode;



- (UIImageView * (^)(UIImage *))at_highlightedImage;
- (UIImageView * (^)(BOOL))at_highlighted;

- (UIImageView * (^)(NSArray<UIImage *> *))at_animationImages;
- (UIImageView * (^)(NSArray<UIImage *> *))at_highlightedAnimationImages;

- (UIImageView * (^)(NSTimeInterval))at_animationDuration;

- (UIImageView * (^)(NSInteger))at_animationRepeatCount;
- (UIImageView * (^)(void))at_startAnimating;
- (UIImageView * (^)(void))at_stopAnimating;
- (UIImageView * (^)(NSArray<NSString*> *names, NSTimeInterval t))at_animateImageNames;



//#pragma clang diagnostic push
//#pragma clang diagnostic ignored"-Wignored-attributes"
//
////- (UIImageView * (NS_NOESCAPE ^)(UIImage *))at_image;
//
//- (UIImageView * (NS_NOESCAPE ^)(UIImage *))at_highlightedImage;
//- (UIImageView * (NS_NOESCAPE ^)(BOOL))at_highlighted;
//
//- (UIImageView * (NS_NOESCAPE ^)(NSArray<UIImage *> *))at_animationImages;
//- (UIImageView * (NS_NOESCAPE ^)(NSArray<UIImage *> *))at_highlightedAnimationImages;
//
//- (UIImageView * (NS_NOESCAPE ^)(NSTimeInterval))at_animationDuration;
//
//- (UIImageView * (NS_NOESCAPE ^)(NSInteger))at_animationRepeatCount;
//- (UIImageView * (NS_NOESCAPE ^)(void))at_startAnimating;
//- (UIImageView * (NS_NOESCAPE ^)(void))at_stopAnimating;
//- (UIImageView * (NS_NOESCAPE ^)(NSArray<NSString*> *names, NSTimeInterval t))at_animateImageNames;
//
//#pragma clang diagnostic pop

@end
