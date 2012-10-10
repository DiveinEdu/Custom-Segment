//
//  DVINumberPageControl.m
//
//  Created by DiveInEdu on 10/9/12.
//  Copyright (c) 2012 wcrane. All rights reserved.
//

#import "DVINumberPageControl.h"

#define kBaseIndicatorTag   9000

#define kCurrentIndicatorWidth  20
#define kCurrentIndicatorHeight 16
#define kPageIndicatorWidth     20
#define kPageIndicatorHeight    16

@implementation DVINumberPageControl

@synthesize currentPage;
@synthesize numberOfPages;

@synthesize pageIndicatorTintColor;
@synthesize currentPageIndicatorColor;

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        currentPage = 0;
        numberOfPages = 0;
        
        self.pageIndicatorTintColor = [UIColor grayColor];
        self.currentPageIndicatorColor = [UIColor redColor];
        
        _indicators = [[NSMutableArray alloc] initWithCapacity:numberOfPages];
        
        delegate = nil;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)updateDots
{
    for (NSInteger index = 0; index < numberOfPages; index++) {
        UIButton *btn = [_indicators objectAtIndex:index];
        if (index == currentPage) {
            btn.frame = CGRectMake(0, 0, kCurrentIndicatorWidth, kCurrentIndicatorHeight);
            btn.backgroundColor = currentPageIndicatorColor;
        }else {
            btn.frame = CGRectMake(0, 0, kPageIndicatorWidth, kPageIndicatorHeight);
            btn.backgroundColor = pageIndicatorTintColor;
        }
    }
}

- (void)setCurrentPage:(NSInteger)page
{
    currentPage = page;
    
    [self updateDots];
}

- (void)setNumberOfPages:(NSInteger)num
{
    numberOfPages = num;
    
    if (currentPage > num) {
        currentPage = num -1;
    }
    
    if ([_indicators count] != 0) {
        for (UIView *subview in [self subviews]) {
            [subview removeFromSuperview];
        }
        
        [_indicators removeAllObjects];
    }

    CGRect  rect = self.frame;
    CGFloat width = rect.size.width / numberOfPages;
    CGFloat centerX = width / 2;
    CGFloat centerY = rect.size.height / 2;
    for (NSInteger index = 0; index < numberOfPages; index++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(_selectPage:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = kBaseIndicatorTag + index;
        
        btn.titleEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:[NSString stringWithFormat:@"%d", index] forState:UIControlStateNormal];
        
        if (index == currentPage) {
            btn.frame = CGRectMake(0, 0, kCurrentIndicatorWidth, kCurrentIndicatorHeight);
            btn.backgroundColor = currentPageIndicatorColor;
        }else {
            btn.frame = CGRectMake(0, 0, kPageIndicatorWidth, kPageIndicatorHeight);
            btn.backgroundColor = pageIndicatorTintColor;
        }
        
        btn.center = CGPointMake(centerX, centerY);
        [self addSubview:btn];
        [_indicators addObject:btn];
        
        centerX += width;
    }
}

- (void)setPageIndicatorTintColor:(UIColor *)tintColor
{
    [pageIndicatorTintColor release];
    pageIndicatorTintColor = [tintColor retain];
    
    [self updateDots];
}

- (void)setCurrentPageIndicatorColor:(UIColor *)color
{
    [currentPageIndicatorColor release];
    currentPageIndicatorColor = [color retain];
    
    [self updateDots];
}

- (void)_selectPage:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    UIButton *oldBtn = [_indicators objectAtIndex:currentPage];
    oldBtn.bounds = CGRectMake(0, 0, kPageIndicatorWidth, kPageIndicatorHeight);
    oldBtn.backgroundColor = pageIndicatorTintColor;
    
    currentPage = btn.tag - kBaseIndicatorTag;
    btn.bounds = CGRectMake(0, 0, kCurrentIndicatorWidth, kCurrentIndicatorHeight);
    btn.backgroundColor = currentPageIndicatorColor;
    
    if (delegate && [delegate respondsToSelector:@selector(pageControl:didSelectPage:)]) {
        [delegate pageControl:self didSelectPage:currentPage];
    }
}

- (void)dealloc
{
    [_indicators release];
    _indicators = nil;
    
    [pageIndicatorTintColor release];
    pageIndicatorTintColor = nil;
    
    [currentPageIndicatorColor release];
    currentPageIndicatorColor = nil;
    
    delegate = nil;
    
    [super dealloc];
}

@end
