//
//  MyOrdersVC.m
//  MeraGrocer
//
//  Created by Binarysemantics  on 6/12/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import "MyOrdersVC.h"
#import "AppDelegate.h"

#import "ProductVC.h"
#import "Webmethods.h"
#import "InCartVC.h"
#import "MyProfileVC.h"

#import "MainCategoryVC.h"
#import "LoginVC.h"
#import "CategoryPage.h"

#import "OfferVC.h"

#import "ProductVC.h"

@interface MyOrdersVC ()
{
    AppDelegate *appDelegate;
    ProductVC *itemDetailsVC;
    
    CategoryPage *Categoryvc;
    NSUserDefaults * temp;
    NSString *oauth_token;
    InCartVC *inCartVC;
    ProductVC *productVC;
}
@end

@implementation MyOrdersVC

@synthesize  cartBtnObj, footerImg, logoLargeImg, logoSmallImg, menuBtnObj, myProfileBtnObj, myProfileImg, searchBar, searchBtnObj, bangeLbl, logoLargeBtn;

@synthesize orders_Dict;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"My Order Screen";
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    _dropdown = [[VSDropdown alloc]initWithDelegate:self];
    [_dropdown setAdoptParentTheme:YES];
    [_dropdown setShouldSortItems:YES];
    
    //self.screenName = @"MyOrder Screen";
    // Do any additional setup after loading the view from its nib.
    
    
    
    [myOrderTblVew setHidden:YES];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [footer_View setHidden:YES];
    [SVProgressHUD show];
    [footer_View setHidden:YES];
    
    
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.delegate = self;
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
//        orders_Dict=  [Webmethods myorders];
        
        if ([[orders_Dict valueForKey:@"status"] integerValue] == 1)
        {
            myOrderTblVew.hidden = NO;
            [orders_Arr valueForKey:[[orders_Dict allKeys] objectAtIndex:0]] ;
            orders_Arr = [orders_Dict valueForKey:@"data"];
        }
        else
        {
            myOrderTblVew.hidden = YES;
            [self performSelector:@selector(backBtnAct:) withObject:nil afterDelay:2];
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"No Order found"]];
        }
        
        
        [self setupView];
        [myOrderTblVew setHidden:NO];
        [myOrderTblVew setDelegate:self];
        [myOrderTblVew setDataSource:self];
        [myOrderTblVew reloadData];
        
        [footer_View setHidden:NO];
        [SVProgressHUD dismiss];
    });
    
    
}

-(void)setupView
{
    self.footerImg.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:132.0/255.0 blue:36.0/255.0 alpha:1];
    logoSmallImg.hidden = YES;
    searchBar.hidden = YES;
    logoLargeImg.hidden = NO;
    _searchBg.hidden = YES;
    
//    bangeLbl.layer.cornerRadius = 12;
    bangeLbl.layer.masksToBounds = YES;
    
    
    bangeLbl.text = appDelegate.bangeStr;
    
    if ([bangeLbl.text integerValue] > 0)
    {
        bangeLbl.hidden = NO;
    }
    else
    {
        bangeLbl.hidden = YES;
    }
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:11];
    }
    else
    {
        bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:15];
    }
    
    
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
    
    
    [titleLabelButton setTitle:@"My Orders" forState:UIControlStateNormal];
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

- (IBAction)backBtnAct:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([bangeLbl.text integerValue] > 0)
    {
        bangeLbl.hidden = NO;
    }
    else
    {
        bangeLbl.hidden = YES;
    }
    
    [self navigationView];
    
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
    
    
    self.navigationController.navigationBar.hidden = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [orders_Arr count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrdersCell *cell;
    if (cell == nil)
    {
        
        
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            [[NSBundle mainBundle] loadNibNamed:@"MyOrdersCell" owner:self options:nil];
//        }
//        else
//        {
//            [[NSBundle mainBundle] loadNibNamed:@"MyOrdersCell~iPad" owner:self options:nil];
//        }
        
        cell = _myOrdersCell;
    }
    
    
    cell.Orderno_Lbl.text = [[orders_Arr objectAtIndex:indexPath.row] valueForKey:@"increment_id"];
    
    NSString *statusStr = [[[orders_Arr objectAtIndex:indexPath.row] valueForKey:@"status"] capitalizedString];
    statusStr =[statusStr stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    cell.Status_Lbl.text = statusStr;
    
    cell.PlacedOn_Lbl.text = [NSString stringWithFormat:@"Placed on: %@",[[orders_Arr  objectAtIndex:indexPath.row] valueForKey:@"created_at"]];
    NSArray *orderCountArr = [[orders_Arr  objectAtIndex:indexPath.row] valueForKey:@"order_items"];
    
    cell.Price_Lbl.text =[NSString stringWithFormat:@"Rs. %.2f %lu/items",[[[orders_Arr objectAtIndex:indexPath.row] valueForKey:@"subtotal_incl_tax"] floatValue], (unsigned long)[orderCountArr count]] ;
    cell.Totalamount_Lbl.text =[NSString stringWithFormat:@"Total Amount: %.2f",[[[orders_Arr objectAtIndex:indexPath.row] valueForKey:@"grand_total"] floatValue]];
    
    

    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        cell.Orderno_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.Status_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.PlacedOn_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.Price_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
        cell.Totalamount_Lbl.font = [UIFont fontWithName:@"Helvetica" size:15];
    }
    else
    {
        cell.Orderno_Lbl.font = [UIFont fontWithName:@"Helvetica" size:19];
        cell.Status_Lbl.font = [UIFont fontWithName:@"Helvetica" size:19];
        cell.PlacedOn_Lbl.font = [UIFont fontWithName:@"Helvetica" size:19];
        cell.Price_Lbl.font = [UIFont fontWithName:@"Helvetica" size:19];
        cell.Totalamount_Lbl.font = [UIFont fontWithName:@"Helvetica" size:19];
    }
    
    [cell.Status_Lbl setTextColor:[UIColor orangeColor]];

    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tempView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
//    tempView.backgroundColor=[UIColor colorWithRed:86.0/255.0 green:134.0/255.0 blue:0.0/255.0 alpha:1];
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,-10,300,44)];
    tempLabel.backgroundColor=[UIColor clearColor];
    tempLabel.textColor = [UIColor whiteColor];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        tempLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    }
    else
    {
        tempLabel.font = [UIFont fontWithName:@"Helvetica" size:21];
    }
    
//    tempLabel.text=@"My Orders";
    [tempView addSubview:tempLabel];
    
    
    
//    UILabel *locationLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-150,-10, 150,44)];
//    locationLabel.backgroundColor=[UIColor clearColor];
//    locationLabel.textAlignment= NSTextAlignmentRight;
//    locationLabel.textColor = [UIColor whiteColor];
//    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
//        locationLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
//    }
//    else
//    {
//        locationLabel.font = [UIFont fontWithName:@"Helvetica" size:21];
//    }
//    
//    NSString *rstring = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_name_token"];
//    [locationLabel setText:rstring];
//    
//    [tempView addSubview:locationLabel];
    
    
    return tempView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
        orderDetailsVC = [[OrderDetailsVC alloc] initWithNibName:@"OrderDetailsVC" bundle:nil];
//    }
//    else
//    {
//        orderDetailsVC = [[OrderDetailsVC alloc] initWithNibName:@"OrderDetailsVC~iPad" bundle:nil];
//    }
    
    
    [self.navigationController pushViewController:orderDetailsVC animated:YES];
    orderDetailsVC.orderArr = [orders_Arr objectAtIndex:indexPath.row];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 164;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (IBAction)deleteMyOrdersBtnAct:(UIButton *)sender
{
    [myOrdersArray removeObjectAtIndex:sender.tag];
    [myOrderTblVew reloadData];
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



- (IBAction)menuBtnAct:(UIButton *)sender
{
    
    if (sender == menuBtnObj)
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
        [self searchBtnAct];
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
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    NSLog(@"%@", searchStr);
    _dropdown.hidden = YES;
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
            [self showDropDownForButton:logoLargeBtn adContents:finalarr multipleSelection:YES];
            _dropdown.hidden = NO;
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



-(void)showDropDownForButton:(UIButton *)sender adContents:(NSArray *)contents multipleSelection:(BOOL)multipleSelection
{
    
    [_dropdown setDrodownAnimation:rand()%2];
    
    //    [_dropdown setAllowMultipleSelection:multipleSelection];
    
    [_dropdown setupDropdownForView:sender];
    
    [_dropdown setSeparatorColor:sender.titleLabel.textColor];
    
    if (_dropdown.allowMultipleSelection)
    {
        [_dropdown reloadDropdownWithContents:contents andSelectedItems:nil];
        
    }
    else
    {
        [_dropdown reloadDropdownWithContents:contents andSelectedItems:nil];
        
    }
    
}

#pragma mark -
#pragma mark - VSDropdown Delegate methods.
- (void)dropdown:(VSDropdown *)dropDown didChangeSelectionForValue:(NSString *)str atIndex:(NSUInteger)index selected:(BOOL)selected
{
    UIButton *btn = (UIButton *)dropDown.dropDownView;
    
    NSString *allSelectedItems = nil;
    if (dropDown.selectedItems.count > 1)
    {
        allSelectedItems = [dropDown.selectedItems componentsJoinedByString:@";"];
        
    }
    else
    {
        allSelectedItems = [dropDown.selectedItems firstObject];
        
    }
    searchBar.text = allSelectedItems;
    [btn setTitle:allSelectedItems forState:UIControlStateNormal];
    [self searchBtnAct];
}

- (UIColor *)outlineColorForDropdown:(VSDropdown *)dropdown
{
    UIButton *btn = (UIButton *)dropdown.dropDownView;
    
    return btn.titleLabel.textColor;
    
}

- (CGFloat)outlineWidthForDropdown:(VSDropdown *)dropdown
{
    return 2.0;
}

- (CGFloat)cornerRadiusForDropdown:(VSDropdown *)dropdown
{
    return 3.0;
}

- (CGFloat)offsetForDropdown:(VSDropdown *)dropdown
{
    return -2.0;
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
                Categoryvc=[[CategoryPage alloc]initWithNibName:@"CategoryPage" bundle:nil];
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
            
            
        default:
            break;
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([myOrderTblVew respondsToSelector:@selector(setSeparatorInset:)]) {
        [myOrderTblVew setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([myOrderTblVew respondsToSelector:@selector(setLayoutMargins:)]) {
        [myOrderTblVew setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
