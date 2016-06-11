//
//  UIImageView+WebCache.h
//  模拟SDWebImage
//
//  Created by 余伟康 on 16/6/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebCache)

@property (nonatomic,copy) NSString *currentIMGAddr;

// 下载图片
- (void)downloadIMGWithAddr:(NSString *)addr;

@end
