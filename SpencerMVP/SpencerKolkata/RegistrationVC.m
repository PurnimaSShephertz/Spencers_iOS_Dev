//
//  RegistrationVC.m
//  SpencerKolkata
//
//  Created by binary on 30/06/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "RegistrationVC.h"
#import "Webmethods.h"
#import "YourLocationVC.h"
#import "SVProgressHUD.h"

#import "MainCategoryVC.h"
#import "IQKeyboardManager.h"
#import "AppDelegate.h"
#import "InCartVC.h"
#import "SH_TrackingUtility.h"


@interface RegistrationVC () <UITextFieldDelegate>
{
    NSDictionary *result_Dict;
    YourLocationVC *yourLocationVC;
    MainCategoryVC *mainCategoryVC;
    
    NSDictionary *Customer_Dict;
    AppDelegate *appDele;
    InCartVC *inCartVC;
}
@end

@implementation RegistrationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"Registration Screen";
    
    UIColor *color = [UIColor colorWithRed:114.0/255.0 green:116.0/255.0 blue:121.0/255.0 alpha:1];
    firstNameTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: color}];
    lastNameTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: color}];
    emailTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: color}];
    passwordTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    mobileNoTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile No." attributes:@{NSForegroundColorAttributeName: color}];
    enterOTPTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter OTP" attributes:@{NSForegroundColorAttributeName: color}];
    
    [signUpBtnObj setTitleColor:color forState:UIControlStateNormal];
    
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [[IQKeyboardManager sharedManager] setEnable:TRUE];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:TRUE];
    loginLbl.textColor = kColor_gray;
    signUpLbl.textColor = kColor_gray;
    signUpBtnObj.layer.borderColor = kColor_gray.CGColor;
    signUpBtnObj.layer.borderWidth = 1;
    signUpBtnObj.layer.cornerRadius = 22;
    
    otpBgVew.layer.cornerRadius = 5;
    otpBgVew.layer.masksToBounds = YES;
    
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated
{
    firstNameTxtFld.text = @"";
    lastNameTxtFld.text = @"";
    emailTxtFld.text = @"";
    passwordTxtFld.text = @"";
    mobileNoTxtFld.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loginBtnAct:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(IBAction)signUpBtnAct:(UIButton *)sender
{
    BOOL email = [self validateEmailWithString:emailTxtFld.text];
    if ([firstNameTxtFld.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter first name"]];
    }
    else if ([self validateAlphabets:firstNameTxtFld.text] == NO)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"First name is not valid"]];
        return ;
    }
    else if ([lastNameTxtFld.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter last name"]];
    }
    else if ([self validateAlphabets:lastNameTxtFld.text] == NO)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Last name is not valid"]];
        return ;
    }
    else if ([emailTxtFld.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a valid email ID e.g. xyz@abc.com"]];
    }
    
    
    
    else if ([passwordTxtFld.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter password"]];
    }
    
    else if ([passwordTxtFld.text length] < 6)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter atleast 6 digit password"]];
    }
    
    
    else if ([mobileNoTxtFld.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a 10 digit Mobile Number for OTP Verification"]];
    }
    
    else if (email == NO)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a valid email ID e.g. xyz@abc.com"]];
        return ;
    }
    
    else if (mobileNoTxtFld.text.length != 10)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a 10 digit Mobile Number for OTP Verification"]];
    }
    else{
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO)
        {
            return ;
        }
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating12) toTarget:self withObject:nil];
        result_Dict=  [Webmethods RegistrationMethod:firstNameTxtFld.text andlastname:lastNameTxtFld.text andemail:emailTxtFld.text andpassword:passwordTxtFld.text crmid:@"" mobile:mobileNoTxtFld.text];
        
        NSString * Status=[NSString stringWithFormat:@"%@",[result_Dict  valueForKey:@"status"]];
        
        if ([Status isEqualToString:@"1"])
        {
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirst"];
            //            [self.view addSubview:[[ToastAlert alloc] initWithText:[result_Dict valueForKey:@"message"]]];
            
            otpView.center = self.view.center;
            [self.view addSubview:otpView];
            
            
        }
        else
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:[result_Dict valueForKey:@"message"]]];
            
        }
        
        [SVProgressHUD dismiss];
        
    }
    
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


-(BOOL) validateAlphabets: (NSString *)alpha
{
    NSString *abnRegex = @"[A-Za-z ]+"; // check for one or more occurrence of string you can also use * instead + for ignoring null value
    NSPredicate *abnTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", abnRegex];
    BOOL isValid = [abnTest evaluateWithObject:alpha];
    return isValid;
}

-(IBAction)skipBtnAct:(UIButton *)sender
{
    if ([_Skipcheck isEqualToString:@"003"])
    {
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
                DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[MainCategoryVC alloc] init]];
                DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];
                
                REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
                frostedViewController.direction = REFrostedViewControllerDirectionLeft;
                frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
                frostedViewController.liveBlur = YES;
                frostedViewController.delegate = self;
                [self.navigationController pushViewController:frostedViewController animated:YES];
            }
        }
//        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        yourLocationVC = [[YourLocationVC alloc] initWithNibName:@"YourLocationVC" bundle:nil];
        [self.navigationController pushViewController:yourLocationVC animated:NO];
    }
    
    
//    yourLocationVC = [[YourLocationVC alloc] initWithNibName:@"YourLocationVC" bundle:nil];
//    [self.navigationController pushViewController:yourLocationVC animated:NO];
//    DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[MainCategoryVC alloc] init]];
//    DEMOMenuViewController *menuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];
//    
//    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
//    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
//    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
//    frostedViewController.liveBlur = YES;
//    frostedViewController.delegate = self;
//    [self.navigationController pushViewController:frostedViewController animated:YES];
}

- (IBAction)otpCancelBtnAct:(UIButton *)sender
{
    enterOTPTxtFld.text = @"";
    [otpView removeFromSuperview];
}

- (IBAction)otpVerifyBtnAct:(UIButton *)sender {
    
    BOOL email = [self validateEmailWithString:emailTxtFld.text];
    if ([enterOTPTxtFld.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter OTP"]];
        return ;
    }
    
    else if ([emailTxtFld.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a valid email ID e.g. xyz@abc.com"]];
        return ;
    }
    else if (email == NO)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a valid email ID e.g. xyz@abc.com"]];
        return ;
    }
    
    
//
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO)
    {
        return ;
    }
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating12) toTarget:self withObject:nil];
//    result_Dict=  [Webmethods OtpVerify:enterOTPTxtFld.text andemail:mobileNoTxtFld.text];
    
    result_Dict = [Webmethods OtpVerify:enterOTPTxtFld.text andemail:emailTxtFld.text firstName:firstNameTxtFld.text lastName:lastNameTxtFld.text mobileNumber:mobileNoTxtFld.text password:passwordTxtFld.text crmid:@""];
//    [Webmethods RegistrationMethod:firstNameTxtFld.text andlastname:lastNameTxtFld.text andemail:emailTxtFld.text andpassword:passwordTxtFld.text crmid:@"" mobile:mobileNoTxtFld.text]
    
    
    [SVProgressHUD dismiss];
    NSString * Status=[NSString stringWithFormat:@"%@",[result_Dict valueForKey:@"status"]];
    
    if ([Status isEqualToString:@"1"])
    {
        [otpView removeFromSuperview];
        [self.view addSubview:[[ToastAlert alloc] initWithText:[result_Dict valueForKey:@"message"]]];
        
        otpView.center = self.view.center;
        [self.view addSubview:otpView];
        
        
        /***
         Registartion Event Satrt
         ***/        NSString *entityIdStr = [NSString stringWithFormat:@"%@", [result_Dict valueForKey:@"entity_id"]];
        NSString *fullName = [NSString stringWithFormat:@"%@ %@",firstNameTxtFld.text, lastNameTxtFld.text];
        fullName = [fullName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSMutableDictionary *loginProp = [NSMutableDictionary dictionaryWithObjectsAndKeys:fullName, kNameProperty,
                                          emailTxtFld.text, kEmailProperty,
                                          mobileNoTxtFld.text, kMobileProperty,
                                          entityIdStr, kCustomerIdProperty,
                                          nil];
        
        [SH_TrackingUtility trackEventOfSpencerEvents:registerEvent eventProp:loginProp];
        /***
         Registartion Event End
         ***/
        
        
        /***
         set logged in user in app42 api
         ***/
        [SH_TrackingUtility setLoggedInUser:[[NSUserDefaults standardUserDefaults] valueForKey:@"devicetoken"]];

        
        [self loginBtnAct1:sender];
        
        
//        yourLocationVC = [[YourLocationVC alloc] initWithNibName:@"YourLocationVC" bundle:nil];
//        [self.navigationController pushViewController:yourLocationVC animated:NO];
        
//        BOOL flag = NO;
//        for (UIViewController *controller in self.navigationController.viewControllers)
//        {
//            if ([controller isKindOfClass:[LoginVC class]])
//            {
//                flag = YES;
//                [self.navigationController popToViewController:controller animated:YES];
//                break;
//            }
//        }
//        if (flag == NO)
//        {
//            LoginVC * loginVC=[[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
//            [self.navigationController pushViewController:loginVC animated:YES];
//        }
        
    }
    else
    {
        enterOTPTxtFld.text=@"";
        [self.view addSubview:[[ToastAlert alloc] initWithText:[result_Dict valueForKey:@"message"]]];
    }
}


-(IBAction)loginBtnAct1:(UIButton *)sender
{
    [emailTxtFld resignFirstResponder];
    [passwordTxtFld resignFirstResponder];
    
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"LoginCheck"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"registrationpagecheck"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"profilecheck"];
    BOOL email = [self validateEmailWithString:emailTxtFld.text];
    
    if ([emailTxtFld.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a valid email ID e.g. xyz@abc.com"]];
    }
    else if (email == NO)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a valid email ID e.g. xyz@abc.com"]];
        return ;
    }
    else if ([passwordTxtFld.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter password"]];
    }
    else
    {
        
        
        //        if ([self validateEmail:field1.text] == NO)
        //        {
        //            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Enter Valid Email ID"]];
        //            return ;
        //        }
        
        
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
//        [NSThread detachNewThreadSelector:@selector(threadStartAnimating:) toTarget:self withObject:nil];
        
        
        NSString * DeviceID=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        //        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        //        NSString * DeviceID =[temp objectForKey:@"devicetoken"];
        
        NSDictionary * Result_Dict=[Webmethods LoginMethod:emailTxtFld.text andpassword:passwordTxtFld.text andconsumerkey:@"5af68ccf03ca66408af33172f12f2368" andconsumersecret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329" and:DeviceID];
        
        NSMutableDictionary *customerDict = [[NSMutableDictionary alloc] init];
        
        if ([[Result_Dict valueForKey:@"status"] intValue] == 1)
        {
            
            NSMutableDictionary *customerDict123 = [[NSMutableDictionary alloc] initWithDictionary:[Result_Dict valueForKey:@"customerData"]];
            if ([[customerDict123 valueForKey:@"crmid"] isKindOfClass:[NSNull class]])
            {
                [customerDict123 setObject:@"" forKey:@"crmid"];
            }
            
            
            [customerDict setObject:customerDict123 forKey:@"data"];
            [customerDict setObject:@"1" forKey:@"status"];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirst"];
            
            Customer_Dict = customerDict;
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:Customer_Dict forKey:@"CustomerDict"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        if ([[[[Result_Dict valueForKey:@"messages"]valueForKey:@"error"]objectAtIndex:0]valueForKey:@"message"]!=nil)
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:[[[[Result_Dict valueForKey:@"messages"]valueForKey:@"error"]objectAtIndex:0]valueForKey:@"message"]]];
            [SVProgressHUD dismiss];
        }
        else{
            NSString * oauth_token=[[Result_Dict valueForKey:@"data"]valueForKey:@"oauth_token"];
            NSString * oauth_token_secret=[[Result_Dict valueForKey:@"data"]valueForKey:@"oauth_token_secret"];
            
            
            [[NSUserDefaults standardUserDefaults]setValue:oauth_token forKey:@"oauth_token"];
            [[NSUserDefaults standardUserDefaults]setValue:oauth_token_secret forKey:@"oauth_token_secret"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSideMenu" object:nil userInfo:nil];
            
            NSString *    STATUS =[Result_Dict valueForKey:@"status"];
            
            
            if ( [STATUS integerValue]==0)
            {
                [self.view addSubview:[[ToastAlert alloc] initWithText:[Result_Dict  valueForKey:@"message"]]];
                [SVProgressHUD dismiss];
            }
            else
            {
                [self.view addSubview:[[ToastAlert alloc] initWithText:[Result_Dict  valueForKey:@"message"]]];
                
                [[NSUserDefaults standardUserDefaults]setValue:passwordTxtFld.text forKey:@"PasswordField"];
                if ([_checkLoginFromCheckout isEqualToString:@"0011"])
                {
                    [self.navigationController popViewControllerAnimated:YES];
                    //                    [self performSelector:@selector(timer1) withObject:nil afterDelay:0.2];
                    
                }
                else if ([_CheckProfileStatus isEqualToString:@"002"])
                {
                    
                    BOOL reach = [Webmethods checkNetwork];
                    if (reach == NO)
                    {
                        return ;
                    }
                    
                    NSArray * arry; // = [WishListData_Dict valueForKey:@"data"];
                    NSMutableDictionary * cartDict = [Webmethods getCartWishlist];
                    
                    appDele.bangeStr = [NSString stringWithFormat:@"%li",[[cartDict valueForKey:@"cart_count"] integerValue]];
                    
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
                    //                    MyProfileVC *myProfile;
                    //
                    //                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    //                    {
                    //                        myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC" bundle:nil];
                    //                    }
                    //                    else
                    //                    {
                    //                        myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC~iPad" bundle:nil];
                    //                    }
                    //                    [self.navigationController pushViewController:myProfile animated:NO];
                    
                    
                    
                    
//                    if ([appDele.bangeStr integerValue] > 0)
//                    {
//                        //                        NSMutableDictionary * cartDict= [Webmethods getCartWishlist];
//                        appDele.bangeStr = [NSString stringWithFormat:@"%li",[[cartDict valueForKey:@"cart_count"] integerValue]];
//                        [[NSUserDefaults standardUserDefaults] setObject:[cartDict valueForKey:@"cartid"] forKey:@"globalcartid"];
//                        
////                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
////                        {
//                            inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
////                        }
////                        else
////                        {
////                            inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC~iPad" bundle:nil];
////                        }
//                        inCartVC.loginNav = @"10";
//                        [self.navigationController pushViewController:inCartVC animated:NO];
//                    }
//                    else
//                    {
////                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
////                        {
//                            mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC" bundle:nil];
////                        }
////                        else
////                        {
////                            mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC~iPad" bundle:nil];
////                        }
//                        
//                        [self.navigationController pushViewController:mainCategoryVC animated:NO];
//                    }
                    
                    
                    
                    [SVProgressHUD dismiss];
                }
                else if ([_CheckProfileStatus isEqualToString:@"000"])
                {
                    
                    BOOL reach = [Webmethods checkNetwork];
                    if (reach == NO) {
                        return ;
                    }
                    
                    NSArray * arry; // = [WishListData_Dict valueForKey:@"data"];
                    
                    NSString * cartStr = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
                    
                    NSMutableDictionary *   cartDict= [Webmethods getCartWishlist];
                    
                    //            appDelegate.bangeStr=[NSString stringWithFormat:@"%lu",(unsigned long)cartArr.count];
                    appDele.bangeStr = [NSString stringWithFormat:@"%i",[[cartDict valueForKey:@"cart_count"] integerValue]];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
//                    if ([appDele.bangeStr integerValue] > 0)
//                    {
//                        NSMutableDictionary * cartDict= [Webmethods getCartWishlist];
//                        appDele.bangeStr = [NSString stringWithFormat:@"%li",[[cartDict valueForKey:@"cart_count"] integerValue]];
//                        [[NSUserDefaults standardUserDefaults] setObject:[cartDict valueForKey:@"cartid"] forKey:@"globalcartid"];
//                        
////                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
////                        {
//                            inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
////                        }
////                        else
////                        {
////                            inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC~iPad" bundle:nil];
////                        }
//                        inCartVC.loginNav = @"10";
//                        [self.navigationController pushViewController:inCartVC animated:NO];
//                    }
//                    else
//                    {
////                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
////                        {
//                            mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC" bundle:nil];
////                        }
////                        else
////                        {
////                            mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC~iPad" bundle:nil];
////                        }
//                        
//                        [self.navigationController pushViewController:mainCategoryVC animated:NO];
//                    }
                    [SVProgressHUD dismiss];
                    
                }
                else if ([_checkdrawermenu isEqualToString:@"2222"])
                {
                    
                    //                    [self.navigationController popViewControllerAnimated:YES];
                    
                    
                    BOOL reach = [Webmethods checkNetwork];
                    if (reach == NO) {
                        return ;
                    }
                    
                    NSArray * arry; // = [WishListData_Dict valueForKey:@"data"];
                    
                    NSString * cartStr = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
                    
                    NSMutableDictionary *   cartDict= [Webmethods getCartWishlist];
                    
                    //            appDelegate.bangeStr=[NSString stringWithFormat:@"%lu",(unsigned long)cartArr.count];
                    appDele.bangeStr = [NSString stringWithFormat:@"%i",[[cartDict valueForKey:@"cart_count"] integerValue]];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    
//                    if ([appDele.bangeStr integerValue] > 0)
//                    {
//                        NSMutableDictionary * cartDict= [Webmethods getCartWishlist];
//                        appDele.bangeStr = [NSString stringWithFormat:@"%li",[[cartDict valueForKey:@"cart_count"] integerValue]];
//                        [[NSUserDefaults standardUserDefaults] setObject:[cartDict valueForKey:@"cartid"] forKey:@"globalcartid"];
//                        
////                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
////                        {
//                            inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
////                        }
////                        else
////                        {
////                            inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC~iPad" bundle:nil];
////                        }
//                        inCartVC.loginNav = @"10";
//                        [self.navigationController pushViewController:inCartVC animated:NO];
//                    }
//                    else
//                    {
////                        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
////                        {
//                            mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC" bundle:nil];
////                        }
////                        else
////                        {
////                            mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC~iPad" bundle:nil];
////                        }
//                        
//                        [self.navigationController pushViewController:mainCategoryVC animated:NO];
//                    }
                    [SVProgressHUD dismiss];
                    
                    
                    
                }
                else
                {
                    
                    
                    //                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    //                    {
                    //                        mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC" bundle:nil];
                    //                    }
                    //                    else
                    //                    {
                    //                        mainCategoryVC = [[MainCategoryVC alloc] initWithNibName:@"MainCategoryVC~iPad" bundle:nil];
                    //                    }
                    //
                    //                    UINavigationController *childNavController = [[UINavigationController alloc] initWithRootViewController:mainCategoryVC];
                    //                    childNavController.view.frame = mainCategoryVC.view.frame;
                    //
                    //                    [self addChildViewController:childNavController];
                    //                    [self.view addSubview:childNavController.view];
                    //                    [childNavController didMoveToParentViewController:self];
                    
                    
                    yourLocationVC = [[YourLocationVC alloc] initWithNibName:@"YourLocationVC" bundle:nil];
                    [self.navigationController pushViewController:yourLocationVC animated:NO];
                    
                    
                    
                    [SVProgressHUD dismiss];
                    
                    //                    NSLog(@"method called");
                    //                    inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
                    //                    [self.navigationController pushViewController:inCartVC animated:YES];
                    
                    //                    [self.view addSubview:[[ToastAlert alloc] initWithText:@"Customer Login sucessfully."]];
                    //                    CheckOutViewViewController * checkoutpage ;
                    //
                    //                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    //                    {
                    //                        checkoutpage=[[CheckOutViewViewController alloc]initWithNibName:@"CheckOutViewViewController" bundle:nil];
                    //                    }
                    //                    else
                    //                    {
                    //                        checkoutpage=[[CheckOutViewViewController alloc]initWithNibName:@"CheckOutViewViewController~iPad" bundle:nil];
                    //                    }
                    
                    //                    [self.navigationController pushViewController:checkoutpage animated:NO];
                }
                
                //             Customer_Dict=[Webmethods Getcustmer];
                
                [[NSUserDefaults standardUserDefaults] setObject:Customer_Dict forKey:@"CustomerDict"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
            }
            [SVProgressHUD dismiss];
        }
        
        
    }
    
}




- (IBAction)resendOtpBtnAct:(UIButton *)sender
{
    
    BOOL email = [self validateEmailWithString:emailTxtFld.text];
    if ([mobileNoTxtFld.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a 10 digit Mobile Number for OTP Verification"]];
        return ;
    }
    else if ([emailTxtFld.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a valid email ID e.g. xyz@abc.com"]];
        return ;
    }
    else if (email == NO)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter a valid email ID e.g. xyz@abc.com"]];
        return ;
    }
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO)
    {
        return ;
    }
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating12) toTarget:self withObject:nil];
    result_Dict=  [Webmethods ResendOTP:emailTxtFld.text mobile:mobileNoTxtFld.text];
    
    [SVProgressHUD dismiss];
    NSString * Status=[NSString stringWithFormat:@"%@",[result_Dict valueForKey:@"STATUS"]];
    
    if ([Status isEqualToString:@"1"])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:[result_Dict valueForKey:@"message"]]];
        
        otpView.center = self.view.center;
        [self.view addSubview:otpView];
    }
    else
    {
        
        enterOTPTxtFld.text=@"";
        [self.view addSubview:[[ToastAlert alloc] initWithText:[result_Dict valueForKey:@"message"]]];
        
    }
    
}

-(void)threadStartAnimating12
{
    [SVProgressHUD show];
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == mobileNoTxtFld)
    {
        if (textField.text.length < 10) {
            return YES;
        }
        else
        {
            if (string.length>0)
            {
                return NO;
            }
            else
            {
                return YES;
            }
            
        }
        
    }
    if (textField == enterOTPTxtFld)
    {
        if (textField.text.length < 6) {
            return YES;
        }
        else
        {
            if (string.length>0)
            {
                return NO;
            }
            else
            {
                return YES;
            }
            
        }
        
    }
    
    if(textField == mobileNoTxtFld)
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 10) ? NO : YES;
    }

    
    return YES; //we allow the user to enter anything
}



@end
