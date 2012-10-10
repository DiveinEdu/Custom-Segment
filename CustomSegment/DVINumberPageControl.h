//
//  DVINumberPageControl.h
//
//  Created by DiveInEdu on 10/9/12.
//  Copyright (c) 2012 wcrane. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DVINumberPageControl;

@protocol DVINumberPageControlDelegate <NSObject>
@optional
- (void)pageControl:(DVINumberPageControl *)pageControl didSelectPage:(NSInteger)page;
@end

@interface DVINumberPageControl : UIView
{
    NSInteger  currentPage;
    NSInteger  numberOfPages;
    
    UIColor    *pageIndicatorTintColor;     //默认颜色
    UIColor    *currentPageIndicatorColor;  //选中颜色
    
    NSMutableArray  *_indicators;
    
    id<DVINumberPageControlDelegate> delegate;
}
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger numberOfPages;

@property (nonatomic, retain) UIColor   *pageIndicatorTintColor;
@property (nonatomic, retain) UIColor   *currentPageIndicatorColor;

@property (nonatomic, assign) id<DVINumberPageControlDelegate> delegate;
@end
