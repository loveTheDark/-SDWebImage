//
//  CZDownloadIMGManager.m
//  模拟SDWebImage
//
//  Created by 余伟康 on 16/6/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CZDownloadIMGManager.h"
#import "CZDownloadIMGOperantion.h"
#import "NSString+Path.h"

@interface CZDownloadIMGManager()

// 操作缓存
@property (nonatomic,strong) NSMutableDictionary *operationCache;

// 队列
@property (nonatomic,strong) NSOperationQueue *queue;

// 内存缓存
@property (nonatomic,strong) NSMutableDictionary *imageCache;

@end

@implementation CZDownloadIMGManager

#pragma mark
#pragma mark - 懒加载

- (NSMutableDictionary *)operationCache{

    if (!_operationCache) {
        _operationCache = [NSMutableDictionary dictionary];
    }
    return _operationCache;
}

- (NSOperationQueue *)queue{

    if (!_queue) {
        _queue = [[NSOperationQueue alloc]init];
    }
    return _queue;
}

- (NSMutableDictionary *)imageCache{

    if (!_imageCache) {
        _imageCache = [NSMutableDictionary dictionary];
    }
    return _imageCache;
}

// 单例模式
+ (instancetype)sharedManager{

    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        instance = [[self alloc] init];
    });
    return instance;
}

// 下载图片功能
- (void)downloadWithImageAddr:(NSString *)imgAddr finishBlock:(void (^)(UIImage *))finishBlock{

    //----------- 优先从内存 沙盒中读取图片 节省流量 ------------//
    
    // 内存缓存
    UIImage *imgCache = self.imageCache[imgAddr];
    if (imgCache) {
        NSLog(@"内存缓存");
        finishBlock(imgCache);
        return;
    }else{
        // 沙盒缓存
        UIImage *sandBoxImage = [UIImage imageWithContentsOfFile:[imgAddr appendCachePath]];
        if (sandBoxImage) {
            NSLog(@"沙盒缓存");
            finishBlock(sandBoxImage);
            // 性能优化
            [self.imageCache setObject:sandBoxImage forKey:imgAddr];
            return;
        }
        
    }
    
    //------------- 开启下载操作--------------//
    NSLog(@"启动下载操作");
    CZDownloadIMGOperantion *downloadIMGOperation = [CZDownloadIMGOperantion operationWithAddr:imgAddr finishBlock:^(UIImage *image) {

        finishBlock(image);
        
        // 删除操作缓存
        [self.operationCache removeObjectForKey:imgAddr];
        
        // 添加到内存缓存
        [self.imageCache setObject:image forKey:imgAddr];
    }];
    
    // 把操作加入队列中
    [self.queue addOperation:downloadIMGOperation];
    
    // 把操作加入操作缓存中
    [self.operationCache setObject:downloadIMGOperation forKey:imgAddr];
    
}

- (void)cancelDownload:(NSString *)imgAddr{
    
    CZDownloadIMGOperantion *op = self.operationCache[imgAddr];
    
    [op cancel];

}




@end
