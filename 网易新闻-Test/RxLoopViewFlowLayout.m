//
//  RxLoopViewFlowLayout.m
//  网易新闻-Test
//
//  Created by RXL on 16/3/21.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import "RxLoopViewFlowLayout.h"

@implementation RxLoopViewFlowLayout


/**
 *  在调用该方法的时候,collectionView的尺寸已经确定
 */
-(void)prepareLayout{
    
    [super prepareLayout];
    
    self.itemSize=self.collectionView.bounds.size;
    self.minimumInteritemSpacing=0;
    self.minimumLineSpacing=0;
    
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.pagingEnabled=YES;
    self.collectionView.showsHorizontalScrollIndicator=NO;
    
}

@end
