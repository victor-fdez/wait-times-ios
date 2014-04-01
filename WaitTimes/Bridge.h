//
//  Bridge.h
//  WaitTimes
//
//  Created by Guillermo Vargas on 4/1/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bridge : NSObject

//Data needed to create the entry
@property (nonatomic, strong) NSString *bridgeName;
@property (nonatomic, strong) NSString *calculatedWaitTime;
@property (nonatomic, strong) NSString *formattedTime;
@property (nonatomic, strong) NSArray *qualitativePropertiesOfTraffic;
@property BOOL *directionIsNorthward;



//@property (nonatomic, strong) UIImage *flagOfCountryFromDirection;
//@property (nonatomic, strong) UIImage *flagOfCountryTowardsDirection;

//Initialisers.

- (id) initWithBridgeName:(NSString *)bridgeName;

+ (id) bridgeWithName:(NSString *) bridgeName;

- (NSString *) formattedTime;

@end
