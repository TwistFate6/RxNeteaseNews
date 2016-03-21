//
//  RxLoopView.m
//  网易新闻-Test
//
//  Created by RXL on 16/3/21.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import "RxLoopView.h"
#import "RxLoopViewFlowLayout.h"
#import "RxLoopViewCell.h"

@interface RxLoopView  ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *URLStrs;

@property (nonatomic, strong) NSArray *titles;

@end

@implementation RxLoopView

/**
 *  创建图片轮播期
 *
 *  @param URLStrs 图片URL数组
 *  @param titles  标题数组
 */
-(instancetype)initWithURLStr:(NSArray <NSString *> *)URLStrs titles:(NSArray <NSString *> *)titles{
    
    if (self=[super init]) {
    
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

#pragma mark - 添加子控件
-(void)setup{
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[RxLoopViewFlowLayout alloc]init]];
    
//    设置代理和数据源
    collectionView.delegate=self;
    collectionView.dataSource=self;
    
    [self addSubview:collectionView];
    self.collectionView=collectionView;
    
//    创建标题
    self.titleLabel=[[UILabel alloc]init];
    self.titleLabel.font=[UIFont systemFontOfSize:15];
    self.titleLabel.textColor=[UIColor blueColor];
    [self addSubview:self.titleLabel];
    
//    创建分页指示器
    self.pageControl=[[UIPageControl alloc]init];
    self.pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    self.pageControl.pageIndicatorTintColor=[UIColor grayColor];
//    当只有一页时,隐藏
    self.pageControl.hidesForSinglePage=YES;
    [self addSubview:self.pageControl];
}

-(void)layoutSubviews{
    
    CGFloat titleH=20;
    
    CGRect frame=self.bounds;
    frame.size.height-=titleH;
    
    self.collectionView.frame=frame;
    
    CGFloat marginX=10;
    
    CGFloat pageY=self.bounds.size.height-titleH;
    CGFloat pageW=self.URLStrs.count*15;
    CGFloat pageX=self.bounds.size.width-pageW-marginX;
    CGFloat pageH=titleH;
    self.pageControl.frame=CGRectMake(pageX, pageY, pageW, pageH);
    
//    设置标题的frame
    CGFloat titleW=self.bounds.size.width-3*marginX-pageW;
    self.titleLabel.frame=CGRectMake(marginX, pageY, titleW, titleH);
}

#pragma mark - UICollectionView 数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.URLStrs.count*((self.URLStrs.count==1)?1:100);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RxLoopViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"loopCell" forIndexPath:indexPath];
    
    cell.URLString=self.URLStrs[indexPath.item % self.URLStrs.count];
    
    return cell;
}

@end
