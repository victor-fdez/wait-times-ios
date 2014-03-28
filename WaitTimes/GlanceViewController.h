//
//  GlanceViewController.h
//  WaitTimes
//
//  Created by Guillermo Vargas on 3/27/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface GlanceViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *email;

- (IBAction)addItemToGlanceView:(id)sender;
@end
