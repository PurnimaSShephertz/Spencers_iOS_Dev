//
//  DEMOMenuViewController.m
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOMenuViewController.h"
#import "MainCategoryVC.h"
#import "DEMONavigationController.h"
//#import "CurrentBookingViewController.h"
//#import "Booking_HistoryViewController.h"
//#import "Track_MyCabViewController.h"
//#import "FeedbackViewController.h"
//#import "Favourite_PlacesViewController.h"
//#import "ProfileViewController.h"
//#import "Fares_ViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "LoginVC.h"
#import "RegistrationVC.h"


#import "Webmethods.h"

#import "iRate.h"






@implementation DEMOMenuViewController
@synthesize distcel;

- (void)initialize
{
    //set the bundle ID. normally you wouldn't need to do this
    //as it is picked up automatically from your Info.plist file
    //but we want to test with an app that's actually on the store
    [iRate sharedInstance].applicationBundleID = @"com.binary.Spencers";
    [iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    
    //enable preview mode
    [iRate sharedInstance].previewMode = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    width = [UIScreen mainScreen].bounds.size.width;
    temp=[NSUserDefaults standardUserDefaults];
    oauth_token = [temp objectForKey:@"oauth_token"];
    
    
    //self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // self.tableView.opaque = NO;
    self.tableView.scrollEnabled=YES;
    // [self.tableView setSectionIndexColor:NO];
    // [self.tableView setSeparatorColor:[UIColor lightGrayColor]];
    self.tableView.showsVerticalScrollIndicator = YES;
    
    titles = @[@"About Us", @"FAQ", @"Privacy Policy",@"Terms & Conditions",@"Contact Us",@"Rate Us"];
//    images_array = @[@"current_booking-1.png", @"booking_history.png", @"track_my_cab.png",@"feedback-icon.png",@"profile-1.png",@"fare_icon.png",@"logout.png"];
    
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,10, 0, 165.0f)];
        //[self.tableView setBackgroundColor:[UIColor whiteColor]];
        
        //        NSMutableDictionary * userdata = [[NSMutableDictionary alloc]init];
        //        userdata = [[[NSUserDefaults standardUserDefaults]arrayForKey:@"UserDetails"] objectAtIndex:0];
        //         NSString * str=[userdata objectForKey:@"FirstName"];
        //        NSString * str1=[userdata objectForKey:@"MiddleName"];
        //        NSString * str2=[userdata objectForKey:@"LastName"];
        //        NSString * str3=[NSString stringWithFormat:@"%@, %@, %@",str,str1,str2];
        
        Login_Button = [[UIButton alloc] initWithFrame:CGRectMake(40, 25, 70, 40)];
        SigUp_Burron = [[UIButton alloc] initWithFrame:CGRectMake(150, 25, 70, 40)];
        userNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 25, 100, 40)];

        userDict= [[NSDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"]];

        
        if (oauth_token.length < 1)
        {
            [Login_Button setTitle:@"Login" forState:UIControlStateNormal];
            
            [SigUp_Burron setTitle:@"Signup" forState:UIControlStateNormal];
            SigUp_Burron.titleLabel.font = [UIFont fontWithName: @"Helvetica Neue" size: 17];
            [SigUp_Burron setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [SigUp_Burron  addTarget:self  action:@selector(SignUp_Act:)  forControlEvents:UIControlEventTouchUpInside ];
            [view addSubview:SigUp_Burron];
            userNameLbl.hidden = YES;
            [view addSubview:userNameLbl];
            Login_Button.frame = CGRectMake(40, 25, 70, 40);
            userNameLbl.text = [NSString stringWithFormat:@"Hi! %@", [[userDict valueForKey:@"data"] valueForKey:@"firstname"]];
            
        }
        else
        {
            [Login_Button setTitle:@"Logout" forState:UIControlStateNormal];
            SigUp_Burron.titleLabel.font = [UIFont fontWithName: @"Helvetica Neue" size: 17];
            [SigUp_Burron setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [SigUp_Burron  addTarget:self  action:@selector(SignUp_Act:)  forControlEvents:UIControlEventTouchUpInside ];
            [view addSubview:SigUp_Burron];
            userNameLbl.text = [NSString stringWithFormat:@"Hi! %@", [[userDict valueForKey:@"data"] valueForKey:@"firstname"]];
            userNameLbl.hidden = NO;
            [view addSubview:userNameLbl];
            Login_Button.frame = CGRectMake(150, 25, 70, 40);
//            SigUp_Burron = [[UIButton alloc] initWithFrame:CGRectMake(150, 25, 70, 40)];
//            [SigUp_Burron setTitle:@"Signup" forState:UIControlStateNormal];
//            SigUp_Burron.titleLabel.font = [UIFont fontWithName: @"Helvetica Neue" size: 17];
//            [SigUp_Burron setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//            //        SigUp_Burron.layer.rasterizationScale = [UIScreen mainScreen].scale;
//            //        SigUp_Burron.layer.shouldRasterize = YES;
//            //        SigUp_Burron.clipsToBounds = YES;
//            [SigUp_Burron  addTarget:self  action:@selector(SignUp_Act:)  forControlEvents:UIControlEventTouchUpInside ];
//            [view addSubview:SigUp_Burron];
        }
        Login_Button.titleLabel.font = [UIFont fontWithName: @"Helvetica Neue" size: 17];
        [Login_Button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [Login_Button  addTarget:self  action:@selector(Login_Act:)  forControlEvents:UIControlEventTouchUpInside ];
        [view addSubview:Login_Button];
        
       
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(23, 70, self.tableView.frame.size.width-96, 1)];
        label.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:label];
        
        UILabel *Delivery = [[UILabel alloc] initWithFrame:CGRectMake(40, 91, 270, 30)];
        Delivery.text =@"Delivery Location";
        Delivery.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        Delivery.backgroundColor = [UIColor clearColor];
        Delivery.textColor = [UIColor darkGrayColor];
        [Delivery sizeToFit];
        //Delivery.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [view addSubview:Delivery];
        
        Address = [[UILabel alloc] initWithFrame:CGRectMake(40, 101, self.tableView.frame.size.width-150, 70)];
        Address.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"userLocation"];
        Address.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
        Address.backgroundColor = [UIColor clearColor];
        Address.textColor = [UIColor darkGrayColor];
        Address.numberOfLines=3;
        Address.minimumFontSize = 9;
        Address.adjustsFontSizeToFitWidth = YES;
        //[Address sizeToFit];
        // Address.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [view addSubview:Address];
        
        
        Edit_button = [[UIButton alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width-90, 130, 15, 15)];
        [Edit_button setBackgroundImage:[UIImage imageNamed:@"ic_edit.png"] forState:UIControlStateNormal];
        // [Edit_button  addTarget:self  action:@selector(Edit_Act:)  forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Edit_button];
        
        FullAddress_Button = [[UIButton alloc] initWithFrame:CGRectMake(50, 101, self.tableView.frame.size.width-105, 65)];
        [FullAddress_Button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [FullAddress_Button  addTarget:self  action:@selector(Edit_Act:)  forControlEvents:UIControlEventTouchUpInside];
        [FullAddress_Button setBackgroundColor:[UIColor clearColor]];
        [view addSubview:FullAddress_Button];
        
        
        UIButton * addressBtbObj = [[UIButton alloc] initWithFrame:CGRectMake(40, 75,  self.tableView.frame.size.width-115, 85)];
        [addressBtbObj setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [addressBtbObj  addTarget:self  action:@selector(Edit_Act:)  forControlEvents:UIControlEventTouchUpInside];
        [addressBtbObj setBackgroundColor:[UIColor clearColor]];
        [view addSubview:addressBtbObj];
        
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(23, 161, self.tableView.frame.size.width-96, 1)];
        label1.backgroundColor = [UIColor orangeColor];
        [view addSubview:label1];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateSideMenu)
                                                     name:@"updateSideMenu" object:nil];
        
        view;
    });
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {  // Safety check for below iOS 7
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)updateSideMenu
{
    userDict= [[NSDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"]];
    
    oauth_token = [temp objectForKey:@"oauth_token"];
    Address.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"userLocation"];
//    NSLog(@"notification called");
    
    if (oauth_token.length < 1)
    {
        [Login_Button setTitle:@"Login" forState:UIControlStateNormal];
        [SigUp_Burron setTitle:@"Signup" forState:UIControlStateNormal];
        SigUp_Burron.hidden = NO;
        Login_Button.frame = CGRectMake(40, 25, 70, 40);
        userNameLbl.text = [NSString stringWithFormat:@"Hi! %@", [[userDict valueForKey:@"data"] valueForKey:@"firstname"]];
        userNameLbl.hidden = YES;
    }
    else
    {
        userNameLbl.text = [NSString stringWithFormat:@"Hi! %@", [[userDict valueForKey:@"data"] valueForKey:@"firstname"]];
        [Login_Button setTitle:@"Logout" forState:UIControlStateNormal];
        [SigUp_Burron setTitle:@"Signup" forState:UIControlStateNormal];
        SigUp_Burron.hidden = YES;
        Login_Button.frame = CGRectMake(150, 25, 70, 40);
        userNameLbl.text = [NSString stringWithFormat:@"Hi! %@", [[userDict valueForKey:@"data"] valueForKey:@"firstname"]];
        userNameLbl.hidden = NO;
    }
}

-(void)Login_Act:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Login"])
    {
//        loginVC = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
//        loginVC.checkdrawermenu =@"2222";
//        [self.navigationController pushViewController:loginVC animated:YES];
        
        loginVC= [[LoginVC alloc] init];
        loginVC.checkdrawermenu=@"2222";
        DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:loginVC];
        self.frostedViewController.contentViewController = navigationController;
        [self.frostedViewController hideMenuViewController];
    }
    else
    {
        [Login_Button setTitle:@"Login" forState:UIControlStateNormal];
        
        
        
        NSString *timeStamp =  [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
        NSString *lastFourChar = [timeStamp substringFromIndex:[timeStamp length] - 4];
        int r = arc4random() % 100000;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"globalcartid"];
//        NSLog(@"Random Number %i", r);
//        NSLog(@"time stamp %@", timeStamp);
//        NSLog(@"lastFourChar %@", lastFourChar);
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CustomerDict"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token"];
        appDele.bangeStr = @"0";
        temp=[NSUserDefaults standardUserDefaults];
        oauth_token =[temp objectForKey:@"oauth_token"];
        
        DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[MainCategoryVC alloc] init]];
        DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];
        
        REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
        frostedViewController.direction = REFrostedViewControllerDirectionLeft;
        frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
        frostedViewController.liveBlur = YES;
        frostedViewController.delegate = self;
        [self.navigationController pushViewController:frostedViewController animated:YES];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSideMenu" object:nil userInfo:nil];
    }
}
-(void)SignUp_Act:(UIButton *)sender
{
    registrationVC = [[RegistrationVC alloc] initWithNibName:@"RegistrationVC" bundle:nil];
    registrationVC.Skipcheck = @"003";
    [self.navigationController pushViewController:registrationVC animated:YES];
}
-(void)Edit_Act:(UIButton *)sender
{
    manualLocationVC = [[ManualLocationVC alloc] initWithNibName:@"ManualLocationVC" bundle:nil];
    [self.navigationController pushViewController:manualLocationVC animated:YES];
}
#pragma mark -
#pragma mark UITableView Datasource
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    listViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"listViewCell" owner:self options:nil];
        
        
        cell =distcel;
        
    }
    cell.itemlbl.text =[titles  objectAtIndex:indexPath.row];
    cell.itemlbl.textColor=[UIColor darkGrayColor];
    cell.itemlbl.font = [UIFont fontWithName: @"Helvetica Neue" size: 17];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // cell.itemimg.image=[UIImage imageNamed:[images_array objectAtIndex:indexPath.row]];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

#pragma mark -
#pragma mark UITableView Delegate


//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
//    return footer;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    //return @"                    Menu";
    return nil;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(48, 0, width, 40)];
    footer.backgroundColor = [UIColor whiteColor];
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:footer.frame];
//    lbl.backgroundColor = [UIColor redColor];
//    lbl.text = [NSString stringWithFormat:@"Version %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    lbl.textAlignment = NSTextAlignmentLeft;
    
    [footer addSubview:lbl];
    
    return footer;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 64;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
        profilepage=[[ProfilePage alloc ]initWithNibName:@"ProfilePage" bundle:nil];
//    }
//    else
//    {
//        profilepage=[[ProfilePage alloc ]initWithNibName:@"ProfilePage~iPad" bundle:nil];
//    }
    if (indexPath.row == 0)
    {
        profilepage.versionStr = [NSString stringWithFormat:@"Version %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        profilepage.htmlFile = [[NSBundle mainBundle] pathForResource:@"aboutus" ofType:@"html"];
        profilepage.TagUrl=@"";
        profilepage.headerStr = @"About Us";
    }
    else if (indexPath.row == 1)
    {
        profilepage.versionStr = [NSString stringWithFormat:@"Version %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        profilepage.htmlFile = [[NSBundle mainBundle] pathForResource:@"FAQ" ofType:@"html"];
        profilepage.TagUrl=@"";
        profilepage.headerStr = @"FAQ";
    }
    else if (indexPath.row == 2)
    {
        profilepage.versionStr = [NSString stringWithFormat:@"Version %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        profilepage.htmlFile = [[NSBundle mainBundle] pathForResource:@"privacy-policy" ofType:@"html"];
        profilepage.TagUrl=@"";
        profilepage.headerStr = @"Privacy Policy";
    }
    else if (indexPath.row == 3)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        profilepage.versionStr = [NSString stringWithFormat:@"Version %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        profilepage.TagUrl=@"Terms";
        profilepage.htmlFile = [NSString stringWithFormat:@"%@%@",solarSearchUrl,@"/index.php/terms-conditions?layout=empty"];
        profilepage.headerStr = @"Terms & Conditions";
    }
    else if (indexPath.row == 4)
    {
        profilepage.versionStr = [NSString stringWithFormat:@"Version %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//        profilepage.TagUrl=@"Terms";
        profilepage.htmlFile = [[NSBundle mainBundle] pathForResource:@"contact-us" ofType:@"html"];
        
//        profilepage.htmlFile = [NSString stringWithFormat:@"%@/index.php/contact-us?layout=empty", baseBannerUrl1];
        profilepage.headerStr = @"Contact Us";
    }
    else if (indexPath.row == 5)
    {
//        [self initialize];
        [self rateAppYes];
    }
    
    if (indexPath.row != 5)
    {
        [self.navigationController pushViewController:profilepage animated:YES];
    }
    
}

-(void)rateAppYes
{
    //    https://itunes.apple.com/in/app/gym-trace/id598154605?mt=8
    NSString * appId = @"1156464267";
    NSString * theUrl = [NSString  stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software",appId];
    if ([[UIDevice currentDevice].systemVersion integerValue] > 6) theUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:theUrl]];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    else
    {
        [self resetDefaults];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"loginpagecheck"];
        [self.navigationController popToRootViewControllerAnimated:NO];
        [self.frostedViewController hideMenuViewController];
    }
}
- (void)resetDefaults
{
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}
@end
