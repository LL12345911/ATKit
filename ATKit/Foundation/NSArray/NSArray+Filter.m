//
//  NSArray+ATArrayUtils.m
//  HighwayDoctor
//
//  Created by Mars on 2019/5/29.
//  Copyright © 2019 Mars. All rights reserved.
//

#import "NSArray+Filter.h"


#pragma mark -
#pragma mark - ATArrayFilterUtils

@implementation NSArray (ATArrayFilterUtils)

-(NSArray *)at_FilteredArrayUsingFilter:(ATFilter)filter {
    NSMutableArray * array = [NSMutableArray array];
    filterArr(self,array,filter);
    return array.copy;
}

#pragma mark --- Filter Array Method ---
static inline void filterArr (NSArray * oriArr,NSMutableArray * desArr,ATFilter filter) {
    [oriArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (filter(obj,idx,desArr.count,stop)) {
            [desArr addObject:obj];
        }
    }];
}

@end

@implementation NSMutableArray (ATArrayFilterUtils)

-(void)at_FilterUsingFilter:(ATFilter)filter {
    NSArray * array = [NSArray arrayWithArray:self];
    [self removeAllObjects];
    filterArr(array, self, filter);
}

@end


#pragma mark -
#pragma mark - ATArrayKeyPathUtils

@implementation NSArray (ATArrayKeyPathUtils)

-(id)at_GetObjectWithKeyPath:(NSString *)path action:(ATArrayKeyPathActionType)action {
    if (action == ATArrayKeyPathActionTypeUnionInArray || action == ATArrayKeyPathActionTypeDistinctUnionInArray) {
        BOOL isArray = YES;
        for (id obj in self) {
            if (![obj isKindOfClass:[NSArray class]]) {
                isArray = NO;
            }
        }
        if (!isArray) {
            NSAssert(NO, @"to use %ld action you should make sure the array is made up of NSArray",action);
            return nil;
        }
    }
    NSString * actionStr = StringFromAction(action);
    if (!actionStr.length) {
        NSAssert(NO, @"cannot perform an action on %ld",action);
        return nil;
    }
    if (!path.length) {
        path = @"self";
    }
    return [self valueForKeyPath:[NSString stringWithFormat:@"%@%@",actionStr,path]];
}

static inline NSString * StringFromAction(ATArrayKeyPathActionType action) {
    switch (action) {
        case ATArrayKeyPathActionTypeSum:
            return @"@sum.";
        case ATArrayKeyPathActionTypeAverage:
            return @"@avg.";
        case ATArrayKeyPathActionTypeMaximum:
            return @"@max.";
        case ATArrayKeyPathActionTypeMinimum:
            return @"@min.";
        case ATArrayKeyPathActionTypeUnion:
            return @"@unionOfObjects.";
        case ATArrayKeyPathActionTypeDistinctUnion:
            return @"@distinctUnionOfObjects.";
        case ATArrayKeyPathActionTypeUnionInArray:
            return @"@unionOfArrays.";
        case ATArrayKeyPathActionTypeDistinctUnionInArray:
            return @"@distinctUnionOfArrays.";
        default:
            return nil;
    }
}

@end


#pragma mark -
#pragma mark - ATArraySearchUtils
 
@implementation NSArray (ATArraySearchUtils)

-(NSArray *)at_SortedArrayInHeapUsingComparator:(ATComparator)comparator {
    NSMutableArray * array = [NSMutableArray arrayWithArray:self];
    sortHeap(array, comparator);
    return array.copy;
}

#pragma mark --- Heap Sort Method ---
static inline NSUInteger leftLeaf(NSUInteger i) {
    return 2 * i + 1;
}

static inline NSUInteger rightLeaf(NSUInteger i) {
    return 2 * (i + 1);
}

static inline void swapArr (NSMutableArray * arr,NSUInteger m,NSUInteger n) {
    if (m >= arr.count || n > arr.count) {
        return;
    }
    id temp = arr[m];
    arr[m] = arr[n];
    arr[n] = temp;
}

static inline void maxHeap (NSMutableArray * arr,NSUInteger idx,NSUInteger len,ATComparator comparator) {
    NSUInteger m = leftLeaf(idx);
    NSUInteger n = rightLeaf(idx);
    NSUInteger max = idx;
    if (m < len && (comparator(arr[idx],arr[m]) == NSOrderedAscending)) {
        max = m;
    }
    if (n < len && (comparator(arr[max],arr[n]) == NSOrderedAscending)) {
        max = n;
    }
    if (max != idx) {
        swapArr(arr, idx, max);
        maxHeap(arr, max,len,comparator);
    }
}

static inline void buildMaxHeap (NSMutableArray * arr,ATComparator comparator) {
    for (NSInteger i = arr.count / 2 + 1;i >= 0;i --) {
        maxHeap(arr, i,arr.count,comparator);
    }
}

static inline void sortHeap (NSMutableArray * arr,ATComparator comparator) {
    buildMaxHeap(arr, comparator);
    NSInteger count = arr.count;
    while (count > 0) {
        swapArr(arr, 0, count - 1);
        count -- ;
        maxHeap(arr, 0, count,comparator);
    }
}
-(void)at_BinarySearchWithCondition:(ATSearchCondition)condition {
    if (!condition || self.count == 0) {
        return;
    }
    NSUInteger hR = self.count - 1;
    NSUInteger lR = 0;
    NSUInteger mR = 0;
    BOOL stop = NO;
    while (lR <= hR) {
        mR = (hR + lR) / 2;
        NSComparisonResult result = condition(self[mR],mR,&stop);
        if (result == NSOrderedSame || stop == YES) {
            break;
        } else if (result == NSOrderedAscending) {
            if (mR == 0) {
                break;
            } else {
                hR = mR - 1;
            }
        } else {
            if (mR == self.count - 1) {
                break;
            } else {
                lR = mR + 1;
            }
        }
    }
}

@end
//
//@implementation NSArray (ATArrayLogUtils)
//
//-(NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
//    NSString * footerBlank = @"";
//    for (int i = 0; i < level; i++) {
//        footerBlank = [footerBlank stringByAppendingString:@"\t"];
//    }
//    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"("];
//    NSString * contentBlank = [footerBlank stringByAppendingString:@"\t"];
//    for (id obj in self) {
//        id value = obj;
//        if ([value respondsToSelector:@selector(descriptionWithLocale:indent:)]) {
//            value = [value descriptionWithLocale:locale indent:level + 1];
//        }
//        [str appendFormat:@"\n%@%@,",contentBlank,value];
//    }
//    if (self.count) {
//        [str deleteCharactersInRange:NSMakeRange(str.length - 1, 1)];
//    }
//    [str appendString:[NSString stringWithFormat:@"\n%@)",footerBlank]];
//    return str;
//}
//
//@end
