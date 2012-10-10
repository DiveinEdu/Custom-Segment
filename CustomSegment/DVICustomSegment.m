//
//  DVICustomSegment.m
//
//  Created by DiveInEdu on 10/10/12.
//  Copyright (c) 2012 wcrane. All rights reserved.
//

#import "DVICustomSegment.h"

#import "DVISegementItem.h"

#define kDVICustomSegmentBaseTag 9000

@implementation DVICustomSegment

@synthesize selectedIndex;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame segments:(NSArray *)segments
{
    self = [super initWithFrame:frame];
    if (self) {
        _segments = [[NSArray alloc] initWithArray:segments];
        
        CGRect  rect = self.frame;
        CGFloat width = rect.size.width / [segments count];
        CGFloat centerX = width / 2;
        CGFloat centerY = rect.size.height / 2;
        
        for (NSInteger index = 0; index < [segments count]; index++) {
            XGSegementItem *tmpView = [segments objectAtIndex:index];
            
            [tmpView addTarget:self action:@selector(_didTouchSegment:) forControlEvents:UIControlEventTouchUpInside];
            
            if (index == selectedIndex) {
                tmpView.selected = YES;
            }else{
                tmpView.selected = NO;
            }
            
            tmpView.tag = kXGCustomSegmentBaseTag + index;
            tmpView.center = CGPointMake(centerX, centerY);
            [self addSubview:tmpView];
            
            centerX += width;
        }
    }
    return self;
}

- (void)_didTouchSegment:(id)sender
{
    DVISegementItem *oldView = [_segments objectAtIndex:selectedIndex];
    oldView.selected = NO;
    
    DVISegementItem *newView = (DVISegementItem *)sender;
    newView.selected = YES;
    
    selectedIndex = newView.tag - kDVICustomSegmentBaseTag;
    
    if (delegate && [delegate respondsToSelector:@selector(customSegment:didSelectIndex:)]) {
        [delegate customSegment:self didSelectIndex:selectedIndex];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_segments release];
    _segments = nil;
    
    [super dealloc];
}
@end
