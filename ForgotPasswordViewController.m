//
//  ForgotPasswordViewController.m
//  WaitTimes
//
//  Created by Guillermo Vargas on 4/10/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import <Parse/Parse.h>

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = NO;
    [self.navigationController setNavigationBarHidden:NO];
//    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resetPasswordAction:(id)sender {
    
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([email length] == 0) {
        UIAlertView *invalidInputAlertView = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Make sure that you didn't leave anything blank" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [invalidInputAlertView show];
    } else {
        [PFUser requestPasswordResetForEmailInBackground:email];
    }
}

@end
