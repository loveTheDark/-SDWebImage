//
//  CZAppInfoModel.h
//  异步下载图片
//
//  Created by 余伟康 on 16/6/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CZAppInfoModel : NSObject

@property(nonatomic,copy) NSString *name;

@property(nonatomic,copy) NSString *icon;

@property(nonatomic,copy) NSString *download;

@property(nonatomic,strong) UIImage *downloadIMG;

- (instancetype)initWithDich:(NSDictionary *)dict;

+ (instancetype)CZAppInfoModelWithDich:(NSDictionary *)dict;

@end
