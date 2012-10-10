//
//  DVISegementItem.m
//
//  Created by DiveInEdu on 10/10/12.
//  Copyright (c) 2012 wcrane. All rights reserved.
//

#import "DVISegementItem.h"

@implementation DVISegementItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
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

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected) {
        self.backgroundColor = [UIColor redColor];
    }else {
        self.backgroundColor = [UIColor grayColor];
    }
}
@end
