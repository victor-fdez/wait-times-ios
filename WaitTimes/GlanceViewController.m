//
//  GlanceViewController.m
//  WaitTimes
//
//  Created by Guillermo Vargas on 3/27/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import "GlanceViewController.h"
#import "GlanceViewTableCell.h"
#import "GlanceViewTableCell.h"

@interface GlanceViewController ()

@end

@implementation GlanceViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}




//Do the initial settings first after the Glance Page has loaded.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Bridge *bridge = [[Bridge alloc] init];
    
    bridge.bridgeName = @"Name not available";
    bridge.calculatedWaitTime = @"time not available";
    
    
    
    //Check if the user is already logged in otherwise send them to the login/signup screen.
   
    //Create a parse request for the current user and then save it to the variable currentUser
    PFUser *currentUser = [PFUser currentUser];
    
    //Connect to Parse and check if the current user is logged in or not that returns a BOOL and continues with the if statement below.
    if (currentUser) {
        //For testing purposes we send to the terminal what is the username of the person logged in.
        NSLog(@"Current user that is logged in: %@", currentUser.username);
        
        
        
        NSURL *jSONCalculatedDataFromServer = [NSURL URLWithString:@"http://72.191.185.122/jsonTest/jsonTestFile"];
        
        
        NSData *calculatedDataFromServer = [NSData dataWithContentsOfURL:jSONCalculatedDataFromServer];
        
        
        NSError *error = nil;
        
        NSDictionary *componentsOfjSONDataDictionary = [NSJSONSerialization JSONObjectWithData:calculatedDataFromServer options:0 error:&error];
        
        NSLog(@"%@", componentsOfjSONDataDictionary);
        
        self.bridges = [NSMutableArray array];
        
        NSArray *bridgesArray = [componentsOfjSONDataDictionary objectForKey:@"bridges"];
        
        for (NSDictionary *bridgeInformationDictionary in bridgesArray) {
            Bridge *bridgeItem = [Bridge bridgeWithName:[bridgeInformationDictionary objectForKey:@"name"]];
            NSLog(@"%@", bridgeItem.bridgeName);
            
            bridgeItem.calculatedWaitTime = [bridgeInformationDictionary objectForKey:@"calculatedTime"];
            NSLog(@"%@", bridgeItem.calculatedWaitTime);
            
            bridgeItem.qualitativePropertiesOfTraffic = [bridgeInformationDictionary objectForKey:@"qualitativeProperty"];
            NSLog(@"%@", bridgeItem.qualitativePropertiesOfTraffic);
            
            
//          bridgeItem.directionIsNorthward = [bridgeInformationDictionary objectForKey:@"directionIsNorthward"];
            
            
            [self.bridges addObject:bridgeItem];
        }
        
        
    } else {
        [self performSegueWithIdentifier:@"showLoginScreen" sender:self];
    }
    
    //Do some graphical housekeeping, remove the separators given by default in iOS7.
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = NO;
    [self.navigationController setNavigationBarHidden:NO];
}


#pragma mark - Login View Setup
//We prepare to hide the top title of the nav bar.




//Change the height of a cell in a TableViewController to a specific number in this case it is 125, this is asusming
//that our cell will always have one line in all labels.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.bridges count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"glanceTableCell";
    GlanceViewTableCell *cell = (GlanceViewTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GlanceBridgeCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Bridge *bridgeCell = [self.bridges objectAtIndex:indexPath.row];
    
    cell.glanceViewBridgeTitle.text = bridgeCell.bridgeName;
    cell.glanceViewWaitTimeNumber.text = bridgeCell.calculatedWaitTime;
    cell.glanceViewWaitTimeDescription.text = bridgeCell.qualitativePropertiesOfTraffic;
    NSLog(@"%@", bridgeCell.bridgeName);
    NSLog(@"%@", bridgeCell.calculatedWaitTime);
    NSLog(@"%@", bridgeCell.qualitativePropertiesOfTraffic);
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}




- (IBAction)addItemToGlanceView:(id)sender {
    
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser]; // this will now be nil
    NSLog(@"currentUser = %@", currentUser);
    [self performSegueWithIdentifier:@"showLoginScreen" sender:self];
}
@end
