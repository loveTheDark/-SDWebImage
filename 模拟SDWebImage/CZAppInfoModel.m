//
//  CZAppInfoModel.m
//  异步下载图片
//
//  Created by 余伟康 on 16/6/10.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CZAppInfoModel.h"

@implementation CZAppInfoModel

- (instancetype)initWithDich:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)CZAppInfoModelWithDich:(NSDictionary *)dict
{
    return [[self alloc]initWithDich:dict];
}


@end
