//
//  CLLocation+ATKit.h
//  HighwayDoctor
//
//  Created by Mars on 2019/6/13.
//  Copyright © 2019 Mars. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CLLocation (ATKit)

/**地球坐标转火星坐标*/
- (CLLocation*)locationMarsFromEarth;

/**火星坐标转百度坐标*/
- (CLLocation*)locationBearPawFromMars;

/**百度坐标转火星坐标*/
- (CLLocation*)locationMarsFromBearPaw;

@end

NS_ASSUME_NONNULL_END
