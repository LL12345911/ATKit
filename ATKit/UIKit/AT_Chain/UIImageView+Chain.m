

#import "UIImageView+Chain.h"

@implementation UIImageView (Chain)

- (UIImageView *(^)(UIColor *))at_backgroundColor {
    return ^(UIColor *backgroundColor) {
        self.backgroundColor = backgroundColor;
        return self;
    };
}

- (UIImageView *(^)(CGRect))at_frame {
    return  ^(CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UIImageView *(^)(UIView *))at_addToSuperView {
    return ^(UIView *view) {
        [view addSubview:self];
        return self;
    };
}

- (UIImageView *(^)(BOOL))at_clipsToBounds {
    return ^(BOOL clipsToBounds) {
        self.clipsToBounds = clipsToBounds;
        return self;
    };
}

- (UIImageView *(^)(BOOL))at_hidden {
    return ^(BOOL hidden) {
        self.hidden = hidden;
        return self;
    };
}

- (UIImageView *(^)(CGFloat))at_alpha {
    return ^(CGFloat alpha) {
        self.alpha = alpha;
        return self;
    };
}

- (UIImageView * (^)(UIImage *))at_image {
    return ^(UIImage *image) {
        self.image = image;
        return self;
    };
}

- (UIImageView *(^)(BOOL))at_userInteractionEnabled {
    return ^(BOOL userInteractionEnabled) {
        self.userInteractionEnabled = userInteractionEnabled;
        return self;
    };
}

- (UIImageView * (^)(UIViewContentMode))at_viewContentMode {
    return ^(UIViewContentMode contentMode){
        self.contentMode = contentMode;
        return self;
    };
}

- (UIImageView * (^)(UIImage *))at_highlightedImage{
    return ^(UIImage *a){
        self.highlightedImage = a;
        return self;
    };
}

- (UIImageView * (^)(BOOL))at_highlighted{
    return ^(BOOL a){
        self.highlighted = a;
        return self;
    };
}

- (UIImageView * (^)(NSArray<UIImage *> *))at_animationImages{
    return ^(NSArray<UIImage *> * a){
        self.animationImages = a;
        return self;
    };
}
- (UIImageView * (^)(NSArray<UIImage *> *))at_highlightedAnimationImages{
    return ^(NSArray<UIImage *> * a){
        self.highlightedAnimationImages = a;
        return self;
    };
}

- (UIImageView * (^)(NSTimeInterval))at_animationDuration{
    return ^(NSTimeInterval a){
        self.animationDuration = a;
        return self;
    };
}

- (UIImageView * (^)(NSInteger))at_animationRepeatCount{
    return ^(NSInteger a){
        self.animationRepeatCount = a;
        return self;
    };
}
- (UIImageView * (^)(void))at_startAnimating{
    return ^(void){
        [self startAnimating];
        return self;
    };
}
- (UIImageView * (^)(void))at_stopAnimating{
    return ^(void){
        [self stopAnimating];
        return self;
    };
}

- (UIImageView * (^)(NSArray<NSString*> *names, NSTimeInterval t))at_animateImageNames{
    return ^(NSArray<NSString*> * imgs, NSTimeInterval time){
        NSMutableArray *imgArray = [NSMutableArray array];
        for (NSString * n in imgs) {
            UIImage *image = [UIImage imageNamed:n];
            [imgArray addObject:image];
        }
        self.animationImages = imgArray;
        self.animationDuration = time;
        self.animationRepeatCount = 1;
        [self startAnimating];
        return self;
    };
}

#pragma mark -

//- (UIImageView * (^)(UIImage *))at_image{
//    return ^(UIImage *a){
//        self.image = a;
//        return self;
//    };
//}

//- (UIImageView * (^)(UIImage *))at_highlightedImage{
//    return ^(UIImage *a){
//        self.highlightedImage = a;
//        return self;
//    };
//}
//
//- (UIImageView * (^)(BOOL))at_highlighted{
//    return ^(BOOL a){
//        self.highlighted = a;
//        return self;
//    };
//}
//
//- (UIImageView * (^)(NSArray<UIImage *> *))at_animationImages{
//    return ^(NSArray<UIImage *> * a){
//        self.animationImages = a;
//        return self;
//    };
//}
//- (UIImageView * (^)(NSArray<UIImage *> *))at_highlightedAnimationImages{
//    return ^(NSArray<UIImage *> * a){
//        self.highlightedAnimationImages = a;
//        return self;
//    };
//}
//
//- (UIImageView * (^)(NSTimeInterval))at_animationDuration{
//    return ^(NSTimeInterval a){
//        self.animationDuration = a;
//        return self;
//    };
//}
//
//- (UIImageView * (^)(NSInteger))at_animationRepeatCount{
//    return ^(NSInteger a){
//        self.animationRepeatCount = a;
//        return self;
//    };
//}
//- (UIImageView * (^)(void))at_startAnimating{
//    return ^(void){
//        [self startAnimating];
//        return self;
//    };
//}
//- (UIImageView * (^)(void))at_stopAnimating{
//    return ^(void){
//        [self stopAnimating];
//        return self;
//    };
//}
//
//- (UIImageView * (^)(NSArray<NSString*> *names, NSTimeInterval t))at_animateImageNames{
//    return ^(NSArray<NSString*> * imgs, NSTimeInterval time){
//        NSMutableArray *imgArray = [NSMutableArray array];
//        for (NSString * n in imgs) {
//            UIImage *image = [UIImage imageNamed:n];
//            [imgArray addObject:image];
//        }
//        self.animationImages = imgArray;
//        self.animationDuration = time;
//        self.animationRepeatCount = 1;
//        [self startAnimating];
//        return self;
//    };
//}

@end
