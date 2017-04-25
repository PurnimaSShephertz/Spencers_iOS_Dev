//
//  MyCreditsView.m
//  MeraGrocer
//
//  Created by Binary Semantics on 6/29/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import "MyCreditsView.h"
#import "Webmethods.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "ProductVC.h"
#import "LoginVC.h"
#import "MyProfileVC.h"
#import "InCartVC.h"

#import "MainCategoryVC.h"
#import "CategoryPage.h"
#import "OfferVC.h"
#import "ProductVC.h"

@interface MyCreditsView () <UITextFieldDelegate>
{
    AppDelegate *appDelegate;
    MainCategoryVC *mainCategoryVC;
    CategoryPage *categoryPage;
    NSUserDefaults *temp;
    
    InCartVC *inCartVC;
    ProductVC *productVC;
}
@end

@implementation MyCreditsView
@synthesize logoLargeBtn;

@synthesize searchBtnObj, cartBtnObj, myProfileBtnObj;
@synthesize bangeLbl;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"My Credit Screen";
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    amountTxtFld.delegate = self;
    
    _Recharge_Button.layer.cornerRadius = 22;
    _Recharge_Button.layer.masksToBounds = YES;
    _Recharge_Button.backgroundColor = kColor_Orange;
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

- (IBAction)backBtnAct:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    
    [titleLabelButton setTitle:@"spencer’s Wallet" forState:UIControlStateNormal];
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


- (void)alttextFieldDidEndEditing:(UITextField *)textField
{
    
}

- (void)alttextViewDidEndEditing:(UITextView *)textView
{
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    [self navigationView];
    
    [SVProgressHUD show];
    
    self.navigationController.navigationBar.hidden = NO;
    
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        YourCreditheader_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
        Mycredit_Lbl.font = [UIFont fontWithName:@"Helvetica" size:12];
        mySRCLbl.font = [UIFont fontWithName:@"Helvetica" size:12];
        mySRCHeaderLbl.font = [UIFont fontWithName:@"Helvetica" size:12];
        TopupHeader_Lbl.font = [UIFont fontWithName:@"Helvetica" size:12];
        Recentactions_Lbl.font = [UIFont fontWithName:@"Helvetica" size:12];
        CretbalenceHeader_Lbl.font = [UIFont fontWithName:@"Helvetica" size:11];
        addedHeader_Lbl.font = [UIFont fontWithName:@"Helvetica" size:11];
        DateHeader_Lbl.font = [UIFont fontWithName:@"Helvetica" size:11];
        Actionheadet_Lbl.font = [UIFont fontWithName:@"Helvetica" size:11];
        locationLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
    }
    else
    {
        YourCreditheader_Lbl.font = [UIFont fontWithName:@"Helvetica" size:19];
        Mycredit_Lbl.font = [UIFont fontWithName:@"Helvetica" size:19];
        mySRCLbl.font = [UIFont fontWithName:@"Helvetica" size:19];
        mySRCHeaderLbl.font = [UIFont fontWithName:@"Helvetica" size:19];
        TopupHeader_Lbl.font = [UIFont fontWithName:@"Helvetica" size:16];
        Recentactions_Lbl.font = [UIFont fontWithName:@"Helvetica" size:16];
        CretbalenceHeader_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
        addedHeader_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
        DateHeader_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
        Actionheadet_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
        locationLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
    }
    
    
    NSString *rstring = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_name_token"];
    //    locationLbl.font = [UIFont fontWithName:@"Helvetica" size:13];
    [locationLbl setText:rstring];
    
    
    
    [_Mycredits_Table setHidden:YES];
    [footerview setHidden:YES];
//    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
//    [keyBoardController addToolbarToKeyboard];
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    [self walletMethod];
}

-(void)walletMethod
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSDictionary * Wallet_Dict=   [Webmethods getwallet];
        NSString * status = [Wallet_Dict valueForKey:@"status"];
        
        bangeLbl.text = appDelegate.bangeStr;
        
        if ([bangeLbl.text integerValue] > 0)
        {
            bangeLbl.hidden = NO;
        }
        else
        {
            bangeLbl.hidden = YES;
        }
        
//        bangeLbl.layer.cornerRadius = 12;
        bangeLbl.layer.masksToBounds = YES;
        
        
        if ([status integerValue]==1)
        {
            NSString * credits=[[Wallet_Dict valueForKey:@"data"] valueForKey:@"mycredits"];
            Creditlog_Atrray=[[Wallet_Dict valueForKey:@"data"] valueForKey:@"creditlog"];
            Mycredit_Lbl.text=[NSString stringWithFormat:@"%.2f Credits",[credits floatValue]];
            
        }
        
        if ([[[Wallet_Dict valueForKey:@"data"] valueForKey:@"srcpoints"] isEqualToString:@"NA"])
        {
            mySRCLbl.text=@"0.00 Credits";
        }
        else
        {
            mySRCLbl.text=[NSString stringWithFormat:@"%.2f Credits", [[[Wallet_Dict valueForKey:@"data"] valueForKey:@"srcpoints"] floatValue]];
        }
        
        [_Mycredits_Table setDelegate:self];
        [_Mycredits_Table setDataSource:self];
        [_Mycredits_Table reloadData];
        [_Mycredits_Table setHidden:NO];
        [footerview setHidden:NO];
        [SVProgressHUD dismiss];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [Creditlog_Atrray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    MycreditCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            [[NSBundle mainBundle] loadNibNamed:@"MycreditCell" owner:self options:nil];
//        }
//        else
//        {
//            [[NSBundle mainBundle] loadNibNamed:@"MycreditCell~iPad" owner:self options:nil];
//        }
        cell =_addressCell;
    }
    cell.Cretbalence_Lbl.text= [NSString stringWithFormat:@"%.2f", [[[Creditlog_Atrray objectAtIndex:indexPath.row]valueForKey:@"value"] floatValue]];
    cell.added_Lbl.text=[NSString stringWithFormat:@"%.2f",[[[Creditlog_Atrray objectAtIndex:indexPath.row]valueForKey:@"value_change"] floatValue]];
    cell.Date_Lbl.text=[[Creditlog_Atrray objectAtIndex:indexPath.row]valueForKey:@"action_date"];
    cell.Action_Lbl.text=[[Creditlog_Atrray objectAtIndex:indexPath.row]valueForKey:@"action_type"];
    cell.comment_Lbl.text = [[Creditlog_Atrray objectAtIndex:indexPath.row] valueForKey:@"comment"];
    

    
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        cell. Cretbalence_Lbl.font = [UIFont fontWithName:@"Helvetica" size:11];
        cell.added_Lbl.font = [UIFont fontWithName:@"Helvetica" size:11];
        cell.Date_Lbl.font = [UIFont fontWithName:@"Helvetica" size:11];
        cell.Action_Lbl.font = [UIFont fontWithName:@"Helvetica" size:11];
        cell.comment_Lbl.font = [UIFont fontWithName:@"Helvetica" size:11];
    }
    else
    {
        cell. Cretbalence_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.added_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.Date_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.Action_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.comment_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
    }
    
    
        return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
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
        
        ProductVC *itemDetailsVC;
        
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
            loginpage.CheckProfileStatus=@"000";
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
//{
//    data =     {
//        balance = "50.0000";
//        message = "Recharge Successful";
//    };
//    status = 1;
//}
- (IBAction)Recharge_Button:(id)sender
{
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
//    self.Recharge_Button.userInteractionEnabled = NO;
    [amountTxtFld resignFirstResponder];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
    
        if (amountTxtFld.text.length < 1)
        {
            [SVProgressHUD show];
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter coupon code"]];
//            self.Recharge_Button.userInteractionEnabled = YES;
        }
        else
        {
            [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
            
            NSDictionary * Recharge_Dict=[Webmethods recahrge:amountTxtFld.text];
            
            NSString * Status_Str=[Recharge_Dict valueForKey:@"status"];
            
            self.Recharge_Button.userInteractionEnabled = YES;
            
            if ([Status_Str integerValue]==1)
            {
                [SVProgressHUD dismiss];
                [self.view addSubview:[[ToastAlert alloc] initWithText:@"Recharge successful"]];
                [self walletMethod];
//                [self performSelector:@selector(pop)  withObject:nil afterDelay:2];
                
            }
            else
            {
                [SVProgressHUD dismiss];
                [self.view addSubview:[[ToastAlert alloc] initWithText:[Recharge_Dict valueForKey:@"data"]]];
            }
        }
        [SVProgressHUD dismiss];
//    });
    //@"6226-4461-7595-1149"
}
-(void) pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)threadStartAnimating2:(id)dat
{
    [SVProgressHUD show];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
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

@end
