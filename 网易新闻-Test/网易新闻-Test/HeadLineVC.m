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
#import "RxLoopView.h"

@interface HeadLineVC ()

@end

@implementation HeadLineVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [RxHeadLineModel loadHeadLineSuccess:^(NSArray *headLines) {
      
//        创建图片轮播期
        RxLoopView *loopView=[RxLoopView initWithURLStr:[headLines valueForKeyPath:@"imgsrc"] titles:[headLines valueForKeyPath:@"title"]];
        
//        设置frame
        loopView.frame=self.view.bounds;
        
        [self.view addSubview:loopView];
        
        
    } failed:^(NSError *error) {
        NSLog(@"数据加载错误");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
