//
//  RxLoopViewCell.m
//  网易新闻-Test
//
//  Created by RXL on 16/3/21.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import "RxLoopViewCell.h"
#import <UIImageView+WebCache.h>

@interface RxLoopViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation RxLoopViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        self.iconView=[[UIImageView alloc]init];
        [self addSubview:self.iconView];
        
    }
    
    return self;
}

-(void)setURLString:(NSString *)URLString{
    
    _URLString=URLString;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:URLString]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.iconView.frame=self.bounds;
    
}

@end
