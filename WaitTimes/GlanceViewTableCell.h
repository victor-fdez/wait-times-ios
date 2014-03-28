//
//  GlanceViewTableCell.h
//  WaitTimes
//
//  Created by Guillermo Vargas on 3/27/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKRevealController.h"

@interface GlanceViewTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *glanceViewBridgeTitle;
@property (weak, nonatomic) IBOutlet UILabel *glanceViewWaitTimeNumber;
@property (weak, nonatomic) IBOutlet UILabel *glanceViewWaitTimeDescription;
@property (weak, nonatomic) IBOutlet UIImageView *glanceViewFromDirectionFlagIndicator;
@property (weak, nonatomic) IBOutlet UIImageView *glanceViewToDirectionFlagIndicator;



@end
