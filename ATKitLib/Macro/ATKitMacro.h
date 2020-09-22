//
//  ATKitMacro.h
//  HighwayDoctor
//
//  Created by Mars on 2019/6/4.
//  Copyright © 2019 Mars. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <sys/time.h>
#import <pthread.h>

#ifndef ATKitMacro_h
#define ATKitMacro_h

//设备ID
#define DeviceID    [[UIDevice currentDevice].identifierForVendor UUIDString]

//格式化多个参数
#define  kFormatString(fmt, ...)    [NSString stringWithFormat:fmt,## __VA_ARGS__]


//CG_INLINE NSString* getCurrentTime(){
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];//AZ  @"yyyy-MM-dd HH:mm:ss.SSSZ"];//
//    NSDate *datenow = [NSDate date];
//    NSTimeInterval a = [datenow timeIntervalSince1970]*1000; // *1000 是精确到毫秒，不乘就是精确到秒
//    NSString *currentTimeString = [formatter stringFromDate:datenow];
//    currentTimeString = [NSString stringWithFormat:@"%@.%ld",currentTimeString,((long)a)%1000000];
//    return currentTimeString;
//}
//
////#ifdef DEBUG
////#define DebugLog(format, ...) NSLog(@"☣️ %@(%d行) %@",__PRETTY_FUNCTION__,__LINE__,[[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )//🌱🌱🌱
////#else
////#define DebugLog(...)
////#endif
//
//
//#ifdef DEBUG
//#define DebugLog(format, ...) printf("☣️ %s %s(%d行) %s\n",[getCurrentTime() UTF8String],__PRETTY_FUNCTION__,__LINE__,[[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )//🌱🌱🌱
//#else
//#define DebugLog(...)
//#endif




#ifdef __cplusplus
#define AT_EXTERN_C_BEGIN  extern "C" {
#define AT_EXTERN_C_END  }
#else
#define AT_EXTERN_C_BEGIN
#define AT_EXTERN_C_END
#endif

#define AtAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define ATSingletonH() +(instancetype)sharedInstance;
#define ATSingletonM() static id _instance;\
+ (instancetype)sharedInstance {\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}



#define ATObject(objectName) [[objectName alloc]init]


#define ATPropStatementAndPropSetFuncStatement(propertyModifier,className, propertyPointerType, propertyName)\
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;\
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;


#define ATPropSetFuncImplementation(className, propertyPointerType, propertyName)\
- (className * (^) (propertyPointerType propertyName))propertyName##Set{\
    return ^(propertyPointerType propertyName) {\
        self.propertyName = propertyName;\
        return self;\
    };\
}



/////////// ************* /////////////


AT_EXTERN_C_BEGIN

#ifndef AT_CLAMP // return the clamped value
#define AT_CLAMP(_x_, _low_, _high_)  (((_x_) > (_high_)) ? (_high_) : (((_x_) < (_low_)) ? (_low_) : (_x_)))
#endif

#ifndef AT_SWAP // swap two value
#define AT_SWAP(_a_, _b_)  do { __typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = _tmp_; } while (0)
#endif



/**
 Add this macro before each category implementation, so we don't have to use
 -all_load or -force_load to load object files from static libraries that only
 contain categories and no classes.
 More info: http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html .
 *******************************************************************************
 Example:
     ATSYNTH_DUMMY_CLASS(NSString_YYAdd)
 */
#ifndef ATSYNTH_DUMMY_CLASS
#define ATSYNTH_DUMMY_CLASS(_name_) \
@interface ATSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation ATSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif


/**
 Synthsize @implementation范围中的动态对象属性。
 它允许我们向类别中的现有类添加自定义属性。
 
 Synthsize a dynamic object property in @implementation scope.
 It allows us to add custom properties to existing classes in categories.
 
 @param association  ASSIGN / RETAIN / COPY / RETAIN_NONATOMIC / COPY_NONATOMIC
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
     @interface NSObject (MyAdd)
     @property (nonatomic, retain) UIColor *myColor;
     @end
     
     #import <objc/runtime.h>
     @implementation NSObject (MyAdd)
     ATSYNTH_DYNAMIC_PROPERTY_OBJECT(myColor, setMyColor, RETAIN, UIColor *)
     @end
 */
#ifndef ATSYNTH_DYNAMIC_PROPERTY_OBJECT
#define ATSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
    return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif


/**
 Synthsize @implementation作用域中的动态c类型属性。
 它允许我们向类别中的现有类添加自定义属性。
 
 Synthsize a dynamic c type property in @implementation scope.
 It allows us to add custom properties to existing classes in categories.
 
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
     @interface NSObject (MyAdd)
     @property (nonatomic, retain) CGPoint myPoint;
     @end
     
     #import <objc/runtime.h>
     @implementation NSObject (MyAdd)
     ATSYNTH_DYNAMIC_PROPERTY_CTYPE(myPoint, setMyPoint, CGPoint)
     @end
 */
#ifndef ATSYNTH_DYNAMIC_PROPERTY_CTYPE
#define ATSYNTH_DYNAMIC_PROPERTY_CTYPE(_getter_, _setter_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)]; \
    objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (type)_getter_ { \
    _type_ cValue = { 0 }; \
    NSValue *value = objc_getAssociatedObject(self, @selector(_setter_:)); \
    [value getValue:&cValue]; \
    return cValue; \
}
#endif



/**
 Same as CFAutorelease(), compatible for iOS6
 @param arg CFObject @return same as input
 */
static inline CFTypeRef ATCFAutorelease(CFTypeRef CF_RELEASES_ARGUMENT arg) {
    if (((long)CFAutorelease + 1) != 1) {
        return CFAutorelease(arg);
    } else {
        id __autoreleasing obj = CFBridgingRelease(arg);
        return (__bridge CFTypeRef)obj;
    }
}

/**
 Profile time cost.
 @param block     code to benchmark
 @param complete  code time cost (millisecond)
 
 Usage:
    ATBenchmark(^{
        // code
    }, ^(double ms) {
        NSLog("time cost: %.2f ms",ms);
    });
 
 */
static inline void ATBenchmark(void (^block)(void), void (^complete)(double ms)) {
    // <QuartzCore/QuartzCore.h> version
    /*
    extern double CACurrentMediaTime (void);
    double begin, end, ms;
    begin = CACurrentMediaTime();
    block();
    end = CACurrentMediaTime();
    ms = (end - begin) * 1000.0;
    complete(ms);
    */
    
    // <sys/time.h> version
    struct timeval t0, t1;
    gettimeofday(&t0, NULL);
    block();
    gettimeofday(&t1, NULL);
    double ms = (double)(t1.tv_sec - t0.tv_sec) * 1e3 + (double)(t1.tv_usec - t0.tv_usec) * 1e-3;
    complete(ms);
}



/**
 Returns a dispatch_time delay from now.
 */
static inline dispatch_time_t dispatch_time_delay(NSTimeInterval second) {
    return dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
}

/**
 Returns a dispatch_wall_time delay from now.
 */
static inline dispatch_time_t dispatch_walltime_delay(NSTimeInterval second) {
    return dispatch_walltime(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
}

/**
 Returns a dispatch_wall_time from NSDate.
 */
static inline dispatch_time_t dispatch_walltime_date(NSDate *date) {
    NSTimeInterval interval;
    double second, subsecond;
    struct timespec time;
    dispatch_time_t milestone;
    
    interval = [date timeIntervalSince1970];
    subsecond = modf(interval, &second);
    time.tv_sec = second;
    time.tv_nsec = subsecond * NSEC_PER_SEC;
    milestone = dispatch_walltime(&time, 0);
    return milestone;
}

/**
 Whether in main queue/thread.
 */
static inline bool dispatch_is_main_queue() {
    return pthread_main_np() != 0;
}

/**
 Submits a block for asynchronous execution on a main queue and returns immediately.
 */
static inline void dispatch_async_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

/**
 Submits a block for execution on a main queue and waits until the block completes.
 */
static inline void dispatch_sync_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

/**
 Initialize a pthread mutex.
 */
static inline void pthread_mutex_init_recursive(pthread_mutex_t *mutex, bool recursive) {
#define YYMUTEX_ASSERT_ON_ERROR(x_) do { \
__unused volatile int res = (x_); \
assert(res == 0); \
} while (0)
    assert(mutex != NULL);
    if (!recursive) {
        YYMUTEX_ASSERT_ON_ERROR(pthread_mutex_init(mutex, NULL));
    } else {
        pthread_mutexattr_t attr;
        YYMUTEX_ASSERT_ON_ERROR(pthread_mutexattr_init (&attr));
        YYMUTEX_ASSERT_ON_ERROR(pthread_mutexattr_settype (&attr, PTHREAD_MUTEX_RECURSIVE));
        YYMUTEX_ASSERT_ON_ERROR(pthread_mutex_init (mutex, &attr));
        YYMUTEX_ASSERT_ON_ERROR(pthread_mutexattr_destroy (&attr));
    }
#undef YYMUTEX_ASSERT_ON_ERROR
}


AT_EXTERN_C_END


#endif /* ATKitMacro_h */
