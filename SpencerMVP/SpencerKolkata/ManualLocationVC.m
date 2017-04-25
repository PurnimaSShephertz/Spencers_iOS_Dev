//
//  ManualLocationVC.m
//  SpencerKolkata
//
//  Created by binary on 30/06/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "ManualLocationVC.h"
#import "ToastAlert.h"
#import "Webmethods.h"
#import "MainCategoryVC.h"
#import "DEMONavigationController.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "CoreLocationController.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface ManualLocationVC ()
{
    NSArray *cityArray;
    
    NSArray *locationArr, *allLocationData;
    MainCategoryVC *mainCategoryVC;
    UILabel * bangeLbl;
    AppDelegate *appDele;
    
}

@end

@implementation ManualLocationVC
@synthesize searchBar1;

#pragma mark ViewLifeCycle
- (void) checkLocationServicesTurnedOn
{
    if (![CLLocationManager locationServicesEnabled])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"== Opps! =="
                                                        message:@"Hello! Please turn on your location or type in your location to help us serve you better."
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

//-(void) checkApplicationHasLocationServicesPermission
//{
//    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"== Opps! =="
//                                                        message:@"This application needs 'Location Services' to be turned on."
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//    }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"Manual Location Screen";
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [self.searchBar1 setReturnKeyType:UIReturnKeyDone];
    [self.searchBar1 setEnablesReturnKeyAutomatically:NO];
    
    //    searchBar.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"userLocation"];
    
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDele.navigationBool = 10;
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    screenX = [UIScreen mainScreen].bounds.origin.x;
    screenY =[UIScreen mainScreen].bounds.origin.y;
    
    
    
    //    locationImgVew.hidden = NO;
    //    locationTitLbl.hidden = NO;
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(setCorrectFocus) withObject:NULL afterDelay:0.2];
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO)
    {
        return ;
    }
    [SVProgressHUD show];
    
    
    
    
    
             dispatch_async(dispatch_get_main_queue(), ^{
    
                 [SVProgressHUD dismiss];
                 allLocationDataIs = [Webmethods searchArea];
                 locationArr = [[NSArray alloc] init];
                 NSArray *locationTempArr = [allLocationDataIs allKeys];
                 for (int i = 0; i < locationTempArr.count; i++)
                 {
                     NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[locationArr arrayByAddingObjectsFromArray:[allLocationDataIs valueForKey:[locationTempArr objectAtIndex:i]]]];
                     locationArr = tempArr;
                 }
                 allLocationData = locationArr;
    
                 locationArr = nil;
                 [locationTblVew reloadData];
    
                 filteredContentList = [[NSMutableArray alloc] init];
                 cityArray = [[NSArray alloc] initWithObjects:@"Kolkata", @"Delhi NCR", nil];
    
                 locationTblVew.hidden = YES;
             });
             dispatch_async(dispatch_get_main_queue(), ^{
    
                 [SVProgressHUD dismiss];
                 allLocationDataIs = [Webmethods searchArea];
                 locationArr = [[NSArray alloc] init];
                 NSArray *locationTempArr = [allLocationDataIs allKeys];
                 for (int i = 0; i < locationTempArr.count; i++)
                 {
                     NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[locationArr arrayByAddingObjectsFromArray:[allLocationDataIs valueForKey:[locationTempArr objectAtIndex:i]]]];
                     locationArr = tempArr;
                 }
                 allLocationData = locationArr;
    
                 locationArr = nil;
                 [locationTblVew reloadData];
    
                 filteredContentList = [[NSMutableArray alloc] init];
                 cityArray = [[NSArray alloc] initWithObjects:@"Kolkata", @"Delhi NCR", nil];
    
                 locationTblVew.hidden = YES;
             });

    
    
    
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1]];
//    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
//                                                            path:area
//                                                      parameters:nil];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         NSError *jsonError = nil;
//         [SVProgressHUD dismiss];
//         id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
//         
//         
//         locationArr = [[NSArray alloc] init];
//         NSArray *locationTempArr = [result allKeys];
//         for (int i = 0; i < locationTempArr.count; i++)
//         {
//             NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[locationArr arrayByAddingObjectsFromArray:[result valueForKey:[locationTempArr objectAtIndex:i]]]];
//             locationArr = tempArr;
//         }
//         allLocationData = locationArr;
//         
//         locationArr = nil;
//         [locationTblVew reloadData];
//         
//         filteredContentList = [[NSMutableArray alloc] init];
//         cityArray = [[NSArray alloc] initWithObjects:@"Kolkata", @"Delhi NCR", nil];
//         
//         locationTblVew.hidden = YES;
//         
//         
//         
//         
//     }
//     
//                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         NSLog(@"Error: %@", error);
//         [SVProgressHUD dismiss];
//     }];
//    [operation start];
    
    
    
    
    
    //    if (locationArr.count < 1)
    //    {
    //        locationTblVew.hidden = YES;
    //    }
    //    else
    //    {
    //        locationTblVew.hidden = NO;
    //    }
    
    //allLocationDataIs = [Webmethods searchArea];
    //    locationArr = [[NSArray alloc] init];
    //    NSArray *locationTempArr = [allLocationDataIs allKeys];
    //    for (int i = 0; i < locationTempArr.count; i++)
    //    {
    //        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[locationArr arrayByAddingObjectsFromArray:[allLocationDataIs valueForKey:[locationTempArr objectAtIndex:i]]]];
    //        locationArr = tempArr;
    //    }
    //    allLocationData = locationArr;
    //    [locationTblVew reloadData];
    //    filteredContentList = [[NSMutableArray alloc] init];
    //    cityArray = [[NSArray alloc] initWithObjects:@"Kolkata", @"Delhi NCR", nil];
    //
    //    locationTblVew.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    shouldBeginEditing = YES;
    self.navigationController.navigationBar.barTintColor = kColor_gray;
    bangeLbl.hidden = YES;
    [self navigationView];
}

-(void) setCorrectFocus
{
    //    [self.searchController setActive:YES];
    //    [self.searchController.searchBar becomeFirstResponder];
    [searchBar1 becomeFirstResponder];
}
-(void)navigationView
{
    UIButton *backBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"ic_left_arw.png"];
    //    [backBtn setBackgroundColor:[UIColor redColor]];
    
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0f, -30.0f, 0.0f, 0.0f);
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *menubutton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:menubutton , nil]];
    self.navigationItem.leftBarButtonItem = menubutton;
    
    UIButton *titleLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [titleLabelButton setTitle:@"Delivery Location" forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    //    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleLabelButton;
    
    NSMutableArray *arrRightBarItems = [[NSMutableArray alloc] init];
    
    
    //    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *btnLib = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLib setImage:[UIImage imageNamed:@"ic_loc.png"] forState:UIControlStateNormal];
    btnLib.frame = CGRectMake(0, 0, 32, 32);
    ////btnLib.showsTouchWhenHighlighted=YES;
    [btnLib addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:btnLib];
    [arrRightBarItems addObject:barButtonItem2];
    
    
    //    [btnSetting setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
    //    btnSetting.frame = CGRectMake(0, 0, 32, 32);
    //    //btnSetting.showsTouchWhenHighlighted=YES;
    //    [btnSetting addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    //    [arrRightBarItems addObject:barButtonItem];
    
    //    bangeLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,-5 , 18, 18)];
    //    bangeLbl.text = appDele.bangeStr;
    //    bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:11];
    //    bangeLbl.backgroundColor = [UIColor clearColor];
    //    bangeLbl.textColor = [UIColor whiteColor];
    //    bangeLbl.textAlignment = NSTextAlignmentCenter;
    //    bangeLbl.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:149.0/255.0 blue:59.0/255.0 alpha:1];
    //    bangeLbl.layer.cornerRadius = 9;
    //    bangeLbl.layer.masksToBounds = YES;
    //    bangeLbl.layer.borderColor = [UIColor whiteColor].CGColor;
    //    bangeLbl.layer.borderWidth = 1;
    //
    //    [btnLib addSubview:bangeLbl];
    if ([bangeLbl.text integerValue] > 0)
    {
        bangeLbl.hidden = NO;
    }
    else
    {
        bangeLbl.hidden = YES;
    }
    self.navigationItem.rightBarButtonItems=arrRightBarItems;
}



- (void)didReceiveMemoryWarning {
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


#pragma mark buttonActions
- (IBAction)backBtnAct:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)threadStartAnimating13
{
    [SVProgressHUD show];
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
- (IBAction)currentLocationBtnAct:(UIButton *)sender
{
    
    
    [self checkLocationServicesTurnedOn];
    
    //
    //    if (![CLLocationManager locationServicesEnabled]) {
    //
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Service Disabled"
    //                                                        message:@"To re-enable, please go to Settings and turn on Location Service for this app."
    //                                                       delegate:nil
    //                                              cancelButtonTitle:@"OK"
    //                                              otherButtonTitles:nil];
    //        [alert show];
    //
    //
    //    }
    
}

-(void)getAddress1
{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%@%%2C%@&sensor=true", appDele.latstr, appDele.longstr]];
    
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
                if (addressLines)
                {
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
            
            
            [SVProgressHUD dismiss];
        }
        else
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"GPS Not Stable!"]];
            [SVProgressHUD dismiss];
        }
    } failure:nil];
    [SVProgressHUD dismiss];
    [operation start];
    
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


#pragma mark TableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[locationArr objectAtIndex:indexPath.row] valueForKey:@"label"]];
    UIImageView *seperatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(screenX, 43, width, 1)];
    seperatorImg.backgroundColor = kColor_Orange;
    [cell addSubview:seperatorImg];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchBar1.text = [NSString stringWithFormat:@"%@", [[locationArr objectAtIndex:indexPath.row] valueForKey:@"label"]];
    
    AddressStr = [[locationArr objectAtIndex:indexPath.row] valueForKey:@"label"];
    [self Submit_Pin:[[locationArr objectAtIndex:indexPath.row] valueForKey:@"value"]];
    
    //    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [[locationArr objectAtIndex:indexPath.row] valueForKey:@"label"]] forKey:@"userLocation"];
    [searchBar1 resignFirstResponder];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isSearching) {
        return [filteredContentList count];
    }
    else{
        return locationArr.count;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


//-(BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}
//
//
//- (BOOL)textField:(UITextField *)textField
//shouldChangeCharactersInRange:(NSRange)range
//replacementString:(NSString *)string {
//    //  autocompleteTableView.hidden = NO;
//
////    if (CheckPopUp==YES)
////    {
////        UsersListArray = tempArr;
//
//        NSString *substring = [NSString stringWithString:selectDeliveryLocationTxtFld.text];
//        substring = [substring
//                     stringByReplacingCharactersInRange:range withString:string];
//        [self searchAutocompleteEntriesWithSubstring:substring];
////    }
////    else
////    {
////
////
////    }
//    return YES;
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark UISearchBar
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    [searchBar setShowsCancelButton:YES animated:YES];
    locationTblVew.frame = CGRectMake(screenX, 108, width, height-108-220);
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    locationTblVew.frame = CGRectMake(screenX, 108, width, height-108);
}

//- (void)searchTableList {
//    NSString *searchString = searchBar1.text;
//
//    for (NSString *tempStr in locationArr)
//    {
//        NSComparisonResult result = [tempStr compare:searchString options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchString length])];
//
//
//
//
//
//
//        if (result == NSOrderedSame)
//        {
//            [filteredContentList addObject:tempStr];
//            locationImgVew.hidden = YES;
//            locationTitLbl.hidden = YES;
//            locationTblVew.hidden = NO;
//        }
//        else
//        {
//            locationImgVew.hidden = NO;
//            locationTitLbl.hidden = NO;
//            locationTblVew.hidden = YES;
//        }
//    }
//}
//
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)bar {
    // reset the shouldBeginEditing BOOL ivar to YES, but first take its value and use it to return it from the method call
    BOOL boolToReturn = shouldBeginEditing;
    shouldBeginEditing = YES;
    return boolToReturn;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    //    [filteredContentList removeAllObjects];
    //
    //    if([searchText length] != 0)
    //    {
    //        [locationTblVew reloadData];
    //    }
    //    else
    //    {
    //
    //        [searchBar resignFirstResponder];
    //        [self.view endEditing:YES];
    //        locationImgVew.hidden = NO;
    //        locationTitLbl.hidden = NO;
    //        locationTblVew.hidden = YES;
    //        [locationTblVew reloadData];
    //
    //    }
    if (![searchBar1 isFirstResponder]) {
        
        [self searchAutocompleteEntriesWithSubstring:searchBar1.text];
        // The user clicked the [X] button while the keyboard was hidden
        shouldBeginEditing = NO;
    }
    else if ([searchText length] == 0)
    {
        // The user clicked the [X] button or otherwise cleared the text.
        [self performSelector: @selector(resignFirstResponder1)
                   withObject: nil
                   afterDelay: 0.1];
    }
    
}

-(void)resignFirstResponder1
{
    [searchBar1 resignFirstResponder];
    [self.view endEditing:YES];
    locationImgVew.hidden = NO;
    locationTitLbl.hidden = NO;
    locationTblVew.hidden = YES;
    [locationTblVew reloadData];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
//    NSLog(@"Cancel clicked");
    searchBar.text = @"";
    //    allLocationDataIs = [Webmethods searchArea];
    //    locationArr = [[NSArray alloc] init];
    //    NSArray *locationTempArr = [allLocationDataIs allKeys];
    //    for (int i = 0; i < locationTempArr.count; i++)
    //    {
    //        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[locationArr arrayByAddingObjectsFromArray:[allLocationDataIs valueForKey:[locationTempArr objectAtIndex:i]]]];
    //        locationArr = tempArr;
    //    }
    //    allLocationData = locationArr;
    
    locationImgVew.hidden = NO;
    locationTitLbl.hidden = NO;
    locationTblVew.hidden = YES;
    [locationTblVew reloadData];
    [searchBar resignFirstResponder];
}

//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    NSLog(@"Search Clicked");l
//    [self searchTableList];
//}


-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *substring = [NSString stringWithString:searchBar1.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:text];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring
{
    [filteredContentList removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"label contains[cd] %@", substring];
    locationArr = [allLocationData filteredArrayUsingPredicate:predicate];
//    NSLog(@"result count %lu", (unsigned long)locationArr.count);
    if (locationArr.count > 0)
    {
        locationTblVew.hidden = NO;
    }
    else
    {
        
        locationTblVew.hidden = YES;
    }
    
    if (locationArr.count < 1)
    {
        locationImgVew.hidden = NO;
        locationTitLbl.hidden = NO;
        locationTblVew.hidden = YES;
    }
    else
    {
        locationImgVew.hidden = YES;
        locationTitLbl.hidden = YES;
        locationTblVew.hidden = NO;
    }
    
    [locationTblVew reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self searchAutocompleteEntriesWithSubstring:searchBar1.text];
//    NSCharacterSet *invalidCharSet = [[[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"] invertedSet] invertedSet];
//    NSString *filtered = [[searchBar1.text componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
//    if ([filtered length] == 6)
//    {
//        [self Submit_Pin:searchBar1.text];
//    }
    [searchBar resignFirstResponder];
    
    
    
}

//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    locationArr = [[NSArray alloc] init];
//    NSArray *locationTempArr = [allLocationDataIs allKeys];
//    for (int i = 0; i < locationTempArr.count; i++)
//    {
//        NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[locationArr arrayByAddingObjectsFromArray:[allLocationDataIs valueForKey:[locationTempArr objectAtIndex:i]]]];
//        locationArr = tempArr;
//    }
//    allLocationData = locationArr;
//    [locationTblVew reloadData];
//}



- (void)Submit_Pin:(NSString *)pin
{
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO)
    {
        return ;
    }
    [SVProgressHUD show];
    
    
    //     NSURL *PinCheck_URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/validate/pincode?pincode=%@", baseUrl1, pin]];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                            path:[NSString stringWithFormat:@"%@/validate/pincode?pincode=%@", baseUrl1, pin]
                                                      parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *jsonError = nil;
         [SVProgressHUD dismiss];
         id tempDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
         
         if ([[tempDict valueForKey:@"status"] integerValue] == 1)
         {
             if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"store_id"] isEqualToString:[[tempDict valueForKey:@"data"] valueForKey:@"store_id"]])
             {
                 [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"globalcartid"];
             }
             
             [[NSUserDefaults standardUserDefaults] setValue:AddressStr forKey:@"userLocation"];
             
             //                     [launchView setHidden:YES];
             NSString * storeID=[[tempDict valueForKey:@"data"] valueForKey:@"store_id"];
             [[NSUserDefaults standardUserDefaults]setValue:storeID forKey:@"store_id_token"];
             NSString * store_name=[[tempDict valueForKey:@"data"] valueForKey:@"store_name"];
             [[NSUserDefaults standardUserDefaults]setValue:store_name forKey:@"store_name_token"];
             [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"checklandscreen"];
             NSString *rstring = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_name_token"];
//             NSLog(@"rstring %@", rstring);
             
             [self getCartWishlist];
             if ([_headercheck isEqualToString:@"1001"])
             {
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 
             }
             
             
             
             
             [[NSUserDefaults standardUserDefaults] synchronize];
             locationTblVew.hidden = YES;
             [searchBar1 resignFirstResponder];
             
             [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSideMenu" object:nil];
             
             if (_flag == 10) {
                 //
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
                 [self.navigationController popViewControllerAnimated:YES];
             }
             
         }
         else
         {
             [[[UIAlertView alloc] initWithTitle:@"spencer's" message:[tempDict valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
         }
         
         
         
         
     }
     
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
//         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
     }];
    [operation start];
    
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
