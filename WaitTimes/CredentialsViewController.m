//
//  CredentialsViewController.m
//  WaitTimes
//
//  Created by Guillermo Vargas on 3/28/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import "CredentialsViewController.h"

@interface CredentialsViewController ()

@end

@implementation CredentialsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    #pragma mark - Visual Setup of Login/Signup screen
    self.appTitleAtLoginScreen.font = [UIFont fontWithName:@"OpenSans-light" size:48];
}

//Hide the Navigation bar for the login screen and the back button.
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController setNavigationBarHidden:YES];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)createAccountActionWithNormalCredentials:(id)sender {
    
    [self performSegueWithIdentifier:@"showSignUpView" sender:self];
    
}

- (IBAction)loginActionWithNormalCredentials:(id)sender {
    
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0) {
        UIAlertView *loginInvalidAlertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure that you enter a username and password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [loginInvalidAlertView show];
    }
    else {
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if (error) {
                UIAlertView *invalidLoginCredentialsAlert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [invalidLoginCredentialsAlert show];
            }
            else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }
    
}

- (IBAction)loginActionWithTwitterCredentials:(id)sender {
    
    [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Twitter login.");
            return;
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in with Twitter!");
        } else {
            NSLog(@"User logged in with Twitter!");
            [self.navigationController popToRootViewControllerAnimated:YES];
        }     
    }];
    
}

#pragma mark - Facebook Login or Signup Integration
- (IBAction)loginActionWithFacebookCredentials:(id)sender {
    
    [PFFacebookUtils logInWithPermissions:self.permissions block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            NSLog(@"User logged in through Facebook!");
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
    
}
@end
