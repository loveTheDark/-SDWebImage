//
//  CZDownloadIMGManager.h
//  模拟SDWebImage
//
//  Created by 余伟康 on 16/6/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  向整个 app提供下载和取消下载的功能
 */

@interface CZDownloadIMGManager : NSObject

+ (instancetype)sharedManager;

- (void)downloadWithImageAddr:(NSString *)imgAddr finishBlock:(void(^)(UIImage *image))finishBlock;

- (void)cancelDownload:(NSString *)imgAddr;

@end
