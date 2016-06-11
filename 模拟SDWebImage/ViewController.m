//
//  ViewController.m
//  模拟SDWebImage
//
//  Created by 余伟康 on 16/6/11.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "ViewController.h"
#import "CZAppInfoModel.h"
#import "UIImageView+webCache.h"

@interface ViewController ()

@property (nonatomic,strong)NSArray *dataArray;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

#pragma mark
#pragma mark - 懒加载

- (NSArray *)dataArray{
    if (nil == _dataArray) {
        
        // 读取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
        
        // 读取文件到临时数组
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
        
        // 创建可变数组
        NSMutableArray *mutable = [NSMutableArray array];
        
        // 字典转模型
        for (NSDictionary *dict in tempArray) {
            CZAppInfoModel *model = [CZAppInfoModel CZAppInfoModelWithDich:dict];
            
            // 添加到可变数组中
            [mutable addObject:model];
        }
        
        // 将可变数组复制给_dataArray
        _dataArray = mutable;
        
    }
    return _dataArray;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self displayIMG];
}


- (void)displayIMG{
    
    int number = arc4random_uniform((u_int32_t)self.dataArray.count);
    
    CZAppInfoModel *model = self.dataArray[number];
    
    [self.imageView downloadIMGWithAddr:model.icon];

}



@end







