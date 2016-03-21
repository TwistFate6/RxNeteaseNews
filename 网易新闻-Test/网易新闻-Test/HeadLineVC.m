//
//  ViewController.m
//  网易新闻-Test
//
//  Created by RXL on 16/3/21.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import "HeadLineVC.h"
#import "RxNetworkTool.h"
#import "RxHeadLineModel.h"

@interface HeadLineVC ()

@end

@implementation HeadLineVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [RxHeadLineModel loadHeadLineSuccess:^(NSArray *headLines) {
        
        
        
    } failed:^(NSError *error) {
        NSLog(@"数据加载错误");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
