//
//  UIImage+ATCompress.h
//  HighwayDoctor
//
//  Created by Mars on 2019/5/21.
//  Copyright © 2019 Mars. All rights reserved.
//


//图片压缩
#import <UIKit/UIKit.h>


@interface UIImage (ATCompress)



/**
 1）宽高均大于1280，取较大值等于1280，较大值等比例压缩
 2）宽或高一个大于1280，取较大的等于1280，较小的等比压缩
 3）宽高均小于1280，压缩比例不变
 对于缩的处理，图片是不会失真的，只是变小而已。
 
 对于“压”的功能，使用的UIImageJPEGRepresentation或UIImagePNGRepresentation方法实现。
 这里我也分了三种关于图片画质的压缩
 1）图片大于1M的，将压缩系数调整到0.7
 2）图片在0.5M<image<1M,将压缩系数调整到0.8
 3）图片小雨0.5M，压缩系数可以写0.9或者1
 */
+(NSData *)at_zipNSDataWithImage:(UIImage *)sourceImage;

/**
 压缩图片到指定大小(单位KB)
 
 @param sourceImage 被压缩图片
 @param maxSize 最大内存
 @return 图片
 */
+ (NSData *)at_resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize;


/*!
 //图片质量压缩到某一范围内，如果后面用到多，可以抽成分类或者工具类,这里压缩递减比二分的运行时间长，二分可以限制下限。
 *  @brief 使图片压缩后刚好小于指定大小
 *  @param image 当前要压缩的图 maxLength 压缩后的大小
 *  @return 图片对象
 */
+ (UIImage *)at_compressImageSize:(UIImage *)image toByte:(NSUInteger)maxLength;



/**
 *  压缩上传图片到指定字节
 *
 *  @param image     压缩的图片
 *  @param maxLength 压缩后最大字节大小
 *
 *  @return 压缩后图片的二进制
 */
+ (NSData *)at_compressImage:(UIImage *)image toMaxLength:(NSInteger) maxLength maxWidth:(NSInteger)maxWidth;

/**
 *  获得指定size的图片
 *
 *  @param image   原始图片
 *  @param newSize 指定的size
 *
 *  @return 调整后的图片
 */
+ (UIImage *)at_resizeImage:(UIImage *) image withNewSize:(CGSize) newSize;

/**
 *  通过指定图片最长边，获得等比例的图片size
 *
 *  @param image       原始图片
 *  @param imageLength 图片允许的最长宽度（高度）
 *
 *  @return 获得等比例的size
 */
+ (CGSize)at_scaleImage:(UIImage *) image withLength:(CGFloat) imageLength;


+ (UIImage*)at_resizableHalfImage:(NSString *)name;

@end

