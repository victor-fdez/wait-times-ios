//
//  AppDelegate.m
//  WaitTimes
//
//  Created by Guillermo Vargas on 3/25/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //Load the Parse Library, which will simplfy many aspects especially at the Startup phase of our company.
    
    [Parse setApplicationId:@"goPZUvavNNgVdJ6SAd1WBLNfoxTWGKt5x39T5G9Q"
                  clientKey:@"R0uQqzLakvLrLbciSRFW4LJ01v9VtekQ3XYr0ArX"];
    
    //Parse Twitter Sign in initialisation follows
    
    [PFTwitterUtils initializeWithConsumerKey:@"v3L52qQd0jDOtOwyshLk04Oo3"
                               consumerSecret:@"yViTGSuG7YWFEfSjbfhdEI7jQV61LKB0qEVYOpxtZ9GjIOMJ0W"];
    
    //Initialise parse Facebook Login SDK
    
    [PFFacebookUtils initializeFacebook];
    
    
    
    //Add Parse Framework statistic tracking.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHue:.215 saturation:.15 brightness:.17 alpha:1]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHue:0.5972 saturation:0.29 brightness:0.62 alpha:1], NSForegroundColorAttributeName, [UIFont fontWithName:@"OpenSans-Light" size:18.0], NSFontAttributeName, nil]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    //Initialisation of Facebook with Parse Framework
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Facebook with Parse Framework Handlers
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}


@end
