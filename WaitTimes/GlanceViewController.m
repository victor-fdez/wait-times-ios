//
//  GlanceViewController.m
//  WaitTimes
//
//  Created by Guillermo Vargas on 3/27/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import "GlanceViewController.h"
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
    
    //Set the default data to show if there is no connection to JSON
    bridge.bridgeName = @"Information not Available";
    bridge.calculatedWaitTime = @"Information not Available";
    
    //Do some graphical housekeeping, remove the separators given by default in iOS7 maybe I can move this somewhere else.
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}


- (void)viewWillAppear:(BOOL)animated
{
    //Hide the back button and navigation controllers for the login.
    self.navigationItem.hidesBackButton = NO;
    [self.navigationController setNavigationBarHidden:NO];
    
    //Check if the user is already logged in otherwise send them to the login/signup screen.
    
    //Create a parse request for the current user and then save it to the variable currentUser
    PFUser *currentUser = [PFUser currentUser];
    
    //Connect to Parse and check if the current user is logged in or not that returns a BOOL and continues with the if statement below.
    if (currentUser) {
        
        //For testing purposes we send to the terminal what is the username of the person logged in.
        NSLog(@"Current user that is logged in: %@", currentUser.username);
        
        //Get the JSON file, parse it and make a dictionary with it. I need to implement an error about connection in case that there is no connection.
        NSURL *jSONCalculatedDataFromServer = [NSURL URLWithString:@"http://72.191.185.122/jsonTest/jsonTestFile"];
        NSData *calculatedDataFromServer = [NSData dataWithContentsOfURL:jSONCalculatedDataFromServer];
        NSError *error = nil;
        NSDictionary *componentsOfjSONDataDictionary = [NSJSONSerialization JSONObjectWithData:calculatedDataFromServer options:0 error:&error];
        
        //Set an array with the information obtained from the JSON file
        self.bridges = [NSMutableArray array];
        
        //The information is located in the bridges sections of the JSON file.
        NSArray *bridgesArray = [componentsOfjSONDataDictionary objectForKey:@"bridges"];
        
        //Get the contents of the JSON data and put them in an array, should this be a Mutable Array to change it?
        for (NSDictionary *bridgeInformationDictionary in bridgesArray) {
            Bridge *bridgeItem = [Bridge bridgeWithName:[bridgeInformationDictionary objectForKey:@"name"]];
            NSLog(@"%@", bridgeItem.bridgeName);
            
            bridgeItem.calculatedWaitTime = [bridgeInformationDictionary objectForKey:@"calculatedTime"];
            NSLog(@"%@", bridgeItem.calculatedWaitTime);
            
            bridgeItem.qualitativePropertiesOfTraffic = [bridgeInformationDictionary objectForKey:@"qualitativeProperty"];
            NSLog(@"%@", bridgeItem.qualitativePropertiesOfTraffic);
            
            //bridgeItem.directionIsNorthward = [bridgeInformationDictionary objectForKey:@"directionIsNorthward"];
            
            
            [self.bridges addObject:bridgeItem];
        }
        
        
    }
    
    else {
        
        //If there is no one logged in to the app, then take them to the login screen.
        [self performSegueWithIdentifier:@"showLoginScreen" sender:self];
    }

    
    
    
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
    //This code creates and implements the customised cell for the TableViewController
    static NSString *CellIdentifier = @"glanceTableCell";
    GlanceViewTableCell *cell = (GlanceViewTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GlanceBridgeCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    //End custom cell
    
    //Get which cell is being loaded
    Bridge *bridgeCell = [self.bridges objectAtIndex:indexPath.row];
    
    //Set the title of the bridge from the name property.
    cell.glanceViewBridgeTitle.text = bridgeCell.bridgeName;
    
    //Now set the time, I am using a crude way, maybe transfer this to a standalone function?
    NSString *theTimeValue = bridgeCell.calculatedWaitTime;
    
    int inputSeconds = [theTimeValue intValue];
    int hours =  inputSeconds / 3600;
    int minutes = ( inputSeconds - hours * 3600 ) / 60;
    if (hours == 0) {
        NSString *theTime = [NSString stringWithFormat:@"%.1d min", minutes];
        cell.glanceViewWaitTimeNumber.text = theTime;
    }
    else {
        NSString *theTime = [NSString stringWithFormat:@"%.1d h %.1d min", hours, minutes];
        cell.glanceViewWaitTimeNumber.text = theTime;
    }
    
    //This is what sets the qualitative property of the traffic, whether its Heavy or Light
    cell.glanceViewWaitTimeDescription.text = bridgeCell.qualitativePropertiesOfTraffic;
    NSLog(@"What goes in the title: %@", bridgeCell.bridgeName);
    NSLog(@"Formatted time Log: %@", bridgeCell.calculatedWaitTime);
    NSLog(@"What goes in the qualitative field: %@", bridgeCell.qualitativePropertiesOfTraffic);
    
    //Return the cell with all its contents and style.
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Deselect the cell manually, because it doesn't deselect by default.
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"Clicked the row number: %ld", (long)indexPath.row);
    NSIndexPath *indexPathOfTable = [self.tableView indexPathForSelectedRow];
    Bridge *bridgePart = [self.bridges objectAtIndex:indexPathOfTable.row];
    [self performSegueWithIdentifier:@"showDetailedView" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"preapring for segue: %@", segue.identifier);
    
//    if ([segue.identifier isEqualToString:@"showDetailedView"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        Bridge *blogPost = [self.blogPosts objectAtIndex:indexPath.row];
//        WebViewController *wbc = (WebViewController *)segue.destinationViewController;
//        wbc.blogPostURL = blogPost.url;
//    }
}




//For testing purposes the add bridge button does logout, but it will take to a screen where we can add more bridges.
- (IBAction)addItemToGlanceView:(id)sender {
    
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser]; // this will now be nil
    NSLog(@"currentUser = %@", currentUser);
    [self performSegueWithIdentifier:@"showLoginScreen" sender:self];
}
@end
