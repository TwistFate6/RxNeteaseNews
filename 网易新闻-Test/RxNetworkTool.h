//
//  RxNetworkTool.h
//  网易新闻-Test
//
//  Created by RXL on 16/3/21.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface RxNetworkTool : AFHTTPSessionManager

+(instancetype)sharedNetworkTool;

@end
