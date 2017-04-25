//
//  AppDelegate.m
//  SpencerKolkata
//
//  Created by binary on 30/06/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "MainCategoryVC.h"
#import "YourLocationVC.h"
#import "GAIEcommerceProduct.h"
#import "GAIDictionaryBuilder.h"
#import "SH_TrackingUtility.h"
#import "ProductVC.h"
#import "Const.h"

static NSString *const kTrackingId = @"UA-82199552-1";
//static NSString *const kTrackingId = @"UA-57243912-1";
//static NSString *const kTrackingId = @"UA-86820129-1";

static NSString *const kAllowTracking = @"allowTracking";
#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()
{
    YourLocationVC *yourLocationVC;
}

@property(nonatomic, assign) BOOL okToWait;
@property(nonatomic, copy) void (^dispatchHandler)(GAIDispatchResult result);

@end

@implementation AppDelegate

@synthesize categoryId;
@synthesize cartDict;
@synthesize filterDict;
@synthesize filterSearchDict;
@synthesize navigationBool;
@synthesize orderConfirmationDict;
@synthesize creditCardNetbankingFlag;
@synthesize Scrollcheck;
@synthesize citrusWalletAmount;

@synthesize brandIdArr, quantityIdArr;
@synthesize counterDict;

@synthesize finalCartDict;

#pragma mark - Class Methods

/**
 Notification Registration
 */

- (void)registerForRemoteNotification {
    if(SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO( @"10.0" )) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error)
         {
             if( !error ) {
                 [[UIApplication sharedApplication] registerForRemoteNotifications];
                 // required to get the app to do anything at all about push notifications
                 NSLog( @"Push registration success." );
             } else {
                 NSLog( @"Push registration FAILED" );
                 NSLog( @"ERROR: %@ - %@", error.localizedFailureReason, error.localizedDescription );
                 NSLog( @"SUGGESTIONS: %@ - %@", error.localizedRecoveryOptions, error.localizedRecoverySuggestion );
             }
         }];
    } else{
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"quantityId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sortingBy"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandIdSearchArr"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"quantityIdSearchArr"];
    
    NSLog(@"NUMBER %@", [NSNumber numberWithFloat:[@"6.8400" floatValue]]);
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"] integerValue] < 1)
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"14" forKey:@"store_id_token"];
    }
    
//    sleep(2);
    

    NSDictionary *appDefaults = @{kAllowTracking: @(YES)};
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
    [GAI sharedInstance].optOut =  ![[NSUserDefaults standardUserDefaults] boolForKey:kAllowTracking];
    [GAI sharedInstance].dispatchInterval =120.0;
    [GAI sharedInstance].trackUncaughtExceptions = NO;
  
    self.tracker = [[GAI sharedInstance] trackerWithName:@"spencer's"
                                              trackingId:kTrackingId];
    [self registerForRemoteNotification];
    
    
    [SH_TrackingUtility initializeApp42SDK];    //call app42 initialze api call method
    

    [[NSUserDefaults standardUserDefaults] setValue:kTrackingId forKey:@"kTrackingId"];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    
    [[IQKeyboardManager sharedManager] setEnable:TRUE];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:FALSE];
//    [[IQKeyboardManager sharedManager] disableDistanceHandlingInViewControllerClass:[MainCategoryVC class]];
//    [[IQKeyboardManager sharedManager] disableDistanceHandlingInViewControllerClass:[CommentsController class]];
    
    
    if([[LocationController sharedController] isLocationEnable])
    {
        [[LocationController sharedController] setDelegate:nil];
        [[LocationController sharedController] start];
    }

    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"userLocation"] length] < 1 && ([[NSUserDefaults standardUserDefaults] boolForKey:@"isFirst"] == YES))
    {
        yourLocationVC  = [[YourLocationVC alloc] initWithNibName:@"YourLocationVC" bundle:nil];
        navContr = [[UINavigationController alloc] initWithRootViewController:yourLocationVC];
        
        self.window.rootViewController = navContr;
    }
    else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isFirst"] == YES)
    {
        DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[MainCategoryVC alloc] init]];
        DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];
        
        REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
        frostedViewController.direction = REFrostedViewControllerDirectionLeft;
        frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
        frostedViewController.liveBlur = YES;
        frostedViewController.delegate = self;
        
        navContr = [[UINavigationController alloc] initWithRootViewController:frostedViewController];
        
        self.window.rootViewController = navContr;
        navContr.navigationBar.hidden = YES;

        
    }
    
    else
    {
        landingPage = [[LandingPage alloc] initWithNibName:@"LandingPage" bundle:nil];
        navContr = [[UINavigationController alloc] initWithRootViewController:landingPage];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirst"];
        self.window.rootViewController = navContr;
        navContr.navigationBar.hidden = YES;
    }
    
    
    
    
    return YES;
}


- (void)registerUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString * token = [NSString stringWithFormat:@"%@", deviceToken];
    //Format token as per need:
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    NSLog(@"Device Token is \n%@",token);
    
    NSString * tokennewstr=token;
    //    NSLog(@"token %@", token);
    
    [[NSUserDefaults standardUserDefaults] setValue:tokennewstr forKey:@"devicetoken"];
    
    [SH_TrackingUtility setLoggedInUser:tokennewstr];         // set logged in user to the app42 api server
    [SH_TrackingUtility registerDeviceToken:tokennewstr];       //register device token to the app42 server api call
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [self application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:^(UIBackgroundFetchResult result) {
    }];
}

-(void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void
                                                                                                                               (^)(UIBackgroundFetchResult))completionHandler
{
    
    [SH_TrackingUtility trackPush:[userInfo objectForKey:trackPushKey]];
    
    // iOS 10 will handle notifications through other methods
    
    bool isOffer = [[userInfo valueForKey:kIsOfferPushKey] boolValue];
    NSString *catid = [NSString stringWithFormat:@"%@", [userInfo valueForKey:kCatIdPushKey]];
    NSString *pushMessage = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
    
    [self pushNotifiactionClick:pushMessage catid:catid isoffer:isOffer];
    
    if( SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO( @"10.0" ) )
    {
        NSLog( @"iOS version >= 10. Let NotificationCenter handle this one." );
        // set a member variable to tell the new delegate that this is background
        return;
    }
    NSLog( @"HANDLE PUSH, didReceiveRemoteNotification: %@", userInfo );
    
    // custom code to handle notification content
    
    if( [UIApplication sharedApplication].applicationState == UIApplicationStateInactive )
    {
        NSLog( @"INACTIVE" );
        completionHandler( UIBackgroundFetchResultNewData );
    }
    else if( [UIApplication sharedApplication].applicationState == UIApplicationStateBackground )
    {
        NSLog( @"BACKGROUND" );
        completionHandler( UIBackgroundFetchResultNewData );
    }
    else
    {
        NSLog( @"FOREGROUND");
        NSString *cancelTitle = @"Close";
        //  NSString *showTitle = @"Show";
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"spencer's push notification"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:cancelTitle
                                                  otherButtonTitles:nil];
        [alertView show];
        //        completionHandler( UIBackgroundFetchResultNewData );
        //        completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    }
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    NSLog( @"Handle push from foreground" );
    
    NSDictionary *notificationDict = notification.request.content.userInfo;
    NSLog(@"notificationDict: %@", notificationDict);
    
    bool isOffer = [[notificationDict valueForKey:kIsOfferPushKey] boolValue];
    NSString *pushMessage = [[notificationDict valueForKey:@"aps"] valueForKey:@"alert"];
    NSString *catid = [NSString stringWithFormat:@"%@", [notificationDict valueForKey:kCatIdPushKey]];
    if(isOffer){
//        [self openOfferPageOnClickPushNotification:catid];
    }
    
    
    [SH_TrackingUtility trackPush:[notificationDict objectForKey:trackPushKey]];
    
    [self pushNotifiactionClick:pushMessage catid:catid isoffer:isOffer];
    
    
//    NSLog(@"Foreground User Info : %@",notification.request.content.userInfo);
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    // custom code to handle push while app is in the foreground
    //[[[UIAlertView alloc] initWithTitle:@"Message" message:[[notificationDict valueForKey:@"aps"] valueForKey:@"alert"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil] show];
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    NSLog( @"Handle push from background or closed" );
    // if you set a member variable in didReceiveRemoteNotification, you  will know if this is from closed or background
//    NSLog(@"Background User Info :%@", response.notification.request.content.userInfo);
    
    NSDictionary *notificationDict = response.notification.request.content.userInfo;
    NSLog(@"notificationDict: %@", notificationDict);
    
    bool isOffer = [[notificationDict valueForKey:kIsOfferPushKey] boolValue];
    NSString *catid = [NSString stringWithFormat:@"%@", [notificationDict valueForKey:kCatIdPushKey]];
    NSString *pushMessage = [[notificationDict valueForKey:@"aps"] valueForKey:@"alert"];

    if(isOffer){
//        [self openOfferPageOnClickPushNotification:catid];
    }
    
    [SH_TrackingUtility trackPush:[notificationDict objectForKey:trackPushKey]];
    [self pushNotifiactionClick:pushMessage catid:catid isoffer:isOffer];
}

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request
                   withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    //    self.contentHandler = contentHandler;
    //    self.bestAttemptContent = [request.content mutableCopy];
    //
    //    // Modify the notification content here...
    //    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    //    self.contentHandler(self.bestAttemptContent);
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self sendHitsInBackground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [GAI sharedInstance].optOut =
    ![[NSUserDefaults standardUserDefaults] boolForKey:kAllowTracking];
}

-(void)application:(UIApplication *)application
performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [self sendHitsInBackground];
    completionHandler(UIBackgroundFetchResultNewData);
}


- (void)sendHitsInBackground
{
    self.okToWait = YES;
    __weak AppDelegate *weakSelf = self;
    __block UIBackgroundTaskIdentifier backgroundTaskId =
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        weakSelf.okToWait = NO;
    }];
    
    if (backgroundTaskId == UIBackgroundTaskInvalid) {
        return;
    }
    
    self.dispatchHandler = ^(GAIDispatchResult result) {
        // If the last dispatch succeeded, and we're still OK to stay in the background then kick off
        // again.
        if (result == kGAIDispatchGood && weakSelf.okToWait ) {
            [[GAI sharedInstance] dispatchWithCompletionHandler:weakSelf.dispatchHandler];
        } else {
            [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskId];
        }
    };
    [[GAI sharedInstance] dispatchWithCompletionHandler:self.dispatchHandler];
}


-(void)pushNotifiactionClick:(NSString *)pushMessage catid:(NSString *)catId isoffer:(BOOL)isOffer{
//    message,catid,isoffer
    
    NSLog(@"push message : %@, catid: %@, isoffer: %d", pushMessage, catId, isOffer);
    NSMutableDictionary *promoClickPush = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                             pushMessage, kMessagePushKey,
                                             catId, kCatIdPushKey,
                                             [NSString stringWithFormat:@"%d", isOffer], kIsOfferPushKey,
                                             nil];
    
    [SH_TrackingUtility trackEventOfSpencerEvents:promoClickEvent eventProp:promoClickPush];
    
}


//push notification click-- open product VC as offer page
-(void)openOfferPageOnClickPushNotification:(NSString *)catId{
    
    NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/category/products/%@?page=%@&store=%@", baseUrl1, catId, @"1", storeIdStr];
    
    ProductVC *productVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
    
    productVC.productHeader = @"Offers";
    productVC.categoryUrl = urlStr;

    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:productVC];
    self.window.rootViewController = navController;
    
    [self.window makeKeyAndVisible];
}



@end
