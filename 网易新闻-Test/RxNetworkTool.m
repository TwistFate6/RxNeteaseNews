//
//  RxNetworkTool.m
//  网易新闻-Test
//
//  Created by RXL on 16/3/21.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import "RxNetworkTool.h"

@implementation RxNetworkTool

+(instancetype)sharedNetworkTool{
    
    static id instance=nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *url=[NSURL URLWithString:@"http://c.m.163.com/nc/"];
        
        instance=[[self alloc]initWithBaseURL:url];
    });
    return instance;
}

@end
