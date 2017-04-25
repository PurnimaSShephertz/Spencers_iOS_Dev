//
//  ProfileView.m
//  CustomMenu
//
//  Created by Binary Semantics on 6/9/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import "ProfileView.h"
#import "AppDelegate.h"
#import "LoginVC.h"
#import "MainCategoryVC.h"
#import "ProductVC.h"
#import "LoginVC.h"
#import "MyProfileVC.h"

#import "CategoryPage.h"
#import "MainCategoryVC.h"
#import "OfferVC.h"

#import "ProductVC.h"

@interface ProfileView ()
{
    LoginVC *loginView;
    AppDelegate *appDelegate;
    
    MainCategoryVC *mainCategoryVC;
    
    CategoryPage *Categoryvc;
    NSUserDefaults * temp;
    InCartVC *inCartVC;
    IBOutlet UITextField *mobileNoTxtFld;
    
    ProductVC *productVC;
    
    NSString *previousMobNo;
}
@end

@implementation ProfileView
@synthesize logoLargeBtn;

@synthesize searchBtnObj, cartBtnObj, myProfileBtnObj;
@synthesize bangeLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"My Profile Screen";
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    //self.screenName = @"Profile View Screen";
    
    field1.delegate = self;
    field2.delegate = self;
    field3.delegate = self;
    field4.delegate = self;
    field5.delegate = self;
    field6.delegate = self;
    field7.delegate = self;
    
    updateBtnObj.layer.cornerRadius = 15;
    updateBtnObj.layer.masksToBounds = YES;
    updateBtnObj.backgroundColor = kColor_Orange;
    
    saveBtnObj.layer.cornerRadius = 15;
    saveBtnObj.layer.masksToBounds = YES;
    saveBtnObj.backgroundColor = kColor_Orange;
    
    
    cancelBtnObj.layer.cornerRadius = 15;
    cancelBtnObj.layer.masksToBounds = YES;
    cancelBtnObj.backgroundColor = kColor_Orange;
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
 
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"LoginCheck"];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"registrationpagecheck"];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"profilecheck"];
    
//    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
//    [keyBoardController addToolbarToKeyboard];
     [ChangepasswordView setHidden:YES];
    [footer_View setHidden:YES];
    //[HUD show:YES];
   
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    field7.hidden = YES;
    srcPointLbl.hidden = YES;
    srcAmountLbl.hidden = YES;
    CGRect frame = updateBtnObj.frame;
    frame.origin.y = frame.origin.y-30;
    updateBtnObj.frame = frame;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating22:) toTarget:self withObject:nil];
        Customer_Dict=[Webmethods Getcustmer];
        DictFinal=[[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"];
        NSString * status=[Customer_Dict valueForKey:@"status"];
        if ([status integerValue]==1)
        {
            NSString * email_str=[[Customer_Dict valueForKey:@"data"]valueForKey:@"email"];
            NSString * firstname_str=[[Customer_Dict  valueForKey:@"data"]valueForKey:@"firstname"];
            NSString * lastname_str=[[Customer_Dict  valueForKey:@"data"]valueForKey:@"lastname"];
            NSString *crmStr = [[Customer_Dict valueForKey:@"data"] valueForKey:@"crmid"];
            field1.text=firstname_str;
            field2.text=lastname_str;
            field3.text=email_str;
            mobileNoTxtFld.text = [[Customer_Dict valueForKey:@"data"] valueForKey:@"mobile"];
            previousMobNo = [[Customer_Dict valueForKey:@"data"] valueForKey:@"mobile"];
            srcAmountLbl.text = [NSString stringWithFormat:@"%.2f Credits", [[[Customer_Dict valueForKey:@"data"] valueForKey:@"srcpoints"] floatValue]];
            if ( [crmStr isKindOfClass:[NSNull class]] || [crmStr length] < 1 )
            {
//                CGRect frame = updateBtnObj.frame;
//                frame.origin.y = frame.origin.y-30;
//                updateBtnObj.frame = frame;
                field7.text = crmStr;
                field7.hidden = YES;
                srcPointLbl.hidden = YES;
                srcAmountLbl.hidden = YES;
            }
            else
            {
                CGRect frame = updateBtnObj.frame;
                frame.origin.y = frame.origin.y+30;
                updateBtnObj.frame = frame;
                field7.hidden = NO;
                field7.text = crmStr;
                srcPointLbl.hidden = NO;
                srcAmountLbl.hidden = NO;
            }
        }
        [SVProgressHUD dismiss];
    });
    
    
    
            
            //    CustomerDetails_Str=[NSString stringWithFormat:@"Name:  %@",firstname_str];
            //    CustomerDetails_Str=[CustomerDetails_Str stringByAppendingFormat:@"\r\rMobile:  %@",lastname_str];
            //    CustomerDetails_Str=[CustomerDetails_Str stringByAppendingFormat:@"\r\rEmail:  %@",email_str];
    
            bangeLbl.text = appDelegate.bangeStr;
    
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
    
            self.footerImg.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:132.0/255.0 blue:36.0/255.0 alpha:1];
    
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                profileheader_Lbl.font = [UIFont fontWithName:@"Helvetica" size:17];
                bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
                
                field1.font = [UIFont fontWithName:@"Helvetica" size:15];
                field2.font = [UIFont fontWithName:@"Helvetica" size:15];
                field3.font = [UIFont fontWithName:@"Helvetica" size:15];
                field4.font = [UIFont fontWithName:@"Helvetica" size:15];
                field5.font = [UIFont fontWithName:@"Helvetica" size:15];
                field6.font = [UIFont fontWithName:@"Helvetica" size:15];
                
                changepassheader_lbl.font = [UIFont fontWithName:@"Helvetica" size:17];
                locationLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
            }
            else
            {
                profileheader_Lbl.font = [UIFont fontWithName:@"Helvetica" size:21];
                bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
                
                field1.font = [UIFont fontWithName:@"Helvetica" size:19];
                field2.font = [UIFont fontWithName:@"Helvetica" size:19];
                field3.font = [UIFont fontWithName:@"Helvetica" size:19];
                field4.font = [UIFont fontWithName:@"Helvetica" size:19];
                field5.font = [UIFont fontWithName:@"Helvetica" size:19];
                field6.font = [UIFont fontWithName:@"Helvetica" size:19];
                
                changepassheader_lbl.font = [UIFont fontWithName:@"Helvetica" size:21];
                
                locationLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
            }
    
    
    NSString *rstring = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_name_token"];
    [locationLbl setText:rstring];
            
           
           [footer_View setHidden:NO];
            pos=YES;
             [SVProgressHUD dismiss];
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
    
    
    [titleLabelButton setTitle:@"My Profile" forState:UIControlStateNormal];
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
    
    if ([bangeLbl.text integerValue] < 1)
    {
        bangeLbl.hidden = YES;
    }
    else
    {
        bangeLbl.hidden = NO;
    }
    
    
    CGFloat width=[UIScreen mainScreen].bounds.size.width;
    UIToolbar* numberToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, width, 50)];
    numberToolbar.barStyle = UIBarStyleDefault;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:nil],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    field6.inputAccessoryView = numberToolbar;
    field6.delegate=self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)threadStartAnimating22:(id)dat
{
//    [field1 resignFirstResponder];
//    [field2 resignFirstResponder];
//    [field3 resignFirstResponder];
//    [field4 resignFirstResponder];
    [SVProgressHUD show];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"profilecheck"];
}
- (void)alttextFieldDidEndEditing:(UITextField *)textField
{
    
}

- (void)alttextViewDidEndEditing:(UITextView *)textView
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(IBAction)Edit_butt:(id)sender
{
    [ChangepasswordView setHidden:NO];
}

-(IBAction)Update_butt:(id)sender
{
    
    [field1 resignFirstResponder];
    [field2 resignFirstResponder];
    [field3 resignFirstResponder];
    [mobileNoTxtFld resignFirstResponder];
    [self.view endEditing:YES];
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    if (field1.text.length < 1 || [field1.text isEqualToString:@" "])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter first name"]];
        return ;
    }
    else if (field2.text.length < 1 || [field2.text isEqualToString:@" "])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter last name"]];
        return ;
    }
    else if (field3.text.length < 1 || [field3.text isEqualToString:@" "])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter email address"]];
        return ;
    }
    
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating22:) toTarget:self withObject:nil];
    
    NSString * Requrl= [NSString stringWithFormat:@"%@/profile/", baseUrl1];
    NSString *Finalurl=[Requrl stringByAppendingString:[[Customer_Dict valueForKey:@"data"] valueForKey:@"customerid"]];
    UpdateCustomer_Dict= [Webmethods UpdateCustomer:Finalurl andDict:field1.text andLastName:field2.text andEmail:field3.text crmid:field7.text mobile:mobileNoTxtFld.text];
    
    if ([[UpdateCustomer_Dict valueForKey:@"status"] integerValue]==1)
    {
        if ([[UpdateCustomer_Dict valueForKey:@"message"] isEqualToString:@"OTP sent successfully"])
        {
            otpView.center = self.view.center;
            [self.view addSubview:otpView];
        }
        else
        {
            
            NSMutableDictionary * userDict = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"]];
            NSMutableDictionary *userInfoDict = [[NSMutableDictionary alloc] initWithDictionary:[userDict valueForKey:@"data"]];
            [userInfoDict setObject:field1.text forKey:@"firstname"];
            [userInfoDict setObject:field2.text forKey:@"lastname"];
            [userInfoDict setObject:field3.text forKey:@"email"];
            [userInfoDict setObject:field7.text forKey:@"crmid"];
            [userInfoDict setObject:mobileNoTxtFld.text forKey:@"mobile"];
            [userDict setObject:userInfoDict forKey:@"data"];
            [[NSUserDefaults standardUserDefaults] setValue:userDict forKey:@"CustomerDict"];
            
//            [self.view addSubview:[[ToastAlert alloc] initWithText:[UpdateCustomer_Dict valueForKey:@"message"]]];
        }
        
        [self.view addSubview:[[ToastAlert alloc] initWithText:[UpdateCustomer_Dict valueForKey:@"message"]]];
    }
    else{
        [self.view addSubview:[[ToastAlert alloc] initWithText:[UpdateCustomer_Dict valueForKey:@"message"]]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSideMenu" object:nil userInfo:nil];
    
    //[self.view addSubview:[[ToastAlert alloc] initWithText:@"Profile Updated Successfully"]];
    [SVProgressHUD dismiss];
//    [self performSelector:@selector(popvc) withObject:nil afterDelay:2];
}



-(void) popvc
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)save_butt:(id)sender
{
 
    [self.view endEditing:YES];
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * PasswordField =[temp objectForKey:@"PasswordField"];
    
    if ([field4.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter current password."]];
    }
    else if ([field5.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter new password."]];
    }
    else if ([field6.text isEqualToString:@""])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter confirm password."]];
    }
    else if (![field5.text isEqualToString:field6.text])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"New password and confirm password not matching."]];
    }
    else if ([field4.text isEqualToString:field5.text])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Current password and new password same so please choose different."]];
    }
    else if (![PasswordField isEqualToString:field4.text])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Current password is not correct."]];
    }
    else
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        NSDictionary * Result_Dict = [Webmethods Updatepassword:field5.text];
        NSString * Satus=[Result_Dict valueForKey:@"status"];
        NSString * message=[Result_Dict valueForKey:@"message"];
        if ([Satus integerValue]==0)
        {
           [self.view addSubview:[[ToastAlert alloc] initWithText:message]];
        }
        else
        {
            
            [[NSUserDefaults standardUserDefaults] setValue:field5.text forKey:@"PasswordField"];
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Password changed successfully"]];
            [self performSelector:@selector(getDataSelector) withObject:nil afterDelay:3];
        }
    }
}

-(void)getDataSelector
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CustomerDict"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"oauth_token"];
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"globalcartid"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSideMenu" object:nil userInfo:nil];
    appDelegate.bangeStr = @"0";
    MainCategoryVC *homeVC;
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
-(IBAction)radio_button:(id)sender
{
    if (pos==YES)
    {
        [ChangepasswordView setHidden:NO];
        [radio_button setImage:[UIImage imageNamed:@"radio_checked.png"] forState:UIControlStateNormal];
        pos=!pos;
    }
    else{
        [radio_button setImage:[UIImage imageNamed:@"radio_unchecked.png"] forState:UIControlStateNormal];
        [ChangepasswordView setHidden:YES];
        pos=!pos;
    }
    
    
}

- (IBAction)cancel_btn:(UIButton *)sender {
    [radio_button setImage:[UIImage imageNamed:@"radio_unchecked.png"] forState:UIControlStateNormal];
    ChangepasswordView.hidden = YES;
    pos = !pos;
}
- (IBAction)backBtnAct:(id)sender
{
    if (sender == logoLargeBtn)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}


- (IBAction)menuBtnAct:(UIButton *)sender {
    
    if (sender == _menuBtnObj)
    {
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    else if (sender==  offerObj)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
       
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            productVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//        }
//        else
//        {
//            productVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//        }
        
        productVC.productHeader = appDelegate.GlobalOfferName;
        productVC.categoryUrl = appDelegate.GlobalofferURL;
        //            itemDetailsVC.offerCheckBool = YES;
        productVC.productDetailsDict = [appDelegate.offerUrlDict valueForKey:@"data"];
        [self.navigationController pushViewController:productVC animated:YES];
    }
    else if (sender == searchBtnObj)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
//        if (searchBar.hidden == YES)
//        {
//            searchBar.hidden = NO;
//            logoSmallImg.hidden = NO;
//            logoLargeImg.hidden = YES;
//            logoLargeBtn.hidden = YES;
//            _searchBg.hidden = NO;
//        }
//        else
//        {
//            searchBar.hidden = YES;
//            logoSmallImg.hidden = YES;
//            logoLargeImg.hidden = NO;
//            logoLargeBtn.hidden = NO;
//            _searchBg.hidden = YES;
//            if (searchBar.text.length > 0)
//            {
//                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
//            itemDetailsVC = [[ItemDetailsVC alloc] initWithNibName:@"ItemDetailsVC" bundle:nil];
//        }
//        else
//        {
//            itemDetailsVC = [[ItemDetailsVC alloc] initWithNibName:@"ItemDetailsVC~iPad" bundle:nil];
//        }
//                itemDetailsVC.searchStr = searchBar.text;
//                itemDetailsVC.sortStr = @"Search";
//                [self.navigationController pushViewController:itemDetailsVC animated:NO];
//            }
//        }
    }
    else if (sender == myProfileBtnObj)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        NSString * oauth_token =[temp objectForKey:@"oauth_token"];
        
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
            MyProfileVC *myProfile;
            
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
                myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC" bundle:nil];
//            }
//            else
//            {
//                myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC~iPad" bundle:nil];
//            }
            [self.navigationController pushViewController:myProfile animated:NO];
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
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)keyboardWillShow:(NSNotification *)note
{
    if ([field4 isFirstResponder] == YES || [field6 isFirstResponder] == YES || [field5 isFirstResponder] == YES)
    {
        CGRect keyboardBounds = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        
        [UIView animateWithDuration:0.3 animations:^{
            ChangepasswordView.transform = CGAffineTransformMakeTranslation(0, -keyboardBounds.size.height+140);
            editView.transform = CGAffineTransformMakeTranslation(0, -keyboardBounds.size.height+140);
            
        }];
        
        self.isKeyboradShow = YES;
    }
    
}



- (void)keyboardWillHide:(NSNotification *)note
{
    self.isKeyboradShow = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        ChangepasswordView.transform = CGAffineTransformIdentity;
        editView.transform = CGAffineTransformIdentity;
        
    }];
}
-(void)doneWithNumberPad{
    
    [field6 resignFirstResponder];
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(mobileNoTxtFld == textField)
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 10) ? NO : YES;
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
                MainCategoryVC * mainCategoryVC=[[MainCategoryVC alloc]initWithNibName:@"MainCategoryVC" bundle:nil];
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
                CategoryPage * Categoryvc=[[CategoryPage alloc]initWithNibName:@"CategoryPage" bundle:nil];
                [self.navigationController pushViewController:Categoryvc animated:YES];
            }
        }
            break;
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
            NSString * oauth_token =[temp objectForKey:@"oauth_token"];
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
                
                MyProfileVC *myProfile;
                
//                if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//                {
                    myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC" bundle:nil];
//                }
//                else
//                {
//                    myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC~iPad" bundle:nil];
//                }
                [self.navigationController pushViewController:myProfile animated:NO];
                
            }
            
            break;
            
    }
}


- (IBAction)otpCancelBtnAct:(UIButton *)sender
{
    enterOTPTxtFld.text = @"";
    [otpView removeFromSuperview];
}

- (IBAction)otpVerifyBtnAct:(UIButton *)sender {
    
    //
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO)
    {
        return ;
    }
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating22:) toTarget:self withObject:nil];
    
    NSString * Requrl= [NSString stringWithFormat:@"%@/profile/", baseUrl1];
    NSString *Finalurl=[Requrl stringByAppendingString:[[Customer_Dict valueForKey:@"data"] valueForKey:@"customerid"]];
    UpdateCustomer_Dict= [Webmethods UpdateCustomer:Finalurl andDict:field1.text andLastName:field2.text andEmail:field3.text crmid:field7.text mobile:mobileNoTxtFld.text otp:enterOTPTxtFld.text];
    
    if ([[UpdateCustomer_Dict valueForKey:@"status"] integerValue]==1)
    {
        [otpView removeFromSuperview];
        
        
        NSMutableDictionary * userDict = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"]];
        NSMutableDictionary *userInfoDict = [[NSMutableDictionary alloc] initWithDictionary:[userDict valueForKey:@"data"]];
        [userInfoDict setObject:field1.text forKey:@"firstname"];
        [userInfoDict setObject:field2.text forKey:@"lastname"];
        [userInfoDict setObject:field3.text forKey:@"email"];
        [userInfoDict setObject:field7.text forKey:@"crmid"];
        [userInfoDict setObject:mobileNoTxtFld.text forKey:@"mobile"];
        [userDict setObject:userInfoDict forKey:@"data"];
        [[NSUserDefaults standardUserDefaults] setValue:userDict forKey:@"CustomerDict"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateSideMenu" object:nil userInfo:nil];
        
//        otpView.center = self.view.center;
//        [self.view addSubview:otpView];
    }
    else{
    }
    [self.view addSubview:[[ToastAlert alloc] initWithText:[UpdateCustomer_Dict valueForKey:@"message"]]];
    [SVProgressHUD dismiss];


}
- (IBAction)resendOtpBtnAct:(UIButton *)sender
{
    
    if (field1.text.length < 1 || [field1.text isEqualToString:@" "])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter first name"]];
        return ;
    }
    else if (field2.text.length < 1 || [field2.text isEqualToString:@" "])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter last name"]];
        return ;
    }
    else if (field3.text.length < 1 || [field3.text isEqualToString:@" "])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter email address"]];
        return ;
    }
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO)
    {
        return ;
    }
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating22:) toTarget:self withObject:nil];
    
    NSString * Requrl= [NSString stringWithFormat:@"%@/profile/", baseUrl1];
    NSString *Finalurl=[Requrl stringByAppendingString:[[Customer_Dict valueForKey:@"data"] valueForKey:@"customerid"]];
    UpdateCustomer_Dict= [Webmethods UpdateCustomer:Finalurl andDict:field1.text andLastName:field2.text andEmail:field3.text crmid:field7.text mobile:mobileNoTxtFld.text];
    
    if ([[UpdateCustomer_Dict valueForKey:@"status"] integerValue]==1)
    {
//        otpView.center = self.view.center;
//        [self.view addSubview:otpView];
    }
    else{
    }
    
    [self.view addSubview:[[ToastAlert alloc] initWithText:[UpdateCustomer_Dict valueForKey:@"message"]]];
    
    [SVProgressHUD dismiss];
    
}



@end
