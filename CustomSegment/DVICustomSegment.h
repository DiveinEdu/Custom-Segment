//
//  DVICustomSegment.h
//
//  Created by DiveInEdu on 10/10/12.
//  Copyright (c) 2012 wcrane. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DVICustomSegment;

@protocol DVICustomSegmentDelegate <NSObject>
@optional
- (void)customSegment:(DVICustomSegment *)segment didSelectIndex:(NSInteger)index;
@end

@interface DVICustomSegment : UIView
{
    NSArray *_segments;
    
    NSInteger   selectedIndex;
    
    id<DVICustomSegmentDelegate> delegate;
}
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) id<DVICustomSegmentDelegate> delegate;

- (id)initWithFrame:(CGRect)frame segments:(NSArray *)segments;
@end
