//
//  UIImage+CKExtension.m
//  YUME
//
//  Created by Chenjy on 15/8/21.
//  Copyright (c) 2015年 Vieach_Ckiney. All rights reserved.
//

#import "UIImage+CKExtension.h"

#import <AVFoundation/AVFoundation.h>

void preoviderReleaseData(void *info, const void *data, size_t size)
{
    free((void *)data);
}

@implementation UIImage (CKExtension)
//按固定的width等比例缩放（UIImage),返回CGSize
+ (CGSize)sizeWithImage:(UIImage *)sourceImage scaledToWidth:(float)width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    CGSize size = CGSizeMake(newWidth, newHeight);
    return size;
}
//按固定的i_height等比例缩放（UIImage）,返回CGSize
+ (CGSize)sizeWithHeightImage:(UIImage *)sourceImage scaledToWidth:(float)height
{
    float oldHeight = sourceImage.size.height;
    float scaleFactor = height / oldHeight;
    
    float newWight = sourceImage.size.width * scaleFactor;
    float newHeight = oldHeight * scaleFactor;
    
    CGSize size = CGSizeMake(newWight, newHeight);
    return size;
}
//按固定的width等比例缩放（sourceSize）
+ (CGSize)sizeWithSize:(CGSize)sourceSize scaledToWidth:(float)width
{
    float oldWidth = sourceSize.width;
    float scaleFactor = width / oldWidth;
    float newHeight = sourceSize.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    CGSize size = CGSizeMake(newWidth, newHeight);
    return size;
}
//按固定的height等比例缩放（sourceSize）
+ (CGSize)sizeWithHeightSize:(CGSize)sourceSize scaledToHeight:(float)height
{
    float oldHeight = sourceSize.height;
    float scaleFactor = height / oldHeight;
    float newWidth = sourceSize.width * scaleFactor;
    float newHeight = oldHeight * scaleFactor;
    CGSize size = CGSizeMake(newWidth,newHeight);
    return size;
}
//按固定的width等比例缩放（UIImage）, 返回图片
+ (UIImage *)imageWithImage:(UIImage *)sourceImage scaledToWidth:(float)width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth - 2, newHeight - 2));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//图片中间等比例 拉伸
+ (UIImage *)middleStretchableImageWithKey:(NSString *)key;
{
    UIImage *image = [UIImage imageNamed:key];
    return [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    CGContextRotateCTM(bitmap, M_PI);
    CGContextScaleCTM(bitmap, -1.0, 1.0);
    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (instancetype)resizableWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
}

// 通过URl获取一张图片
+ (UIImage *)getImage:(NSURL *)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}

#pragma mark ---> 多张图片合成一张
+ (UIImage *)createLongExposure:(NSArray *)images
{
    UIImage *firstImg = images[0];
    CGSize imgSize = firstImg.size;
    CGFloat alpha = 1.0 / images.count;
    
    UIGraphicsBeginImageContext(imgSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, imgSize.width, imgSize.height));
    
    for (UIImage *image in images) {
        [image drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)
                blendMode:kCGBlendModePlusLighter alpha:alpha];
    }
    UIImage *longExpImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return longExpImg;
}

+ (UIImage *)clipYuanXingImg:(UIImage *)image
{
    CGSize size = image.size;
    
    //开启位图上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    //创建圆形路径
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    //设置为裁剪区域
    [path addClip];
    
    //绘制图片
    [image drawAtPoint:CGPointZero];
    
    //获取裁剪后的图片
    UIImage *mImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return mImage;
}

+ (UIImage *)logoErWeiCode:(NSString *)source logoImage:(NSString *)logoName
{
    // 1.生成清晰的二维码图片
    UIImage *imgQRCode = [UIImage createQRCodeImage:source];
    
    // 2.设置二维码的颜色 (默认是黑色)
    imgQRCode = [UIImage specialColorImage:imgQRCode color:JYMainColor];
    
    // 1.生成一张圆角logo图片
    UIImage *logoImg = [UIImage imageRoundeImage:[UIImage imageNamed:logoName] rounde:20.0];
    
    UIImage *marginImg = [UIImage imageAddColorBorder:logoImg color:[UIColor whiteColor] margin:10.0];
    
    UIImage *logo = [UIImage imageRoundeImage:marginImg rounde:20.0];
    
    // 4.合成一张有logo图标的二维码
    
    return [UIImage addIconToQRCodeImage:imgQRCode icon:logo];
}

/**
 使用iOS 7后的CIFilter对象操作，生成二维码图片imgQRCode（会拉伸图片，比较模糊，效果不佳, 使用核心绘图框架CG（Core Graphics）对象操作，进一步针对大小生成二维码图片imgAdaptiveQRCode（图片大小适合，清晰，效果好）
 source:二维码中的数据可以是字符串和URL两种类型, 如果我们想要生成URL的二维码, 只需要把字符串替换为一个URL字符串即可
 rate: 越大，越清晰(未提供接口，默认50.0)
 */
+ (UIImage *)createQRCodeImage:(NSString *)source
{
    // 1. 给滤镜添加数据
    NSData *data = [source dataUsingEncoding:NSUTF8StringEncoding];
    
    // 2. 创建一个二维码滤镜实例(CIFilter)
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    // 3.生成一张清晰度不高的二维码
    UIImage *image = [UIImage imageWithCIImage:filter.outputImage
                                         scale:1.0
                                   orientation:UIImageOrientationUp];
    
    // 4.对图片做处理, 使图片大小合适，清晰，效果好
    CGFloat width = image.size.width * 50.0;
    CGFloat height = image.size.height * 50.0;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *needImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  needImg;
}

/**
 默认产生的黑白色的二维码图片；我们可以让它产生其它颜色的二维码图片，例如：蓝白色的二维码图片
 color: 设置二维码的颜色
 */
+ (UIImage *)specialColorImage:(UIImage *)image color:(UIColor *)color
{
    CGFloat components[3];
    [UIImage getRGBComponents:components forColor:color];
    
    const CGFloat imageW = image.size.width;
    const CGFloat imageH = image.size.height;
    
    size_t bytesPerRow = imageW * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow *imageH);
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef contextRef = CGBitmapContextCreate(rgbImageBuf, imageW, imageH, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, imageW, imageH), image.CGImage);
    CGFloat pixelNum = imageW * imageH;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i ++, pCurPtr ++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[3] = components[0];
            ptr[2] = components[1];
            ptr[1] = components[2];
        } else {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
    
    CGDataProviderRef dataProviderRef = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageH, preoviderReleaseData);
    
    CGImageRef imageRef = CGImageCreate(imageW, imageH, 8, 32, bytesPerRow, colorSpaceRef, kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProviderRef, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProviderRef);
    
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    
    CGImageRelease(imageRef);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    
    return img;
}

/**
 两张图片合成一张
 image: 二维码
 icon: 中间Logo图标
 */
+ (UIImage *)addIconToQRCodeImage:(UIImage *)image icon:(UIImage *)icon
{
    UIGraphicsBeginImageContext(image.size);
    
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    CGFloat iconW = imageW * 0.25;
    CGFloat iconH = imageH * 0.25;
    
    [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
    [icon drawInRect:CGRectMake((imageW - iconW) * 0.5, (imageH - iconH) * 0.5, iconW, iconH)];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

/** 图片设置成圆角
 rounde: 设置圆角大小
 */
+ (UIImage *)imageRoundeImage:(UIImage *)image rounde:(CGFloat)rounde
{
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 1.0);
    
    [UIBezierPath bezierPathWithRect:rect];
    [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height) cornerRadius:rounde] addClip];
    
    [image drawInRect:rect];
    
    UIImage *needImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return needImg;
}

/** 获取UIColor的RGB */
+ (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 rgbColorSpace,
                                                 (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component];
    }
}

/** 给图片添加不同颜色的边框
 color: 外边框颜色
 margin: 外边框大小
 */
+ (UIImage *)imageAddColorBorder:(UIImage *)image color:(UIColor *)color margin:(CGFloat)margin
{
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    CGFloat colorW = imageW + margin * 2;
    CGFloat colorH = imageH + margin * 2;
    
    UIImage *colorImg = [UIImage imageWithColor:color size:CGSizeMake(colorW, colorH)];
    
    UIGraphicsBeginImageContext(colorImg.size);
    
    [colorImg drawInRect:CGRectMake(0, 0, colorW, colorH)];
    [image drawInRect:CGRectMake(margin, margin, imageW, imageH)];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

/** 用颜色来转换成一张图片 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)imageByCopingImgae:(UIImage *)image
{
//    CGRectrect;
}

@end
