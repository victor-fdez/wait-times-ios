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
    
    
    
    //Check if the user is already logged in otherwise send them to the login/signup screen.
   
    //Create a parse request for the current user and then save it to the variable currentUser
    PFUser *currentUser = [PFUser currentUser];
    
    //Connect to Parse and check if the current user is logged in or not that returns a BOOL and continues with the if statement below.
    if (currentUser) {
        //For testing purposes we send to the terminal what is the username of the person logged in.
        NSLog(@"Current user that is logged in: %@", currentUser.username);
        
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
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"glanceTableCell";
    GlanceViewTableCell *cell = (GlanceViewTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GlanceBridgeCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
 
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 static NSString *simpleTableIdentifier = @"SimpleTableCell";
 
 SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
 if (cell == nil)
 {
 NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
 cell = [nib objectAtIndex:0];
 }
 
 cell.nameLabel.text = [tableData objectAtIndex:indexPath.row];
 cell.thumbnailImageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
 cell.prepTimeLabel.text = [prepTime objectAtIndex:indexPath.row];
 
 return cell;
 }
 
 
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */



- (IBAction)addItemToGlanceView:(id)sender {
    
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser]; // this will now be nil
    NSLog(@"currentUser = %@", currentUser);
    [self performSegueWithIdentifier:@"showLoginScreen" sender:self];
}
@end
