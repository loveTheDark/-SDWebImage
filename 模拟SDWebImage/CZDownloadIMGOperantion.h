//
//  CZDownloadIMGOperantion.h
//  模拟SDWebImage
//
//  Created by 余伟康 on 16/6/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CZDownloadIMGOperantion : NSOperation

//图片下载地址
@property(nonatomic,copy) NSString *imgAddr;

//block-传递图片
@property(nonatomic,copy) void(^finishBlock)(UIImage *image);

+(instancetype)operationWithAddr:(NSString *)imgAddr finishBlock:(void(^)(UIImage *image))finishBlock;

@end
