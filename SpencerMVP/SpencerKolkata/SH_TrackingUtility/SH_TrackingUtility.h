//
//  SH_TrackingUtility.h
//  Spencer
//
//  Created by Purnima on 02/03/17.
//  Copyright © 2017 Binary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SH_Constant.h"


@interface SH_TrackingUtility : NSObject

+(void)initializeApp42SDK;
+(void)setLoggedInUser:(NSString *)user;
+(NSString *)getLoggedInUser;
+(NSString *)isUserLoggedIn;
+(NSString *)getLoggedInCustomerId;
+(void)registerDeviceToken:(NSString *)deviceToken;
+(void)trackEventOfSpencerEvents:(NSString *)eventName eventProp:(NSMutableDictionary *)eventProperties;
+(void)trackPush:(NSString*)campaignName;

@end
