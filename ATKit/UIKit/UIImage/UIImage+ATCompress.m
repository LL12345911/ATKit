//
//  UIImage+ATCompress.m
//  HighwayDoctor
//
//  Created by Mars on 2019/5/21.
//  Copyright © 2019 Mars. All rights reserved.
//

#import "UIImage+ATCompress.h"
//#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import <Photos/Photos.h>
#import <CoreImage/CoreImage.h>
#import "ATKitMacro.h"

@implementation UIImage (ATCompress)

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
+(NSData *)at_zipNSDataWithImage:(UIImage *)sourceImage{
    @autoreleasepool {
        //进行图像尺寸的压缩
        CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
        CGFloat width = imageSize.width;    //图片宽度
        CGFloat height = imageSize.height;  //图片高度
        //1.宽高大于1280(宽高比不按照2来算，按照1来算)
        if (width>1280||height>1280) {
            if (width>height) {
                CGFloat scale = height/width;
                width = 1280;
                height = width*scale;
            }else{
                CGFloat scale = width/height;
                height = 1280;
                width = height*scale;
            }
            //2.宽大于1280高小于1280
        }else if(width>1280||height<1280){
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
            //3.宽小于1280高大于1280
        }else if(width<1280||height>1280){
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
            //4.宽高都小于1280
        }else{
        }
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        [sourceImage drawInRect:CGRectMake(0,0,width,height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //进行图像的画面质量压缩
        NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
        if (data.length>100*1024) {
            if (data.length>1024*1024) {//1M以及以上
                data=UIImageJPEGRepresentation(newImage, 0.7);
            }else if (data.length>512*1024) {//0.5M-1M
                data=UIImageJPEGRepresentation(newImage, 0.8);
            }else if (data.length>200*1024) {
                //0.25M-0.5M
                data=UIImageJPEGRepresentation(newImage, 0.9);
            }
        }
        return data;
        
    }
}

#pragma mark - 压缩图片到指定大小(单位KB)
+ (NSData *)at_resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize {
    @autoreleasepool {
        //先判断当前质量是否满足要求，不满足再进行压缩
        __block NSData *finallImageData = UIImageJPEGRepresentation(sourceImage,1.0);
        NSUInteger sizeOrigin   = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1000;
        
        if (sizeOriginKB <= maxSize) {
            DebugLog(@"最终降到的质量：%ld", (unsigned long)sizeOriginKB);
            return finallImageData;
        }
        
        //获取原图片宽高比
        CGFloat sourceImageAspectRatio = sourceImage.size.width/sourceImage.size.height;
        //先调整分辨率
        CGSize defaultSize = CGSizeMake(1024, 1024/sourceImageAspectRatio);
        UIImage *newImage = [self newSizeImage:defaultSize image:sourceImage];
        
        finallImageData = UIImageJPEGRepresentation(newImage,1.0);
        
        //保存压缩系数
        NSMutableArray *compressionQualityArr = [NSMutableArray array];
        CGFloat avg   = 1.0/250;
        CGFloat value = avg;
        for (int i = 250; i >= 1; i--) {
            @autoreleasepool {
                value = i*avg;
                [compressionQualityArr addObject:@(value)];
            }
        }
        
        /*
         调整大小
         说明：压缩系数数组compressionQualityArr是从大到小存储。
         */
        //思路：使用二分法搜索
        __block NSData *canCompressMinData = [NSData data];//当无法压缩到指定大小时，用于存储当前能够压缩到的最小值数据。
        [self halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize resultBlock:^(NSData *finallData, NSData *tempData) {
            finallImageData = finallData;
            canCompressMinData = tempData;
        }];
        //如果还是未能压缩到指定大小，则进行降分辨率
        while (finallImageData.length == 0) {
            @autoreleasepool {
                //每次降100分辨率
                CGFloat reduceWidth = 100.0;
                CGFloat reduceHeight = 100.0/sourceImageAspectRatio;
                if (defaultSize.width-reduceWidth <= 0 || defaultSize.height-reduceHeight <= 0) {
                    break;
                }
                defaultSize = CGSizeMake(defaultSize.width-reduceWidth, defaultSize.height-reduceHeight);
                UIImage *image = [self newSizeImage:defaultSize
                                              image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage,[[compressionQualityArr lastObject] floatValue])]];
                [self halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image,1.0) maxSize:maxSize resultBlock:^(NSData *finallData, NSData *tempData) {
                    finallImageData = finallData;
                    canCompressMinData = tempData;
                }];
            }
        }
        //如果分辨率已经无法再降低，则直接使用能够压缩的那个最小值即可
        if (finallImageData.length==0) {
            finallImageData = canCompressMinData;
        }
        DebugLog(@"最终降到的质量：%ld", (unsigned long)finallImageData.length/1000);
        return finallImageData;
    }
}
#pragma mark 调整图片分辨率/尺寸（等比例缩放）
///调整图片分辨率/尺寸（等比例缩放）
+ (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage {
    @autoreleasepool {
        CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
        
        CGFloat tempHeight = newSize.height / size.height;
        CGFloat tempWidth = newSize.width / size.width;
        
        if (tempWidth > 1.0 && tempWidth > tempHeight) {
            newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
        } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
            newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
        }
        
        //    UIGraphicsBeginImageContext(newSize);
        UIGraphicsBeginImageContextWithOptions(newSize, NO, 1);
        [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
}
#pragma mark 二分法
///二分法，block回调中finallData长度不为零表示最终压缩到了指定的大小，如果为零则表示压缩不到指定大小。tempData表示当前能够压缩到的最小值。
+ (void)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize resultBlock:(void(^)(NSData *finallData, NSData *tempData))block {
    @autoreleasepool {
        NSData *tempData = [NSData data];
        NSUInteger start = 0;
        NSUInteger end = arr.count - 1;
        NSUInteger index = 0;
        
        NSUInteger difference = NSIntegerMax;
        while(start <= end) {
            index = start + (end - start)/2;
            
            finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
            
            NSUInteger sizeOrigin = finallImageData.length;
            NSUInteger sizeOriginKB = sizeOrigin / 1000;
            NSLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB);
            //        NSLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf", start, end, (unsigned long)index, [arr[index] floatValue]);
            
            if (sizeOriginKB > maxSize) {
                start = index + 1;
            } else if (sizeOriginKB < maxSize) {
                if (maxSize-sizeOriginKB < difference) {
                    difference = maxSize-sizeOriginKB;
                    tempData = finallImageData;
                }
                if (index<=0) {
                    break;
                }
                end = index - 1;
            } else {
                break;
            }
        }
        NSData *d = [NSData data];
        if (tempData.length==0) {
            d = finallImageData;
        }
        if (block) {
            block(tempData, d);
        }
        //    return tempData;
    }
}



/*!
 *  @brief 使图片压缩后刚好小于指定大小
 *  @param image 当前要压缩的图 maxLength 压缩后的大小
 *  @return 图片对象
 */
//图片质量压缩到某一范围内，如果后面用到多，可以抽成分类或者工具类,这里压缩递减比二分的运行时间长，二分可以限制下限。
+ (UIImage *)at_compressImageSize:(UIImage *)image toByte:(NSUInteger)maxLength{
    @autoreleasepool {
        //首先判断原图大小是否在要求内，如果满足要求则不进行压缩，over
        CGFloat compression = 1;
        NSData *data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength) return image;
        //原图大小超过范围，先进行“压处理”，这里 压缩比 采用二分法进行处理，6次二分后的最小压缩比是0.015625，已经够小了
        CGFloat max = 1;
        CGFloat min = 0;
        for (int i = 0; i < 6; ++i) {
            @autoreleasepool {
                compression = (max + min) / 2;
                data = UIImageJPEGRepresentation(image, compression);
                if (data.length < maxLength * 0.9) {
                    min = compression;
                } else if (data.length > maxLength) {
                    max = compression;
                } else {
                    break;
                }
            }
        }
        //判断“压处理”的结果是否符合要求，符合要求就over
        UIImage *resultImage = [UIImage imageWithData:data];
        if (data.length < maxLength) return resultImage;
        
        //缩处理，直接用大小的比例作为缩处理的比例进行处理，因为有取整处理，所以一般是需要两次处理
        NSUInteger lastDataLength = 0;
        while (data.length > maxLength && data.length != lastDataLength) {
            @autoreleasepool {
                lastDataLength = data.length;
                //获取处理后的尺寸
                CGFloat ratio = (CGFloat)maxLength / data.length;
                CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                         (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
                //通过图片上下文进行处理图片
                UIGraphicsBeginImageContext(size);
                [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
                resultImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                //获取处理后图片的大小
                data = UIImageJPEGRepresentation(resultImage, compression);
            }
        }
        return resultImage;
    }
}






+ (UIImage*)at_resizableHalfImage:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    
    CGFloat imageW = normal.size.width * 0.5;
    CGFloat imageH = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(imageH, imageW, imageH, imageW)];
}


+ (NSData *)at_compressImage:(UIImage *)image toMaxLength:(NSInteger)maxLength maxWidth:(NSInteger)maxWidth{
    NSAssert(maxLength > 0, @"图片的大小必须大于 0");
    NSAssert(maxWidth > 0, @"图片的最大边长必须大于 0");
    
    CGSize newSize = [self at_scaleImage:image withLength:maxWidth];
    UIImage *newImage = [self at_resizeImage:image withNewSize:newSize];
    
    CGFloat compress = 0.9f;
    NSData *data = UIImageJPEGRepresentation(newImage, compress);
    
    while (data.length > maxLength && compress > 0.01) {
        compress -= 0.02f;
        
        data = UIImageJPEGRepresentation(newImage, compress);
         DebugLog(@"图片压缩为%ld",data.length/1000);
    }
     DebugLog(@"图片最终大小%ld",data.length/1000);
    return data;
}

+ (UIImage *)at_resizeImage:(UIImage *) image withNewSize:(CGSize) newSize{
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (CGSize)at_scaleImage:(UIImage *) image withLength:(CGFloat) imageLength{
    
    CGFloat newWidth = 0.0f;
    CGFloat newHeight = 0.0f;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    if (width > imageLength || height > imageLength){
        
        if (width > height) {
            
            newWidth = imageLength;
            newHeight = newWidth * height / width;
            
        }else if(height > width){
            
            newHeight = imageLength;
            newWidth = newHeight * width / height;
            
        }else{
            
            newWidth = imageLength;
            newHeight = imageLength;
        }
        
    }else{
        return CGSizeMake(width, height);
    }
    
    return CGSizeMake(newWidth, newHeight);
}

@end
