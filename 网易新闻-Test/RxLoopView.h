//
//  RxLoopView.h
//  网易新闻-Test
//
//  Created by RXL on 16/3/21.
//  Copyright © 2016年 RXL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RxLoopView : UIView


-(instancetype)initWithURLStr:(NSArray <NSString *> *)URLStrs titles:(NSArray <NSString *> *)titles selected:(void (^)(NSInteger index))didSelected;

/**
 *  时间间隔
 */
@property (nonatomic, assign) NSInteger timerInterval;



@end
