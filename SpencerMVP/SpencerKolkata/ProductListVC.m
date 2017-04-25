//
//  ProductListVC.m
//  Spencer
//
//  Created by binary on 06/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "ProductListVC.h"
#import "AppDelegate.h"
#import "Webmethods.h"
#import "SortFilterVC.h"
//#import "SearchView.h"

#import "ProductVC.h"
#import "InCartVC.h"
#import "ManualLocationVC.h"
#import "CategoryPage.h"

#import "OfferVC.h"
#import "UIImageView+WebCache.h"


@interface ProductListVC ()
{
    AppDelegate *appDelegate;
    ProductVC *productVC;
    SortFilterVC *sortFilterVC;
    InCartVC *inCartVC;
//    SearchView *sv;
    
    ManualLocationVC *manualLocationVC;
    int headerHeight;
    NSString *cacheImgStr;
}
@end

@implementation ProductListVC
@synthesize menuHeader, productHeader, productListArray, listImageArray;
@synthesize cartBtnObj, footerImg, logoLargeImg, logoSmallImg, menuBtnObj, myProfileBtnObj, myProfileImg, searchBtnObj, bangeLbl;

@synthesize productVC;
@synthesize  logoLargeBtn;
@synthesize preservedListArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"Product Sub Category Screen";
    
    headerHeight = 0;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    bangeLbl.layer.cornerRadius = 9;
    bangeLbl.layer.masksToBounds = YES;
    bangeLbl.layer.borderColor = [UIColor whiteColor].CGColor;
    bangeLbl.layer.borderWidth = 1;
    
    
    preservedListArray = [[NSMutableArray alloc] initWithArray:productListArray];
    
    
    productListArray = nil;
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    screenX = [UIScreen mainScreen].bounds.origin.x;
    screenY =[UIScreen mainScreen].bounds.origin.y;
    
    _dropdown = [[VSDropdown alloc]initWithDelegate:self];
    [_dropdown setAdoptParentTheme:YES];
    [_dropdown setShouldSortItems:YES];
    //self.screenName = menuHeader;
    
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDelegate.ACPBool = 1;
    
    // Do any additional setup after loading the view from its nib.
    [itemListTblVew reloadData];
    [self setupView];
    
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.delegate = self;
    
    
//    UIScrollView *headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 150, width-20, 145)];
//    [self.view addSubview:headerScrollView];
//    headerScrollView.pagingEnabled = YES;
//    for (int i = 0; i < 2;i++)
//    {
//        UIImageView *headerImgVew = [[UIImageView alloc] initWithFrame:CGRectMake(i*(width-20), 0, width-20, 145)];
//        headerImgVew.contentMode = UIViewContentModeScaleToFill;
//        headerImgVew.image = [UIImage imageNamed:[NSString stringWithFormat:@"carousel_img%i.jpg", i+1]];
//        [headerScrollView addSubview:headerImgVew];
//    }
//    headerScrollView.contentSize = CGSizeMake((width-20)*2, 145);
    
    
//    _scrollMenu = [[ACPScrollMenu alloc] initWithFrame:CGRectMake(10, 155, width-20, 50)];
//    _scrollMenu.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
//    [self.view addSubview:_scrollMenu];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    itemListTblVew.contentInset = UIEdgeInsetsZero;
    itemListTblVew.scrollIndicatorInsets = UIEdgeInsetsZero;
    itemListTblVew.contentOffset = CGPointMake(0.0, 0.0);
    
//    UIButton *filterBtnObj = [UIButton buttonWithType: UIButtonTypeCustom];
//    filterBtnObj.frame = CGRectMake(width-73, 155, 60, 50);
//    filterBtnObj.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
//    [filterBtnObj addTarget:self action:@selector(filterBtnAct:) forControlEvents:UIControlEventTouchUpInside];
//    [filterBtnObj setImage:[UIImage imageNamed:@"ic_sort.png"] forState:UIControlStateNormal];
//    [self.view addSubview:filterBtnObj];
    
//    [self setUpACPScroll];
    
    [self SubCategory:0];
    
    
    
    viewAllBtnObj.layer.cornerRadius = 20;
    viewAllBtnObj.layer.masksToBounds = YES;
    viewAllBtnObj.layer.borderColor = [UIColor whiteColor].CGColor;
    viewAllBtnObj.layer.borderWidth = 1;
    
//    viewAllBtnObj.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:173.0/255.0 blue:106.0/255.0 alpha:1];
    
    viewAllBtnObj.backgroundColor = kColor_Orange;
    
    
}

-(void)navigationView
{
    
    _headerLbl.text = _headerTitleStr;
    UIButton *backBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0f, -30.0f, 0.0f, 0.0f);
    UIImage *backBtnImage = [UIImage imageNamed:@"ic_left_arw.png"];
//    [backBtn setBackgroundColor:[UIColor redColor]];
    [backBtn setImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 40, 40);
    UIBarButtonItem *menubutton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:menubutton , nil]];
    self.navigationItem.leftBarButtonItem = menubutton;
    
    UIButton *titleLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [titleLabelButton setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"userLocation"] forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleLabelButton;
    
    NSMutableArray *arrRightBarItems = [[NSMutableArray alloc] init];
    
    
    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIButton *btnLib = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLib setImage:[UIImage imageNamed:@"ic_cart.png"] forState:UIControlStateNormal];
    btnLib.frame = CGRectMake(0, 0, 32, 32);
    ////btnLib.showsTouchWhenHighlighted=YES;
    [btnLib addTarget:self action:@selector(inCartBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:btnLib];
    [arrRightBarItems addObject:barButtonItem2];
    
    
    [btnSetting setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
    btnSetting.frame = CGRectMake(0, 0, 32, 32);
    //btnSetting.showsTouchWhenHighlighted=YES;
    [btnSetting addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    [arrRightBarItems addObject:barButtonItem];
    
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


- (IBAction)currentLocationBtnAct:(UIButton *)sender
{
    manualLocationVC = [[ManualLocationVC alloc] initWithNibName:@"ManualLocationVC" bundle:nil];
    manualLocationVC.headercheck=@"1001";
    [self.navigationController pushViewController:manualLocationVC animated:YES];
}


-(IBAction)filterBtnAct:(id)sender
{
    sortFilterVC = [[SortFilterVC alloc] initWithNibName:@"SortFilterVC" bundle:nil];
    [self.navigationController pushViewController:sortFilterVC animated:NO];
}

- (void)setUpACPScroll
{
    NSMutableArray * TabsArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < preservedListArray.count; i++)
    {
        [TabsArr addObject:[[preservedListArray objectAtIndex:i] valueForKey:@"name"]];
    }
//    NSArray * TabsArr=[[NSArray alloc]initWithObjects:@"Fruit",@"Vegitables",@"Mango",@"Apple", nil];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"checkbacground_img"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [TabsArr count]; i++)
    {
        if (i==0)
        {
            valuecheck = 0;
        }
        
        
        ACPItem *item = [[ACPItem alloc] initACPItem:nil
                                           iconImage:nil
                                               label:[TabsArr objectAtIndex:i]
                                           andAction: ^(ACPItem *item)
                         {
                             [self SubCategory:i];
                             valuecheck = i;
                         }];
        
        [item setHighlightedBackground:nil iconHighlighted:nil textColorHighlighted:[UIColor darkGrayColor]];
        [array addObject:item];
        [_scrollMenu setUpACPScrollMenu:array];
        [_scrollMenu setAnimationType:ACPZoomOut];
        _scrollMenu.delegate = self;
        
        
    }
    
    
}


-(void) setupView
{
    bangeLbl.layer.cornerRadius = 9;
    bangeLbl.layer.masksToBounds = YES;
    
    
    logoSmallImg.hidden = YES;
    searchBar.hidden = YES;
    logoLargeImg.hidden = NO;
    _searchBg.hidden = YES;
    
    self.footerImg.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:132.0/255.0 blue:36.0/255.0 alpha:1];
    listImageArray = [[NSMutableArray alloc] initWithObjects:@"fruit_vegetables_icon_on.png", @"grocery_staples_icon_on.png", @"nonveg_icon_on.png", @"beverages_icon_on.png", @"branded_food_icon_on.png", @"bread_dairy_icon_on.png", @"personal_care_icon_on.png", @"household_icon_on.png", nil];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:11];
    }
    else
    {
        bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:15];
    }
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    bangeLbl.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
    [self navigationView];
    
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
    
    [searchBar1 resignFirstResponder];
    
    pageNumber = 1;
    //    itemListTblVew.userInteractionEnabled=YES;
    UITapGestureRecognizer *letterTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(highlightLetter:)];
    letterTapRecognizer.numberOfTapsRequired = 1;
    [logoLargeImg addGestureRecognizer:letterTapRecognizer];
    bangeLbl.text = appDelegate.bangeStr;
    if ([bangeLbl.text integerValue] > 0)
    {
        bangeLbl.hidden = NO;
    }
    else
    {
        bangeLbl.hidden = YES;
    }
    
    [itemListTblVew reloadData];
}


-(void)SubCategory:(int) index
{
    [SVProgressHUD show];
    NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/categories/catid/%@?store=%@&version=1.0", baseUrl1, [[preservedListArray objectAtIndex:index] valueForKey:@"category_id"], storeIdStr]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             productDetailsDict = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:0
                                                                                   error:NULL];
             
             if ([[productDetailsDict valueForKey:@"status"] integerValue] == 1)
             {
                productListArray = [[productDetailsDict valueForKey:@"data"] valueForKey:@"categories"];
                [itemListTblVew reloadData];
             }
             
             [SVProgressHUD dismiss];
             
             
//             if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//             {
//                 productVC = [[pro alloc] initWithNibName:@"ItemListVC" bundle:nil];
//                 itemListVC.productListArray = [[productDetailsDict valueForKey:@"data"] valueForKey:@"categories"];
//             }
//             else
//             {
//                 itemListVC = [[ItemListVC alloc] initWithNibName:@"ItemListVC~iPad" bundle:nil];
//                 itemListVC.productListArray = [[productDetailsDict valueForKey:@"data"] valueForKey:@"categories"];
//             }
             
//             [self.navigationController pushViewController:itemListVC animated:NO];
         }
         else
         {
             [SVProgressHUD dismiss];
         }
     }];

}


//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 1;
//}


-(void)getDataSelector
{
    selected=NO;
    
}




//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return menuHeader;
//}





- (IBAction)menuBtnAct:(UIButton *)sender {
    
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
            productVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//        }
//        else
//        {
//            productVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//        }
        
//        productVC.productHeader = appDelegate.GlobalOfferName;
//        productVC.categoryUrl = appDelegate.GlobalofferURL;
//        productVC.productDetailsDict = [appDelegate.offerUrlDict valueForKey:@"data"];
        [self.navigationController pushViewController:productVC animated:YES];
        
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
        
        }
    }
    else if (sender == logoLargeBtn)
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}
- (void)highlightLetter:(UITapGestureRecognizer*)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self searchBtnAct];
    
    return YES;
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
        
        
        NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sb.php?q=%@&storeid=%@&customergroupid=%@&storetimestamp=%@&currencycode=%@&timestamp=%@",solarSearchUrl, urlEncoded, storeId, @"0", @"1466176750", @"INR", @"1466156966987"]]];
        NSURLResponse * response = nil;
        NSError * error = nil;
        NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                              returningResponse:&response
                                                          error:&error];
        if (error == nil)
        {
            NSError *jsonError = nil;
            NSDictionary * searchFinalDict= [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
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


- (IBAction)backBtnAct:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)inCartBtnAct:(UIButton *)sender
{
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

#pragma mark SearchBar

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchVC = [[SearchVC alloc] initWithNibName:@"SearchVC" bundle:nil];
    [self.navigationController pushViewController:searchVC animated:NO];
    [searchBar1 resignFirstResponder];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
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
            break ;
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
        {
            NSUserDefaults * temp=[NSUserDefaults standardUserDefaults];
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
            
        }
            
            break;
            
            
        default:
            break;
    }
}

#pragma mark UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        UIView *footer  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)];
        footer.backgroundColor = [UIColor whiteColor];
        
        UIButton *viewAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        viewAllBtn.frame = footer.frame;
        [viewAllBtn setBackgroundColor:[UIColor clearColor]];
        [viewAllBtn setTitle:@"View All" forState:UIControlStateNormal];
        [viewAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [viewAllBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
        viewAllBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
        [viewAllBtn addTarget:self action:@selector(viewAllButtonAct:) forControlEvents:UIControlEventTouchUpInside];
        [footer addSubview:viewAllBtn];
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-25, 18, 7, 13)];
        image.alpha = 0.5f;
        [image setImage:[UIImage imageNamed:@"leftarrow.png"]];
        [footer addSubview:image];
        return footer;
    }
    return nil;
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
    if ([itemListTblVew respondsToSelector:@selector(setSeparatorInset:)]) {
        [itemListTblVew setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([itemListTblVew respondsToSelector:@selector(setLayoutMargins:)]) {
        [itemListTblVew setLayoutMargins:UIEdgeInsetsZero];
    }
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 1)
//    {
//        return 40;
//    }
//    return 0;
//}
-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1)
    {
        return 44.0;
    }
    return 0.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        return 80;
    }
    return 0.0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
        
        appDelegate.categoryId = (int)[[[productListArray objectAtIndex:indexPath.row] valueForKey:@"category_id"] integerValue];
        
        //        http://apis.spencers.in/api/rest/category/products/%@?page=%i&store=%@
        //        http://apis.spencers.in/api/rest/category/products/81/?sort=popular&dir=desc&store=11
        
        NSString *  storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/category/products/%@/?sort=popular&dir=desc&store=%@&page=%i", baseUrl1, [[productListArray objectAtIndex:indexPath.row] valueForKey:@"category_id"], storeIdStr, pageNumber];
        
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            productVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//        }
//        else
//        {
//            productVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//        }
        
        productVC.productHeader = [[productListArray objectAtIndex:indexPath.row] valueForKey:@"name"];
        productVC.categoryUrl = urlStr;
        [self.navigationController pushViewController:productVC animated:YES];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        NSLog(@"%@", [NSString stringWithFormat:@"%@/media/catalog/category/mobile/banners/banner_%i.jpg", baseBannerUrl1, _catId]);
        [self checkWhetherFileExistsIn:[NSURL URLWithString:[NSString stringWithFormat:@"%@/media/catalog/category/mobile/banners/banner_%i.jpg", baseBannerUrl1, _catId]] Completion:^(BOOL success, NSString *fileSize) {
            if (success)
            {
               
                
            }
            else
            {
                
            }
        }];
        return headerHeight;
    }
    else if (section == 1)
    {
        return 50;
    }
    return 0;
}

-(void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (section == 0)
    {
        
    }
    else if (section == 1)
    {
        if ([view isKindOfClass: [UITableViewHeaderFooterView class]])
        {
            UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
            UIView* content = castView.contentView;
            UIColor* color = [UIColor colorWithRed:86.0/255.0 green:134.0/255.0 blue:0.0/255.0 alpha:1]; // substitute your color here
            content.backgroundColor = color;
            [castView.textLabel setTextColor:[UIColor whiteColor]];
            castView.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
            
            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            {
                castView.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
            }
            else
            {
                castView.textLabel.font = [UIFont fontWithName:@"Helvetica" size:21];
            }
            
        }
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        static NSString *Identifier = @"Cell2";
        UITableViewCell *cell;
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        
        //    UIImageView *cellBackground = [[UIImageView alloc] initWithFrame:CGRectMake(8, 4, self.view.frame.size.width-16, 76)];
        //    cellBackground.image = [UIImage imageNamed:@"header.png"];
        //    cellBackground.layer.cornerRadius=7.0f;
        //    [cell addSubview:cellBackground];
        UIImageView *productImgVew = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 70, 70)];
        //    productImgVew.image = [UIImage imageNamed:@"fruite_vegitables.png"];
        NSArray *imageArray  = [[[productListArray objectAtIndex:indexPath.row] valueForKey:@"thumb_img"] componentsSeparatedByString:@"/"];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (imageArray.count >  0)
        {
            productImgVew.image = [UIImage imageNamed:[imageArray lastObject]];
            if (productImgVew.image == nil)
            {
                productImgVew.image = [UIImage imageNamed:@"placeholder.jpg"];
            }
            //        productImgVew.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"placeholder.jpg"]];
        }
        else
        {
            productImgVew.image = [UIImage imageNamed:@"placeholder.jpg"];
        }
        
        //    [productImgVew sd_setImageWithURL:[NSURL URLWithString:[[productListArray objectAtIndex:indexPath.row] valueForKey:@"thumb_img"]] placeholderImage:[UIImage imageNamed:@""]];
        [cell addSubview:productImgVew];
        UILabel *productTitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(84, 10, self.view.frame.size.width-100, 54)];
        productTitleLbl.numberOfLines = 2;
        productTitleLbl.text = [[productListArray objectAtIndex:indexPath.row] valueForKey:@"name"];
        productTitleLbl.textColor = [UIColor blackColor];
        
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            productTitleLbl.font = [UIFont fontWithName:@"Helvetica" size:17];
        }
        else
        {
            productTitleLbl.font = [UIFont fontWithName:@"Helvetica" size:21];
        }
        
        [cell addSubview:productTitleLbl];
        cell.backgroundColor=[UIColor whiteColor];
        [tableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgdimg.png"]]];
        return cell;
    }
    return nil;
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return productListArray.count;
    }
    return 0;
}


-(void)checkWhetherFileExistsIn:(NSURL *)fileUrl Completion:(void (^)(BOOL success, NSString *fileSize ))completion
{
    //MAKING A HEAD REQUEST
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:fileUrl];
    request.HTTPMethod = @"HEAD";
    request.timeoutInterval = 3;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
         if (connectionError == nil) {
             if ((long)[httpResponse statusCode] == 200)
             {
                 //FILE EXISTS
                 headerHeight = 1;
                 NSDictionary *dic = httpResponse.allHeaderFields;
//                 NSLog(@"Response 1 %@",[dic valueForKey:@"Content-Length"]);
                 completion(TRUE,[dic valueForKey:@"Content-Length"]);
                  headerHeight=itemListTblVew.frame.size.width/2;
             }
             else
             {
                 //FILE DOESNT EXIST
//                 NSLog(@"Response 2");
                 completion(FALSE,@"");
                  headerHeight=0;
             }
         }
         else
         {
//             NSLog(@"Response 3");
             completion(FALSE,@"");
              headerHeight=0;
         }
         
     }];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
//    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    
    
    [[SDImageCache sharedImageCache] removeImageForKey:cacheImgStr fromDisk:YES];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, headerHeight)];
        image.image=nil;
        cacheImgStr = [NSString stringWithFormat:@"%@/media/catalog/category/mobile/banners/banner_%i.jpg", baseBannerUrl1, _catId];
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/media/catalog/category/mobile/banners/banner_%i.jpg", baseBannerUrl1, _catId]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"] options:SDWebImageCacheMemoryOnly];
        
//
        
//        http://spencers.in/media/catalog/category/mobile/banners/banner_CATID.jpg
//        image.image = [UIImage imageNamed:@"carousel_img1.jpg"];
        return image;
    }
    if (section == 1)
    {
        
        if (headerView == nil)
        {
            headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
            _scrollMenu = [[ACPScrollMenu alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
            _scrollMenu.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
            [headerView addSubview:_scrollMenu];
            [self setUpACPScroll];
            return headerView;
        }
        else
        {
            return headerView;
        }
        
        
        
        
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    [imageCache clearMemory];
    [imageCache clearDisk];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewAllButtonAct:(UIButton *)sender
{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandIdSearchArr"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"quantityIdSearchArr"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandIdMyArr"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"quantityIdMyArr"];

    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    
    
    appDelegate.categoryId = (int)[[[productListArray objectAtIndex:sender.tag] valueForKey:@"parent_id"] integerValue];
    NSString *  storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/category/products/%i/?store=%@&page=%i", baseUrl1, appDelegate.categoryId, storeIdStr, pageNumber];
    
    
    
//    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
        productVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//    }
//    else
//    {
//        productVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//    }
    
    productVC.productHeader = [[preservedListArray objectAtIndex:valuecheck] valueForKey:@"name"];
    productVC.categoryUrl = urlStr;
    [self.navigationController pushViewController:productVC animated:YES];
}

@end
