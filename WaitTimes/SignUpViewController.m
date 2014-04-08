//
//  SignUpViewController.m
//  WaitTimes
//
//  Created by Guillermo Vargas on 3/28/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    #pragma mark - Visual Setup of Login/Signup screen
    self.navigationItem.hidesBackButton = NO;
    [self.navigationController setNavigationBarHidden:NO];
    
    //Change the fonts of the textfields.
    self.signUpTitleLabel.font = [UIFont fontWithName:@"OpenSans-Light" size:25];
    self.emailField.font = [UIFont fontWithName:@"OpenSans-Light" size:12];
    self.passwordField.font = [UIFont fontWithName:@"OpenSans-Light" size:12];
    self.firstNameField.font = [UIFont fontWithName:@"OpenSans-Light" size:12];
    self.lastNameField.font = [UIFont fontWithName:@"OpenSans-Light" size:12];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpActionWithNormalCredentials:(id)sender {
    
    //Exctract information from the NSTexFields
    NSString *username = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *firstName = [self.firstNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *lastName = [self.lastNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //Check that the user has input some data not just anything blank.
    if ([username length] == 0 || [password length] == 0 || [firstName length] == 0 || [lastName length] == 0) {
        UIAlertView *invalidInputAlertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure that you didn't leave anything blank" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [invalidInputAlertView show];
    }
    //Otherwhise if everything is fine, call Parse and create a new user with the following credentials.
    else {
        PFUser *newSignUpUserWithNormalInformation = [PFUser user];
        newSignUpUserWithNormalInformation.username = username;
        newSignUpUserWithNormalInformation.password = password;
        newSignUpUserWithNormalInformation.email = email;
        
        PFObject *firstName = [PFObject objectWithClassName:@"First Name"];
        firstName[@"firstname"] = firstName;
        PFObject *lastName = [PFObject objectWithClassName:@"Last Name"];
        firstName[@"lastname"] = lastName;
        
        [newSignUpUserWithNormalInformation signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (error) {
                UIAlertView *invalidSignUpInformationAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry!" message:[error.userInfo objectForKey:@"eror"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //Show the alert once the error has occured
                [invalidSignUpInformationAlertView show];
            }
            else {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }];
    }

    
}
@end
