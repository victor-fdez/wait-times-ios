//
//  ForgotPasswordViewController.h
//  WaitTimes
//
//  Created by Guillermo Vargas on 4/10/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)resetPasswordAction:(id)sender;

@end
