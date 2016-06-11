//
//  CZDownloadIMGOperantion.m
//  模拟SDWebImage
//
//  Created by 余伟康 on 16/6/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CZDownloadIMGOperantion.h"
#import "NSString+Path.h"

@implementation CZDownloadIMGOperantion

+ (instancetype)operationWithAddr:(NSString *)imgAddr finishBlock:(void (^)(UIImage *))finishBlock{

    CZDownloadIMGOperantion *op = [[CZDownloadIMGOperantion alloc]init];
    
    op.imgAddr = imgAddr;
    op.finishBlock = finishBlock;
    
    return op;
}

- (void)main{

    NSLog(@"下载中...");
    
//    [NSThread sleepForTimeInterval:1];
    
    NSURL *url = [NSURL URLWithString:self.imgAddr];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    [data writeToFile:[self.imgAddr appendCachePath] atomically:YES];
    
    if ([self isCancelled]) {
        NSLog(@"取消操作");
        return;
    }
    
    UIImage *image = [UIImage imageWithData:data];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        if (self.finishBlock) {
            self.finishBlock(image);
        }   
    }];

}


@end
