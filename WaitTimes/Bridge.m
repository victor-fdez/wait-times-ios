//
//  Bridge.m
//  WaitTimes
//
//  Created by Guillermo Vargas on 4/1/14.
//  Copyright (c) 2014 V2 Interactive. All rights reserved.
//

#import "Bridge.h"

@implementation Bridge

- (id) initWithBridgeName:(NSString *)bridgeName
{
    self = [super init];
    
    if (self) {
        self.bridgeName = bridgeName;
        self.calculatedWaitTime = nil;
        self.qualitativePropertiesOfTraffic = nil;
        self.directionIsNorthward = nil;
    }
    return self;

}


+ (id)bridgeWithName:(NSString *)bridgeName
{
    return [[self alloc] initWithBridgeName:bridgeName];
}


- (NSString *) formattedTime {
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH 'h' mm 'min'"];
    NSDate *timeToConvert = [timeFormatter dateFromString:self.calculatedWaitTime];
    
    return [timeFormatter stringFromDate:timeToConvert];
}

@end
