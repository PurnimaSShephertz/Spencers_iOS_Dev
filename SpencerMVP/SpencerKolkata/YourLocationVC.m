//
//  YourLocationVC.m
//  SpencerKolkata
//
//  Created by binary on 30/06/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "YourLocationVC.h"
#import <CoreLocation/CoreLocation.h>
#import "CoreLocationController.h"
#import "AppDelegate.h"
#import "Const.h"
#import "ManualLocationVC.h"
#import "DEMONavigationController.h"
#import "MainCategoryVC.h"
#import "DEMOMenuViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "Webmethods.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface YourLocationVC () <CLLocationManagerDelegate>
{
    AppDelegate *appDele;
    ManualLocationVC *manualLocationVC;
}
@end

@implementation YourLocationVC
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)findCurrentLocation
{
    
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                //NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    [self.locationManager startUpdatingLocation];
    
    
    appDele.latstr =  [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
    appDele.longstr = [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"Your Location Screen";
    
    UIColor *color = [UIColor colorWithRed:114.0/255.0 green:116.0/255.0 blue:121.0/255.0 alpha:1];
    
    currentLocationBtnObj.titleLabel.textColor = kColor_gray;
    currentLocationBtnObj.layer.borderColor = [UIColor colorWithRed:107/255.0 green:109/255.0 blue:116/255.0 alpha:1].CGColor;
    currentLocationBtnObj.layer.borderWidth = 1;
    currentLocationBtnObj.layer.cornerRadius = 22;
    currentLocationBtnObj.layer.masksToBounds = YES;
    
    [currentLocationBtnObj setTitleColor:color forState:UIControlStateNormal];
    
    manualLocationBtnObj.titleLabel.textColor = kColor_gray;
//    manualLocationBtnObj.layer.borderColor = kColor_gray.CGColor;
//    manualLocationBtnObj.layer.borderWidth = 1;
//    manualLocationBtnObj.layer.cornerRadius = 5;
//    manualLocationBtnObj.layer.masksToBounds = YES;
    
    
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    //self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void) checkLocationServicesTurnedOn
{
    if (![CLLocationManager locationServicesEnabled])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"== Opps! =="
                                                        message:@"'Location Services' need to be on."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        [[[UIAlertView alloc] initWithTitle:@"App Permission Denied"
                                    message:@"To re-enable, please go to Settings and turn on Location Service for this app."
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil]show];
        
        
    }
    else
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        //self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self findCurrentLocation];
        [self getAddress1];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0)
    {
        if([[LocationController sharedController] isLocationEnable])
        {
            [[LocationController sharedController]setDelegate:nil];
            [[LocationController sharedController] start];
        }
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self findCurrentLocation];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)currentLocationBtnAct:(UIButton *)sender {
    
    [self checkLocationServicesTurnedOn];
    
}


-(void)threadStartAnimating14
{
    [SVProgressHUD show];
}


-(void)getAddress1
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%@%%2C%@&sensor=true",appDele.latstr, appDele.longstr]];
    
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating14) toTarget:self withObject:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //NSlog(@"%@",url);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSString *status = [JSON valueForKeyPath:@"status"];
        if ([status isEqualToString:@"OK"])
        {
            NSArray *results = [JSON valueForKeyPath:@"results"];
            if (results.count > 0) {
                NSDictionary *addressDictionary = [self addressDictionaryFromJSON:results[0]];
                  NSArray *addressLines = [addressDictionary objectForKey:@"FormattedAddressLines"];
                if (addressLines) {
                    AddressStr = [addressLines componentsJoinedByString:@", "];
                   
                }
                if ([[addressDictionary valueForKey:@"ZIP"] length] < 2)
                {
                    [self.view addSubview:[[ToastAlert alloc] initWithText:@"GPS Not Stable"]];
                    [SVProgressHUD dismiss];
                }
                else
                {
                    [self Submit_Pin:[addressDictionary valueForKey:@"ZIP"]];
                }
                    
                
                
              
                
                
            }
            
//            DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[MainCategoryVC alloc] init]];
//            DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];
//            
//            REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
//            frostedViewController.direction = REFrostedViewControllerDirectionLeft;
//            frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
//            frostedViewController.liveBlur = YES;
//            frostedViewController.delegate = self;
//            [self.navigationController pushViewController:frostedViewController animated:YES];
        
        }
        else
        {
            
        }
        [SVProgressHUD dismiss];
    }
     failure:nil];
    [SVProgressHUD dismiss];
    [operation start];
    
}


- (void)Submit_Pin:(NSString *)pin
{
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    [SVProgressHUD show];
    NSURL *PinCheck_URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/validate/pincode?pincode=%@", baseUrl1, pin]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:PinCheck_URL];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSMutableDictionary *tempDict;
             tempDict = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
             
             if ([[tempDict valueForKey:@"status"] integerValue] == 1)
             {
                 if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"store_id"] isEqualToString:[[tempDict valueForKey:@"data"] valueForKey:@"store_id"]])
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"globalcartid"];
                 }
                 
                  [[NSUserDefaults standardUserDefaults] setValue:AddressStr forKey:@"userLocation"];
                 // [launchView setHidden:YES];
                 NSString * storeID=[[tempDict valueForKey:@"data"] valueForKey:@"store_id"];
                 [[NSUserDefaults standardUserDefaults]setValue:storeID forKey:@"store_id_token"];
                 NSString * store_name=[[tempDict valueForKey:@"data"] valueForKey:@"store_name"];
                 [[NSUserDefaults standardUserDefaults]setValue:store_name forKey:@"store_name_token"];
                 [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"checklandscreen"];
                 NSString *rstring = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_name_token"];
                 NSLog(@"rstring %@", rstring);
                 //                     [locationLbl setText:rstring];
                 //                     [self getCartWishlist];
                 
                 
                 [self getCartWishlist];
                 
                 
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSideMenu" object:nil];
                 
                     
                     DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[MainCategoryVC alloc] init]];
                     DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];
                     
                     REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
                     frostedViewController.direction = REFrostedViewControllerDirectionLeft;
                     frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
                     frostedViewController.liveBlur = YES;
                     frostedViewController.delegate = self;
                     [self.navigationController pushViewController:frostedViewController animated:YES];
                     
                     
                     //        mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC" bundle:nil];
                     //        [self.navigationController pushViewController:mainCategoryVC animated:YES];
                 
             }
             else
             {
                 [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userLocation"];
                 [[[UIAlertView alloc] initWithTitle:@"spencer's" message:[tempDict valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
                 manualLocationVC = [[ManualLocationVC alloc] initWithNibName:@"ManualLocationVC" bundle:nil];
                 manualLocationVC.flag = 10;
                 [self.navigationController pushViewController:manualLocationVC animated:NO];
             }
             [SVProgressHUD dismiss];
         }
     }];
}


- (NSDictionary *)addressDictionaryFromJSON:(id)JSON
{
    //NSlog(@"%@",JSON);
    NSMutableDictionary *addressDictionary = [[NSMutableDictionary alloc] init];
    addressDictionary[@"FormattedAddressLines"] = [((NSString *)[JSON valueForKey:@"formatted_address"]) componentsSeparatedByString:@", "];
    for (id component in [JSON valueForKey:@"address_components"]) {
        NSArray *types = [component valueForKey:@"types"];
        id longName = [component valueForKey:@"long_name"];
        id shortName = [component valueForKey:@"short_name"];
        for (NSString *type in types) {
            if ([type isEqualToString:@"postal_code"]) {
                addressDictionary[@"ZIP"] = longName;
            }
            else if ([type isEqualToString:@"country"]) {
                addressDictionary[@"Country"] = longName;
                addressDictionary[@"CountryCode"] = shortName;
            }
            else if ([type isEqualToString:@"administrative_area_level_1"]) {
                addressDictionary[@"State"] = longName;
            }
            else if ([type isEqualToString:@"administrative_area_level_2"]) {
                addressDictionary[@"SubAdministrativeArea"] = longName;
            }
            else if ([type isEqualToString:@"locality"]) {
                addressDictionary[@"City"] = longName;
            }
            else if ([type isEqualToString:@"sublocality"]) {
                addressDictionary[@"SubLocality"] = longName;
            }
            else if ([type isEqualToString:@"establishment"]) {
                addressDictionary[@"Name"] = longName;
            }
            else if ([type isEqualToString:@"route"]) {
                addressDictionary[@"Thoroughfare"] = longName;
            }
            else if ([type isEqualToString:@"street_number"]) {
                addressDictionary[@"SubThoroughfare"] = longName;
            }
        }
    }
    return addressDictionary
    ;
}


- (IBAction)manualLocationBtnAct:(UIButton *)sender {
    [self findCurrentLocation];
    manualLocationVC = [[ManualLocationVC alloc] initWithNibName:@"ManualLocationVC" bundle:nil];
    manualLocationVC.flag = 10;
    [self.navigationController pushViewController:manualLocationVC animated:NO];
}

- (IBAction)MainCategoryBtnAct:(UIButton *)sender {
    
    DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[MainCategoryVC alloc] init]];
    DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
    [self.navigationController pushViewController:frostedViewController animated:YES];
}


#pragma mark StartupService

-(void)getCartWishlist
{
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token = [temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret = [temp objectForKey:@"oauth_token_secret"];
    
    NSString *urlStr1;
    
    UIDevice *device = [UIDevice currentDevice];
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString * str=   [NSString stringWithCString:systemInfo.machine
                                         encoding:NSUTF8StringEncoding];
    
    if ( ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"devicetoken"] length] > 10 ))
    {
        
        //        NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        
        //        /startups?store=%@&ostype=
        //        [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]
        
        urlStr1 = [NSString stringWithFormat:@"%@/startups?deviceid=%@&regid=%@&store=%@&ostype=%@&deviceversion=%@&mobmodel=%@&version=%@&cartid=%@", baseUrl1, currentDeviceId, [[NSUserDefaults standardUserDefaults] valueForKey:@"devicetoken"] , [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"], @"iOS", [[UIDevice currentDevice] systemVersion], str, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
    }
    else
    {
        urlStr1 = [NSString stringWithFormat:@"%@/startups?store=%@&ostype=%@&deviceversion=%@&mobmodel=%@&version=%@&cartid=%@", baseUrl1, [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"], @"iOS", [[UIDevice currentDevice] systemVersion], str, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        //        url = urlStr1;
    }
    
    
//    NSLog(@"urlStr1 %@", urlStr1);
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        NSURL *url = [NSURL URLWithString:urlStr1];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 NSMutableDictionary *tempDict;
                 tempDict = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
//                 NSLog(@"startup response %@", tempDict);
                 if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                 {
                     if ([[tempDict valueForKey:@"cartid"] isKindOfClass:[NSNull class]])
                     {
                         [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"globalcartid"];
                         appDele.bangeStr = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
                        return ;
                     }
                     else{
                         [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"cartid"] forKey:@"globalcartid"];
                         
                         appDele.bangeStr = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
                     }
                 }
                 else if ([[tempDict valueForKey:@"message"] isKindOfClass:[NSString class]])
                 {
                     if ([[tempDict valueForKey:@"message"] length] > 0 )
                     {
                         [[[UIAlertView alloc] initWithTitle:@"spencer's" message:[tempDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
                     }
                 }
                 else
                 {
                     [[[UIAlertView alloc] initWithTitle:@"spencer's" message:[tempDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
                 }
                 
             }
         }];
    }
    else
    {
        NSDictionary *tempDict = [Webmethods getCartWishlist:urlStr1];
        
//        NSLog(@"startup response %@", tempDict);
        if ([[tempDict valueForKey:@"status"] integerValue] == 1)
        {
            if ([[tempDict valueForKey:@"cartid"] isKindOfClass:[NSNull class]])
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"globalcartid"];
                appDele.bangeStr = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
                return ;
            }
            else{
                [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"cartid"] forKey:@"globalcartid"];
                
                appDele.bangeStr = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
            }
        }
        else if ([[tempDict valueForKey:@"message"] isKindOfClass:[NSString class]])
        {
            if ([[tempDict valueForKey:@"message"] length] > 0 )
            {
                [[[UIAlertView alloc] initWithTitle:@"spencer's" message:[tempDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            }
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"spencer's" message:[tempDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
        
    }
    
}
@end
