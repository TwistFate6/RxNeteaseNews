//
//  RxHeadLineModel.h
//  网易新闻-Test
//
//  Created by RXL on 16/3/21.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RxHeadLineModel : NSObject
/**
 *  图片
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)HeadlineWithDict:(NSDictionary *)dict;
/**
 *  数据的加载
 *
 *  @param sucess 数据加载完成之后执行的代码
 *  @param falied 失败回调
 */
+(void)loadHeadLineSuccess:(void(^)(NSArray *headLines))sucess failed:(void(^)(NSError *error))falied;
@end
