//
//  UIImageView+WebCache.m
//  模拟SDWebImage
//
//  Created by 余伟康 on 16/6/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import <objc/runtime.h>
#import "CZDownloadIMGManager.h"

const char *KEY = "key";

@implementation UIImageView (WebCache)

- (NSString *)currentIMGAddr{

    return objc_getAssociatedObject(self, KEY);
}

- (void)setCurrentIMGAddr:(NSString *)currentIMGAddr{

    objc_setAssociatedObject(self, KEY, currentIMGAddr, OBJC_ASSOCIATION_COPY_NONATOMIC);

}

-(void)downloadIMGWithAddr:(NSString *)addr{
    
    // 判断之前是否点击 点击时取消之前的操作,加强用户体验
    if (![self.currentIMGAddr isEqualToString:addr]) {
        NSLog(@"取消之前的操作");
        [[CZDownloadIMGManager sharedManager] cancelDownload:self.currentIMGAddr];
    }
    self.currentIMGAddr = addr;
    
    
    [[CZDownloadIMGManager sharedManager] downloadWithImageAddr:addr finishBlock:^(UIImage *image) {
        // 图片下载后
        NSLog(@"图片在完毕后进行赋值");
        self.image = image;
    }];

}


@end
