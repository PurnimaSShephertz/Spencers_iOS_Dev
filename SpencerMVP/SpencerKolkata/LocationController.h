//
//  User.h
//  ASITruckTracker
//
//  Created by Muhammad Jasim Shah on 10/7/10.
//  Copyright 2011 American Snow & Ice Management, Inc. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@protocol LocationController

- (void)locationControllerDidUpdateLocation:(CLLocation *)location;

@end

@interface LocationController : NSObject <CLLocationManagerDelegate>
{
   
}

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@property (weak, nonatomic) id delegate;

+ (LocationController *)sharedController;
-(void) start;
-(void) stop;
-(BOOL) locationKnown;
-(BOOL) isLocationEnable;
-(NSString *)latitude;
-(NSString *)longitude;
@end
