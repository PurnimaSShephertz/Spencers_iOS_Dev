//
//  MyProfileVC.m
//  CustomMenu
//
//  Created by Binarysemantics  on 6/8/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import "MyProfileVC.h"
#import "ProductVC.h"
#import "AppDelegate.h"
#import <sys/utsname.h>

#import "MainCategoryVC.h"
#import "CategoryPage.h"
#import "MyCreditsView.h"
#import "YourLocationVC.h"

#import "OfferVC.h"
#import "Const.h"

@interface MyProfileVC ()
{
    ProductVC *productVC;
    AppDelegate *appDelegate;
    MainCategoryVC *mainCategoryVC;
    ProductVC *itemDetailsVC;
    
    CategoryPage *Categoryvc;
    InCartVC *inCartVC;
    
    YourLocationVC *yourLocationVC;
}
@end

@implementation MyProfileVC
@synthesize cartBtnObj, footerImg, logoLargeImg, logoSmallImg, menuBtnObj, myProfileBtnObj, myProfileImg, searchBar, searchBtnObj, bangeLbl, logoLargeBtn;
- (void)alttextFieldDidEndEditing:(UITextField *)textField
{
}

- (void)alttextViewDidEndEditing:(UITextView *)textView
{
    
}

-(void)settingBtnAct:(UIButton *)sender
{
    
}

-(void)cartBtnAct:(UIButton *)sender
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screenName = @"My Profile Screen";
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    
    _Pin_Save.layer.cornerRadius = 20;
    _Pin_Save.layer.masksToBounds = YES;
    _Pin_Save.backgroundColor = kColor_Orange;
    
    
    
    //self.screenName = @"My Profile Screen";
    
    _searchBg.hidden = YES;
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
//    HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.navigationController.view addSubview:HUD];
//    HUD.delegate = self;
//    HUD.labelText = @"Loading";
    footerImg.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:132.0/255.0 blue:36.0/255.0 alpha:1] ;
    
    DictFinal=[[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"];
    
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"newsletter"] integerValue] != 0)
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"newsletter"] integerValue] == -1)
        {
            checkbox_check = YES;
            Check_Box_image.image=[UIImage imageNamed:@"checkbox_unchecked.png"];
        }
        else
        {
            checkbox_check = NO;
            Check_Box_image.image=[UIImage imageNamed:@"checkbox_checked.png"];
        }
    }
    else
    {
        NSString * is_subscribe =[[DictFinal valueForKey:@"data"] valueForKey:@"is_subscribe"];
        
        if ([is_subscribe  integerValue]==0)
        {
            checkbox_check = YES;
            Check_Box_image.image=[UIImage imageNamed:@"checkbox_unchecked.png"];
        }
        else
        {
            checkbox_check = NO;
            Check_Box_image.image=[UIImage imageNamed:@"checkbox_checked.png"];
        }
    }
    
    
    logoSmallImg.hidden = YES;
    searchBar.hidden = YES;
    logoLargeImg.hidden = NO;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    bangeLbl.text = appDelegate.bangeStr;
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
    if ([bangeLbl.text integerValue] > 0)
    {
        bangeLbl.hidden = NO;
    }
    else
    {
        bangeLbl.hidden = YES;
    }
    
    bangeLbl.layer.cornerRadius = 12;
    bangeLbl.layer.masksToBounds = YES;
    
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        lbl1.font = [UIFont fontWithName:@"Helvetica" size:15];
        lbl2.font = [UIFont fontWithName:@"Helvetica" size:15];
        lbl3.font = [UIFont fontWithName:@"Helvetica" size:15];
        lbl4.font = [UIFont fontWithName:@"Helvetica" size:15];
        lbl5.font = [UIFont fontWithName:@"Helvetica" size:15];
        lbl6.font = [UIFont fontWithName:@"Helvetica" size:17];
    }
    else
    {
        lbl1.font = [UIFont fontWithName:@"Helvetica" size:19];
        lbl2.font = [UIFont fontWithName:@"Helvetica" size:19];
        lbl3.font = [UIFont fontWithName:@"Helvetica" size:19];
        lbl4.font = [UIFont fontWithName:@"Helvetica" size:19];
        lbl5.font = [UIFont fontWithName:@"Helvetica" size:19];
        lbl6.font = [UIFont fontWithName:@"Helvetica" size:21];
    }
    
    
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.delegate = self;
    [launchView setHidden:YES];
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"LoginCheck"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"registrationpagecheck"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"profilecheck"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Addaddress"];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Pincheck"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"LoginCheck"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"registrationpagecheck"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"profilecheck"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Addaddress"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Pincheck"];
    
}

- (IBAction)inCartBtnAct:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    if ([bangeLbl.text integerValue] == 0)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Your Cart is Empty"]];
    }
    else
    {
        inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
        [self.navigationController pushViewController:inCartVC animated:YES];
    }
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
    
    
    [titleLabelButton setTitle:@"My Account" forState:UIControlStateNormal];
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
    [btnLib setImage:[UIImage imageNamed:@"ic_cart.png"] forState:UIControlStateNormal];
    btnLib.frame = CGRectMake(0, 0, 32, 32);
    //btnLib.showsTouchWhenHighlighted=YES;
    [btnLib addTarget:self action:@selector(inCartBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:btnLib];
    [arrRightBarItems addObject:barButtonItem2];
    
    
    //    [btnSetting setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
    //    btnSetting.frame = CGRectMake(0, 0, 32, 32);
    //    //btnSetting.showsTouchWhenHighlighted=YES;
    //    [btnSetting addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    //    [arrRightBarItems addObject:barButtonItem];
    
    bangeLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,-5 , 18, 18)];
    bangeLbl.text = appDelegate.bangeStr;
    bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:11];
    bangeLbl.backgroundColor = [UIColor clearColor];
    bangeLbl.textColor = [UIColor whiteColor];
    bangeLbl.textAlignment = NSTextAlignmentCenter;
    bangeLbl.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:149.0/255.0 blue:59.0/255.0 alpha:1];
    bangeLbl.layer.cornerRadius = 9;
    bangeLbl.layer.masksToBounds = YES;
    bangeLbl.layer.borderColor = [UIColor whiteColor].CGColor;
    bangeLbl.layer.borderWidth = 1;
    if ([bangeLbl.text integerValue] > 0)
    {
        bangeLbl.hidden = NO;
    }
    else
    {
        bangeLbl.hidden = YES;
    }
    [btnLib addSubview:bangeLbl];
    
    self.navigationItem.rightBarButtonItems=arrRightBarItems;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self navigationView];
    
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
    
    self.navigationController.navigationBar.hidden = NO;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        locationLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
    }
    else
    {
        locationLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
    }
    
    NSString *rstring = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_name_token"];
    [locationLbl setText:rstring];
    if ([bangeLbl.text integerValue] < 1)
    {
        bangeLbl.hidden = YES;
    }
    else
    {
        bangeLbl.hidden = NO;
    }
//    bangeLbl.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)searchBtnAct:(UIButton *)sender {
}

- (IBAction)backBtnAct:(UIButton *)sender {
    BOOL flag = NO;
    for (UIViewController *controller in self.navigationController.viewControllers)
    {
        if ([controller isKindOfClass:[MainCategoryVC class]])
        {
            flag = YES;
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
    if (flag == NO)
    {
        mainCategoryVC = [[MainCategoryVC alloc]initWithNibName:@"MainCategoryVC" bundle:nil];
        [self.navigationController pushViewController:mainCategoryVC animated:YES];
    }
//    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchBtnAct
{
    if (searchBar.hidden == YES)
    {
        [searchBar becomeFirstResponder];
        searchBar.hidden = NO;
        logoSmallImg.hidden = NO;
        logoLargeImg.hidden = YES;
        logoLargeBtn.hidden = YES;
        _searchBg.hidden = NO;
    }
    else
    {
        searchBar.hidden = YES;
        logoSmallImg.hidden = YES;
        logoLargeImg.hidden = NO;
        logoLargeBtn.hidden = NO;
        _searchBg.hidden = YES;
        [searchBar resignFirstResponder];
        if (searchBar.text.length > 0)
        {
//            SearchVC *searchVC;
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
//                searchVC = [[SearchVC alloc] initWithNibName:@"SearchVC" bundle:nil];
//            }
//            else
//            {
//                searchVC = [[SearchVC alloc] initWithNibName:@"SearchVC~iPad" bundle:nil];
//            }
//            searchVC.searchStr = searchBar.text;
//            searchVC.sortStr = @"Search";
//            [self.navigationController pushViewController:searchVC animated:NO];
        }
        else
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter the product name"]];
        }
    }
}


-(void)getCartWishlist
{
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    
    temp=[NSUserDefaults standardUserDefaults];
    oauth_token = [temp objectForKey:@"oauth_token"];
    oauth_token_secret = [temp objectForKey:@"oauth_token_secret"];
    
    NSString *urlStr1;
    
    UIDevice *device = [UIDevice currentDevice];
    NSString  *currentDeviceId = [[device identifierForVendor]UUIDString];
    
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString * str=   [NSString stringWithCString:systemInfo.machine
                                         encoding:NSUTF8StringEncoding];
    
    
    
    if ( ( [[[NSUserDefaults standardUserDefaults] valueForKey:@"devicetoken"] length] > 10 ))
    {
        urlStr1 = [NSString stringWithFormat:@"%@/startups?deviceid=%@&regid=%@&store=%@&ostype=%@&deviceversion=%@&mobmodel=%@&version=%@", baseUrl1, currentDeviceId, [[NSUserDefaults standardUserDefaults] valueForKey:@"devicetoken"] , [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"], @"iOS", [[UIDevice currentDevice] systemVersion], str, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    }
    else
    {
        urlStr1 = [NSString stringWithFormat:@"%@/startups?store=%@&ostype=%@&deviceversion=%@&mobmodel=%@&version=%@", baseUrl1, [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"], @"iOS", [[UIDevice currentDevice] systemVersion], str, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    }
    
    
    
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
                 if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                 {
                     appDelegate.bangeStr = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
                     bangeLbl.text = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
                     if ([bangeLbl.text integerValue] > 0)
                     {
                         bangeLbl.hidden = NO;
                     }
                     else
                     {
                         bangeLbl.hidden = YES;
                     }
                     
                 }
                 else
                 {
                     //                      [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                     
                     [[[UIAlertView alloc] initWithTitle:@"spencer's" message:[tempDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
                     
                 }
                 
             }
         }];
    }
    else
    {
        NSDictionary *tempDict = [Webmethods getCartWishlist:urlStr1];
        
        if ([[tempDict valueForKey:@"status"] integerValue] == 1)
        {
            appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
            bangeLbl.text = appDelegate.bangeStr;
            if ([bangeLbl.text integerValue] > 0)
            {
                bangeLbl.hidden = NO;
                InCartVC *placeOrderVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
                [self.navigationController pushViewController:placeOrderVC animated:YES];
            }
            else
            {
                bangeLbl.hidden = YES;
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
        else
        {
            
            [[[UIAlertView alloc] initWithTitle:@"spencer's" message:[tempDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
        
    }
    
}


- (IBAction)Submit_Pin:(id)sender
{
     [Pin_Txt resignFirstResponder];
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    if ([Pin_Txt.text length]<6)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter six digits pincode"]];
    }
    else{
    [SVProgressHUD show];
    NSURL *PinCheck_URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/validate/pincode?pincode=%@?store=%@", baseUrl1, Pin_Txt.text, [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]]];
    
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
                 [launchView setHidden:YES];
                 if ([[[tempDict valueForKey:@"data"] valueForKey:@"store_id"] integerValue] == [[[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"] integerValue])
                 {
                     
                 }
                 else
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"globalcartid"];
                 }
                 
                 NSString * storeID=[[tempDict valueForKey:@"data"] valueForKey:@"store_id"];
                 [[NSUserDefaults standardUserDefaults]setValue:storeID forKey:@"store_id_token"];
                 
                 NSString * store_name=[[tempDict valueForKey:@"data"] valueForKey:@"store_name"];
                 [[NSUserDefaults standardUserDefaults]setValue:store_name forKey:@"store_name_token"];

                 [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"checklandscreen"];
                 
                 if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                 {
                     locationLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
                 }
                 else
                 {
                     locationLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
                 }
                 NSString *rstring = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_name_token"];
                 [locationLbl setText:rstring];
                 [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"LoginCheck"];
                 [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"registrationpagecheck"];
                 [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"profilecheck"];
                 [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Addaddress"];
                 [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Pincheck"];
             }
             else
             {
                 [[[UIAlertView alloc] initWithTitle:@"spencer's" message:[tempDict valueForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
                 [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"LoginCheck"];
                 [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"registrationpagecheck"];
                 [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"profilecheck"];
                 [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Addaddress"];
                 [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Pincheck"];
                 
             }
             [self getCartWishlist];
             [SVProgressHUD dismiss];
             
         }
         [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Pincheck"];
     }];
    }
    
}

- (IBAction)SkipButton:(id)sender
{
     [Pin_Txt resignFirstResponder];
    [launchView setHidden:YES];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"LoginCheck"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"registrationpagecheck"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"profilecheck"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Addaddress"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Pincheck"];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self searchBtnAct];
    
    return YES;
}

- (IBAction)menuBtnAct:(UIButton *)sender {
    
    if (sender == menuBtnObj)
    {
//        [self.navigationController popViewControllerAnimated:NO];
    }
    else if (sender==  offerObj)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            itemDetailsVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//        }
//        else
//        {
//            itemDetailsVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//        }
        
        itemDetailsVC.productHeader = appDelegate.GlobalOfferName;
        itemDetailsVC.categoryUrl = appDelegate.GlobalofferURL;
        //            itemDetailsVC.offerCheckBool = YES;
        itemDetailsVC.productDetailsDict = [appDelegate.offerUrlDict valueForKey:@"data"];
        [self.navigationController pushViewController:itemDetailsVC animated:YES];
    }
    else if(sender == _offerBtnObj)
    {
        
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
        if (appDelegate.offerUrlDict != nil)
        {
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            itemDetailsVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//        }
//        else
//        {
//            itemDetailsVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//        }
            itemDetailsVC.productDetailsDict = appDelegate.offerUrlDict;
            [self.navigationController pushViewController:itemDetailsVC animated:YES];
            
        }
        

        
    }
    else if (sender == searchBtnObj)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        [self searchBtnAct];
    }
    else if (sender == myProfileBtnObj)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        temp=[NSUserDefaults standardUserDefaults];
        oauth_token =[temp objectForKey:@"oauth_token"];
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
            
            LoginVC* loginpage;
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
                loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
//            }
//            else
//            {
//                loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC~iPad" bundle:nil];
//            }
//            loginpage.CheckProfileStatus=@"000";
            [self.navigationController pushViewController:loginpage animated:NO];
        }
        else
        {
//            MyProfileVC *myProfile;
//            
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
//                myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC" bundle:nil];
//            }
//            else
//            {
//                myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC~iPad" bundle:nil];
//            }
//            [self.navigationController pushViewController:myProfile animated:NO];
        }

    }
    else if (sender == cartBtnObj)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        if ([bangeLbl.text integerValue] == 0)
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Your Cart is Empty"]];
        }
        else
        {
            InCartVC *placeOrderVC ;
            
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
                placeOrderVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
//            }
//            else
//            {
//                placeOrderVC = [[InCartVC alloc] initWithNibName:@"InCartVC~iPad" bundle:nil];
//            }
            [self.navigationController pushViewController:placeOrderVC animated:NO];
        }

    }
    else if (sender == logoLargeBtn)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

}

- (IBAction)Myprofile_button:(id)sender {
    
    ProfileView * profilepage;
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
        profilepage=[[ProfileView alloc]initWithNibName:@"ProfileView" bundle:nil];
//    }
//    else
//    {
//        profilepage=[[ProfileView alloc]initWithNibName:@"ProfileView~iPad" bundle:nil];
//    }
    [self.navigationController pushViewController:profilepage animated:YES];
    
}

- (IBAction)Myorders_button:(id)sender {
    // dispatch_async(dispatch_get_main_queue(), ^{
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO)
    {
        return ;
    }
    [SVProgressHUD show];
    
    NSUserDefaults *temp1=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token1 =[temp1 objectForKey:@"oauth_token"];
    NSString * oauth_token_secret1 =[temp1 objectForKey:@"oauth_token_secret"];
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token1 secret:oauth_token_secret1 session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@/orders?store=%@", baseUrl1, [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]] parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSError *jsonError = nil;
         [SVProgressHUD dismiss];
         
         id orders_Dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
         
         if ([[orders_Dict valueForKey:@"status"] integerValue] == 1)
         {
             MyOrdersVC * ordersview;
//             if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//             {
                 ordersview=[[MyOrdersVC alloc]initWithNibName:@"MyOrdersVC" bundle:nil];
//             }
//             else
//             {
//                 ordersview=[[MyOrdersVC alloc]initWithNibName:@"MyOrdersVC~iPad" bundle:nil];
//             }
             ordersview.orders_Dict = orders_Dict;
             [self.navigationController pushViewController:ordersview animated:YES];
         }
         else
         {
             [self.view addSubview:[[ToastAlert alloc] initWithText:@"No Order found"]];
         }
         
     }
     
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
//         NSLog(@"Error: %@", error);
         [SVProgressHUD dismiss];
         
     }];
    [operation start];
    
    
    
    //        NSDictionary * orders_Dict=  [Webmethods myorders];
    //        if ([[orders_Dict valueForKey:@"status"] integerValue] == 1)
    //        {
    //            MyOrdersVC * ordersview;
    //            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    //            {
    //                ordersview=[[MyOrdersVC alloc]initWithNibName:@"MyOrdersVC" bundle:nil];
    //            }
    //            else
    //            {
    //                ordersview=[[MyOrdersVC alloc]initWithNibName:@"MyOrdersVC~iPad" bundle:nil];
    //            }
    //            ordersview.orders_Dict = orders_Dict;
    //            [self.navigationController pushViewController:ordersview animated:YES];
    //        }
    //        else
    //        {
    //            [self.view addSubview:[[ToastAlert alloc] initWithText:@"No Order found"]];
    //        }
    //    });
    
    
}

- (IBAction)Mycredits_button:(id)sender {
    MyCreditsView *myCreditsView ;
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
        myCreditsView = [[MyCreditsView alloc] initWithNibName:@"MyCreditsView" bundle:nil];
//    }
//    else
//    {
//        myCreditsView = [[MyCreditsView alloc] initWithNibName:@"MyCreditsView~iPad" bundle:nil];
//    }
    [self.navigationController pushViewController:myCreditsView animated:YES];
}

- (IBAction)MyaddresBook_button:(id)sender {
    AddressVC * Addressvc;
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
        Addressvc = [[AddressVC alloc]initWithNibName:@"AddressVC" bundle:nil];
//    }
//    else
//    {
//        Addressvc = [[AddressVC alloc]initWithNibName:@"AddressVC~iPad" bundle:nil];
//    }
    Addressvc.CustmoorID=[[DictFinal valueForKey:@"data"]valueForKey:@"customerid"];
    [self.navigationController pushViewController:Addressvc animated:NO];
}
- (IBAction)Newsletter_button:(id)sender
{
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
//    [NSThread detachNewThreadSelector:@selector(threadStartAnimating22:) toTarget:self withObject:nil];
    NSDictionary * News_Dict;
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/index.php/blog/", baseBannerUrl1]]];
//    if (checkbox_check == NO)
//    {
//        News_Dict=[Webmethods Newsletter:@"0"];
//        Check_Box_image.image=[UIImage imageNamed:@"checkbox_unchecked.png"];
//        checkbox_check=YES;
//        [[NSUserDefaults standardUserDefaults] setObject:@"-1" forKey:@"newsletter"];
//    }
//    else
//    {
//        News_Dict=[Webmethods Newsletter:@"1"];
//        Check_Box_image.image=[UIImage imageNamed:@"checkbox_checked.png"];
//        checkbox_check=NO;
//        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"newsletter"];
//    }
//    NSString * Status_str=[News_Dict valueForKey:@"status"];
//    NSString * Message_str=[News_Dict valueForKey:@"message"];
//    if ( [Status_str integerValue] == 1 )
//    {
//        [self.view addSubview:[[ToastAlert alloc] initWithText:Message_str]];
//    }
//    else
//    {
//        [self.view addSubview:[[ToastAlert alloc] initWithText:Message_str]];
//    }
//    [SVProgressHUD dismiss];
}
-(void)threadStartAnimating22:(id)dat
{
    [SVProgressHUD show];
}


- (IBAction)Log_Out:(id)sender {
    
    NSString *timeStamp =  [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    NSString *lastFourChar = [timeStamp substringFromIndex:[timeStamp length] - 4];
    int r = arc4random() % 100000;
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"globalcartid"];
//    NSLog(@"Random Number %i", r);
//    NSLog(@"time stamp %@", timeStamp);
//    NSLog(@"lastFourChar %@", lastFourChar);
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CustomerDict"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token"];
    appDelegate.bangeStr = @"0";
    temp=[NSUserDefaults standardUserDefaults];
    oauth_token =[temp objectForKey:@"oauth_token"];
    oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    appDelegate.bangeStr = @"0";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSideMenu" object:nil userInfo:nil];
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
        homeVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC" bundle:nil];
//    }
//    else
//    {
//        homeVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC~iPad" bundle:nil];
//    }
    [self.navigationController pushViewController:homeVC animated:NO];
}

- (IBAction)Location:(id)sender {
    
    yourLocationVC = [[YourLocationVC alloc] initWithNibName:@"YourLocationVC" bundle:nil];
    [self.navigationController pushViewController:yourLocationVC animated:YES];
    
//    Pin_Txt.text = @"";
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"LoginCheck"];
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"registrationpagecheck"];
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"profilecheck"];
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Addaddress"];
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Pincheck"];
//    [launchView setHidden:NO];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    NSLog(@"%@", searchStr);
    NSString *storeId = [[NSUserDefaults standardUserDefaults]valueForKey:@"store_id_token"];
    if (searchStr.length > 1)
    {
        NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                     NULL,
                                                                                                     (CFStringRef)searchStr,
                                                                                                     NULL,
                                                                                                     (CFStringRef)@"<>",
                                                                                                     kCFStringEncodingUTF8));
        NSDictionary * searchFinalDict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sb.php?q=%@&storeid=%@&customergroupid=%@&storetimestamp=%@&currencycode=%@&timestamp=%@",solarSearchUrl, urlEncoded, storeId, @"0", @"1466176750", @"INR", @"1466156966987"]]] options:NSJSONReadingMutableContainers error:nil];
        NSArray *finalarr = [searchFinalDict valueForKey:@"keywordsraw"];
        if (finalarr.count > 0)
        {
//            _dropdown.hidden = NO;
        }
        else
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"No matching products"]];
        }
    }
    else
    {
        
    }
    
    return YES;
}


- (IBAction)footerBtnAct:(UIButton *)sender {
    switch (sender.tag)
    {
        case 11:
        {
            BOOL flag = NO;
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[MainCategoryVC class]])
                {
                    flag = YES;
                    [self.navigationController popToViewController:controller animated:YES];
                    break;
                }
            }
            if (flag == NO)
            {
                mainCategoryVC=[[MainCategoryVC alloc]initWithNibName:@"MainCategoryVC" bundle:nil];
                [self.navigationController pushViewController:mainCategoryVC animated:YES];
            }
        }
            break;
        case 12:
        {
            BOOL flag = NO;
            for (UIViewController *controller in self.navigationController.viewControllers)
            {
                if ([controller isKindOfClass:[CategoryPage class]])
                {
                    flag = YES;
                    [self.navigationController popToViewController:controller animated:YES];
                    break;
                }
            }
            if (flag == NO)
            {
                Categoryvc=[[CategoryPage alloc]initWithNibName:@"CategoryPage" bundle:nil];
                [self.navigationController pushViewController:Categoryvc animated:YES];
            }
            break;
        }
        case 13:
        {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cat_subcat" ofType:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            NSDictionary * currentArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSMutableArray *listNameArray = [[NSMutableArray alloc] initWithArray:[[currentArray valueForKey:@"data"] valueForKey:@"categories"]];
            
            NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
            
            NSString *urlStr = [NSString stringWithFormat:@"%@/category/products/%@?page=%@&store=%@", baseUrl1, [[listNameArray objectAtIndex:9] valueForKey:@"category_id"], @"1", storeIdStr];
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
                productVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//            }
//            else
//            {
//                productVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//            }
            productVC.productHeader = [[listNameArray objectAtIndex:9] valueForKey:@"name"];
            productVC.categoryUrl = urlStr;
            [self.navigationController pushViewController:productVC animated:YES];
        }
            break;
        case 14:
            temp=[NSUserDefaults standardUserDefaults];
            oauth_token =[temp objectForKey:@"oauth_token"];
            if(oauth_token==NULL || [oauth_token isEqual:@""])
            {
                
                LoginVC* loginpage;
//                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//                {
                    loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
//                }
//                else
//                {
//                    loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC~iPad" bundle:nil];
//                }
                loginpage.CheckProfileStatus=@"002";
                [self.navigationController pushViewController:loginpage animated:NO];
            }
            else
            {
                
            }
            
            break;
            
            
        default:
            break;
    }
}




@end
