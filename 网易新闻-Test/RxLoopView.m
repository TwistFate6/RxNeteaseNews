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
#import "RxWeakTimerTarget.h"

@interface RxLoopView  ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *URLStrs;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy) void (^didSelected)(NSInteger index);


@end

@implementation RxLoopView

/**
 *  创建图片轮播期
 *
 *  @param URLStrs 图片URL数组
 *  @param titles  标题数组
 */
-(instancetype)initWithURLStr:(NSArray <NSString *> *)URLStrs titles:(NSArray <NSString *> *)titles selected:(void (^)(NSInteger index))didSelected{
    
    if (self=[super init]) {
        
        self.URLStrs=URLStrs;
        self.titles=titles;
        self.didSelected=didSelected;
        
        self.pageControl.numberOfPages=self.URLStrs.count;
        self.titleLabel.text=self.titles[0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if (URLStrs.count>1) {
                
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:URLStrs.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
                
//                添加定时器
                [self addTimer];
            }
        });
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
    
//    注册Cell
    [collectionView registerClass:[RxLoopViewCell class] forCellWithReuseIdentifier:@"loopCell"];
    
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
    
    self.timerInterval=2;
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
    
    return self.URLStrs.count*((self.URLStrs.count==1)?1:3);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RxLoopViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"loopCell" forIndexPath:indexPath];
    
    cell.URLString=self.URLStrs[indexPath.item % self.URLStrs.count];
    
    return cell;
}

#pragma mark - 监听Item的点击

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.didSelected(indexPath.item%self.URLStrs.count);
}

#pragma mark - UIScrollView的代理方法

/**
 *  手动拖拽才会触发
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    计算当前滚动的页号
    NSInteger page =scrollView.contentOffset.x/scrollView.bounds.size.width;
    
    if (page ==0 || page == ([self.collectionView numberOfItemsInSection:0]-1)) {
        
        page =self.URLStrs.count-((page==0)?0:1);
        
        self.collectionView.contentOffset = CGPointMake(page * scrollView.bounds.size.width, 0);
    }
    
    self.titleLabel.text=self.titles[page%self.URLStrs.count];
    self.pageControl.currentPage=page%self.URLStrs.count;
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
//    销毁时钟
    [self removeTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}

#pragma mark - 定时器
/**
 *  创建定时器
 */
-(void)addTimer{
    self.timer=[RxWeakTimerTarget scheduledTimerWithTimeInterval:self.timerInterval target:self selector:@selector(nextImg) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
/**
 *  销毁定时器
 */
-(void)removeTimer{
    
    [self.timer invalidate];
    self.timer=nil;
    
}
/**
 *  定时器回调方法
 */
-(void)nextImg{
    
    NSInteger page =self.collectionView.contentOffset.x/self.collectionView.bounds.size.width;
    
    CGFloat offsetX=(page+1) * self.collectionView.bounds.size.width;
    
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}
@end
