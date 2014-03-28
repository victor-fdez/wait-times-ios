//
//  GlanceViewTableCell.m
//  WaitTimes
//
//  Created by Guillermo Vargas on 3/27/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import "GlanceViewTableCell.h"

@implementation GlanceViewTableCell
@synthesize glanceViewBridgeTitle = _glanceViewBridgeTitle;
@synthesize glanceViewWaitTimeNumber = _glanceViewWaitTimeNumber;
@synthesize glanceViewWaitTimeDescription = _glanceViewWaitTimeDescription;
@synthesize glanceViewToDirectionFlagIndicator = _glanceViewToDirectionFlagIndicator;
@synthesize glanceViewFromDirectionFlagIndicator = _glanceViewFromDirectionFlagIndicator;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    _glanceViewBridgeTitle.font = [UIFont fontWithName:@"OpenSans-Light" size:27];
    self.glanceViewWaitTimeNumber.font = [UIFont fontWithName:@"OpenSans-Light" size:12];
    self.glanceViewWaitTimeDescription.font = [UIFont fontWithName:@"OpenSans-Light" size:12];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
