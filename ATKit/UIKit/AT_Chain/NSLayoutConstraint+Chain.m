

#import "NSLayoutConstraint+Chain.h"

@implementation NSLayoutConstraint (Chain)
- (NSLayoutConstraint * (^)(CGFloat ))at_constant{
    return ^(CGFloat a){
        self.constant = a;
        return self;
    };
}
@end
