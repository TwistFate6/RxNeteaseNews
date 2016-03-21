//
//  RxHeadLineModel.m
//  网易新闻-Test
//
//  Created by RXL on 16/3/21.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import "RxHeadLineModel.h"
#import "RxNetworkTool.h"

@implementation RxHeadLineModel

+ (instancetype)HeadlineWithDict:(NSDictionary *)dict{
    
    id obj=[[self alloc]init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

+(void)loadHeadLineSuccess:(void (^)(NSArray *))sucess failed:(void (^)(NSError *error))falied{
    
    NSAssert(sucess != nil, @"必须传入完成回调");
    
    [[RxNetworkTool sharedNetworkTool] GET:@"ad/headline/0-4.html" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        NSString *rootKey=responseObject.keyEnumerator.nextObject;
        
//        获取数组
        NSArray *headLines=responseObject[rootKey];
        
//        创建一个可变数组->存放模型
        NSMutableArray *modelArr=[NSMutableArray arrayWithCapacity:headLines.count];
        
//        遍历数组
        [headLines enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            RxHeadLineModel *headline=[RxHeadLineModel HeadlineWithDict:obj];
            
            [modelArr addObject:headline];
            
        }];
        
//        完成回调
        sucess(modelArr.copy);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (falied) {
//            失败回调
            falied(error);
        }
        
    }];
    
    
}
// 如果找不到对应的属性和字典的key匹配，则系统会在该方法中抛出异常。只要重写了该方法，就是覆盖了系统默认的做法。不能重写父类方法
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
