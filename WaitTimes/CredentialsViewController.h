//
//  CredentialsViewController.h
//  WaitTimes
//
//  Created by Guillermo Vargas on 3/28/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import <MediaPlayer/MediaPlayer.h>

@interface CredentialsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *appTitleAtLoginScreen;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) NSArray *permissions;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;


- (IBAction)createAccountActionWithNormalCredentials:(id)sender;
- (IBAction)loginActionWithNormalCredentials:(id)sender;
- (IBAction)loginActionWithTwitterCredentials:(id)sender;
- (IBAction)loginActionWithFacebookCredentials:(id)sender;


- (IBAction)userNameReturnPress:(id)sender;
- (IBAction)passwordReturnPress:(id)sender;

#pragma mark - Forgotten Password Actions from the Login Screen

- (IBAction)forgotPasswordActionFromLogin:(id)sender;


@end
