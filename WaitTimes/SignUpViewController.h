//
//  SignUpViewController.h
//  WaitTimes
//
//  Created by Guillermo Vargas on 3/28/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

@property (weak, nonatomic) IBOutlet UILabel *signUpTitleLabel;

- (IBAction)signUpActionWithNormalCredentials:(id)sender;
//- (IBAction)forgotMyPasswordButton:(id)sender;
- (IBAction)goBackToLoginAction:(id)sender;

#pragma mark - Forgotten Password Actions from the Login Screen

- (IBAction)forgotPasswordActionFromSignUpView:(id)sender;

@end
