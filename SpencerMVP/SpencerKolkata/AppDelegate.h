//
//  AppDelegate.h
//  SpencerKolkata
//
//  Created by binary on 30/06/16.
//  Copyright © 2016 Binary. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "LoginVC.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationController.h"
#import "LandingPage.h"
#import "REFrostedViewController.h"
#import "GAI.h"
#import <CoreLocation/CoreLocation.h>
#import <UserNotifications/UserNotifications.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, REFrostedViewControllerDelegate, UNUserNotificationCenterDelegate>
{
    LoginVC *loginVC;
    UINavigationController *navContr;
    LandingPage *landingPage;
}
@property(nonatomic, strong) id <GAITracker> tracker;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) NSString * latstr, *longstr, *bangeStr;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, assign) int indexNumberIs;

@property (nonatomic, assign) int categoryId;
@property (nonatomic, assign) int ACPBool;

@property (nonatomic, retain) NSString * GlobalOfferName;
@property (nonatomic, retain) NSString * GlobalofferURL;

@property (nonatomic, retain) NSDictionary *offerUrlDict;
@property (nonatomic, retain) NSMutableDictionary *cartDict;
@property (nonatomic, assign) int pageBool;
@property (nonatomic, retain) NSDictionary *filterDict, *finalCartDict;
@property (nonatomic, retain) NSDictionary *filterSearchDict;
@property (nonatomic, assign) int navigationBool;
@property (nonatomic, assign) int addressIndex;

@property(nonatomic,retain) NSString * Checkpage,*pageType,*citrusfinalamount, *citrusWalletAmount;


@property (nonatomic, assign) int pushBool;
@property (nonatomic, assign) int paymentIndexNumber;

@property (nonatomic, retain) NSMutableDictionary *orderConfirmationDict;

@property (nonatomic, assign) BOOL Scrollcheck;
@property (nonatomic, assign) int creditCardNetbankingFlag;

@property (nonatomic, assign) int pushFlag;

@property (nonatomic, assign) NSMutableArray *brandIdArr, *quantityIdArr;

@property (nonnull, assign) NSDictionary *counterDict;


@end

