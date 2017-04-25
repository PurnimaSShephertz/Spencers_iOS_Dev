//
//  SH_TrackingUtility.m
//  Spencer
//
//  Created by Purnima on 02/03/17.
//  Copyright © 2017 Binary. All rights reserved.
//

#import "SH_TrackingUtility.h"

#define shephertzApiKey @"4d0a891412cb69e84e28b8d912cb6c2e80cdb6c21dfeede9118667fc7e8725d3"
#define shephertzSecretKey @"723306738afa6e9741a998d24114f52e3f62eb7ef70b3d19e592c67be2748946"


@implementation SH_TrackingUtility

+(void)initializeApp42SDK{
    
    [App42API initializeWithAPIKey:shephertzApiKey andSecretKey:shephertzSecretKey];
    [App42API enableAppAliveTracking:YES];
    [App42API enableAppStateEventTracking:YES];
    [App42API enableEventService:YES];
    [App42API enableApp42Trace:YES];
    
}

+(void)setLoggedInUser:(NSString *)user{
    [App42API setLoggedInUser:user];
}

+(NSString *)getLoggedInUser{
    return [App42API getLoggedInUser];
}

+(NSString *)isUserLoggedIn{
    
    NSString *isUserLogin = @"false";
    NSDictionary *customerDict = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"];
    NSDictionary *customerData = [customerDict objectForKey:@"data"];
    NSString *customerId = [customerData valueForKey:@"customerid"];
    
    if ([customerId isKindOfClass:[NSNull class]] || [customerId isEqualToString:@"<null>"])
        isUserLogin = @"false";
    else
        isUserLogin = @"true";
    
    return isUserLogin;
}

+(NSString *)getLoggedInCustomerId{
    
    NSDictionary *customerDict = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"];
    NSDictionary *customerData = [customerDict objectForKey:@"data"];
    NSString *customerId = [customerData valueForKey:@"customerid"];
    
    if ([customerId isKindOfClass:[NSNull class]] || [customerId isEqualToString:@"<null>"])
        customerId = @"";
    
    return customerId;
}


+(void)registerDeviceToken:(NSString *)deviceToken{
    
    PushNotificationService *pushService = [App42API buildPushService];
    [pushService registerDeviceToken:deviceToken withUser:[App42API getLoggedInUser] completionBlock:^(BOOL success, id responseObj, App42Exception *exception) {
        if (success)
        {
            PushNotification *pushNotification = (PushNotification*)responseObj;
            NSLog(@"UserName=%@",pushNotification.userName);
            NSLog(@"isResponseSuccess=%d",pushNotification.isResponseSuccess);
            NSLog(@"Response=%@",pushNotification.strResponse);
        }
        else
        {
            NSLog(@"Exception = %@",[exception reason]);
            NSLog(@"HTTP Error Code = %d",[exception httpErrorCode]);
            NSLog(@"App Error Code = %d",[exception appErrorCode]);
            NSLog(@"User Info = %@",[exception userInfo]);
        }
    }];
}

+(void)trackEventOfSpencerEvents:(NSString *)eventName eventProp:(NSMutableDictionary *)eventProperties{
    
    [eventProperties setObject:[SH_TrackingUtility isUserLoggedIn] forKey:kIsLoggedInProperty];
    [eventProperties setObject:[SH_TrackingUtility getLoggedInCustomerId] forKey:kCustomerIdProperty];
    
    
    EventService *eventService = [App42API buildEventService];
    [eventService trackEventWithName:eventName andProperties:eventProperties completionBlock:^(BOOL success, id responseObj, App42Exception *exception) {
        
        if (success)
        {
            App42Response *response = (App42Response*)responseObj;
            NSLog(@"IsResponseSuccess is %d" , response.isResponseSuccess);
        }
        else
        {
            NSLog(@"Exception = %@",[exception reason]);
            NSLog(@"HTTP error Code = %d",[exception httpErrorCode]);
            NSLog(@"App Error Code = %d",[exception appErrorCode]);
            NSLog(@"User Info = %@",[exception userInfo]);
        }
        
    }];
    
}

@end
