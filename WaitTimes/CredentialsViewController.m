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
    
    //Create a handler for dismissing the keyboard once clicking anything outside of the keyboard
    
}

//Hide the Navigation bar for the login screen and the back button.
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController setNavigationBarHidden:YES];
    
    //Video Background?

    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"moments" ofType:@"mp4"]]];
    [self.moviePlayer.view setFrame:self.view.bounds];
    [self.moviePlayer setFullscreen: NO];
    [self.moviePlayer setAllowsAirPlay: NO];
    [self.moviePlayer setScalingMode:MPMovieScalingModeAspectFill];
    [self.moviePlayer setControlStyle:MPMovieControlStyleNone];
    [self.moviePlayer setRepeatMode:MPMovieRepeatModeOne];
    [self.moviePlayer play];
    [self.view insertSubview:self.moviePlayer.view atIndex:3];
    
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

- (IBAction)userNameReturnPress:(id)sender {
    
    [sender resignFirstResponder];
    
}

- (IBAction)passwordReturnPress:(id)sender {
    
    [sender resignFirstResponder];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if (([_usernameField isFirstResponder] && [touch view] != _usernameField) || ([_passwordField isFirstResponder] && [touch view] != _passwordField)) {
        [_usernameField resignFirstResponder];
        [_passwordField resignFirstResponder];
    }
    
}


@end
