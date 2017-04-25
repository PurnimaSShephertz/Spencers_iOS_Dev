//
//  SearchListVC.m
//  Spencer
//
//  Created by binary on 08/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "SearchListVC.h"
#import "UIImageView+WebCache.h"
#import <Shephertz_App42_iOS_API/Shephertz_App42_iOS_API.h>
//#import "SBJson.h"
#import "ToastAlert.h"
#import "AppDelegate.h"
#import "InCartVC.h"
#import "ProductVC.h"
#import "SearchVC.h"
#import "InCartVC.h"
#import "CategoryPage.h"
#import "ProductDetailPage.h"
#import "OfferVC.h"
#import "Webmethods.h"
#import "SVProgressHUD.h"
#import "ProductVC.h"
#import "SH_TrackingUtility.h"


@interface SearchListVC ()
{
    SearchVC *searchVC;
    AppDelegate *appDelegate;
    NSMutableDictionary *counterDict;
    SortFilterVC *sortFilterVC;
    int count1;
    SearchSortFilterVC *searchSortFilterVC;
    
    NSString *priceStr, *specialPriceStr;
    ProductVC *productVC;
}
@end

@implementation SearchListVC

@synthesize productDetailsDict;
@synthesize productHeader;

@synthesize  cartBtnObj, footerImg, logoLargeImg, logoSmallImg, menuBtnObj, myProfileBtnObj, myProfileImg, searchBar, searchBtnObj, bangeLbl,searchBar1;

@synthesize logoLargeBtn;

@synthesize placeOrderVC;
@synthesize allDataDict;

@synthesize searchStr;
@synthesize sortStr;
@synthesize categoryTag;
@synthesize categoryUrl;
@synthesize offerCheckBool;

    - (void) dealloc {
        // view did load
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:@"FilterSortDataUpdated"
                                                      object:nil];
        
    }
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.screenName = @"Search List Screen";
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandIdSearchArr"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"quantityIdSearchArr"];
    [[NSUserDefaults standardUserDefaults] setInteger:13 forKey:@"sortingSearchIndex"];
    
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    screenX = [UIScreen mainScreen].bounds.origin.x;
    screenY =[UIScreen mainScreen].bounds.origin.y;
    
    _dropdown = [[VSDropdown alloc]initWithDelegate:self];
    [_dropdown setAdoptParentTheme:YES];
    [_dropdown setShouldSortItems:YES];
    
    //self.screenName = productHeader;
    
    cartCountDictLocal = [[NSMutableDictionary alloc] init];
    cartCountModifyDict = [[NSMutableDictionary alloc] init];
    
    
    
    
    storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    
    
    allDataDict = [[NSMutableArray alloc] init];
    
    //searchBar.text = searchStr;
    searchBar1.text = searchStr;
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    
    
    //    productDetailsKeysArray = [productDetailsDict allKeys];
    if (cartCountDict == nil)
    {
        cartCountDict = [[NSMutableDictionary alloc] init];
    }
    if (wishlistCountDict == nil)
    {
        wishlistCountDict = [[NSMutableDictionary alloc] init];
    }
    
    [self setupView];
    kgIndexDict = [[NSMutableDictionary alloc] init];
    for (int i = 0; i < productDetailsDict.count; i++)
    {
        [kgIndexDict setObject:@"0" forKey:[NSString stringWithFormat:@"%i",i]];
    }
    selectedRowsArray=[[NSMutableArray alloc]init];
    contentArray=[[NSMutableArray alloc]init];
    
    _checkImg1.image = [UIImage imageNamed:@"checkbox_1.png"];
    _checkImg2.image = [UIImage imageNamed:@"checkbox_1.png"];
    _checkImg3.image = [UIImage imageNamed:@"checkbox_1.png"];
    //itemDetailsTblVew.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_all.png"]];
    
    [itemDetailsTblVew setBackgroundView:nil];
    [itemDetailsTblVew setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_all.png"]] ];
    __weak SearchListVC *weakSelf = self;
    
    // setup infinite scrolling
    [itemDetailsTblVew addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
    
//    searchBar.returnKeyType = UIReturnKeySearch;
//    searchBar.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleUpdatedData:)
                                                 name:@"FilterSortUpdated"
                                               object:nil];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"quantityId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sortingBy"];
    [self callGetproductsAPI];
    
}

    -(void)handleUpdatedData:(NSNotification *)notification {
        NSLog(@"recieved");
        [itemDetailsTblVew setContentOffset:CGPointZero animated:YES];
        [self callGetproductsAPI];
    }
    
    
#pragma mark SearchBar

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar11
{
    searchVC = [[SearchVC alloc] initWithNibName:@"SearchVC" bundle:nil];
    [self.navigationController pushViewController:searchVC animated:NO];
    [searchBar11 resignFirstResponder];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
}

-(IBAction)backBtnAct:(id)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"quantityId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sortingBy"];
    
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
        MainCategoryVC *mainCategoryVC=[[MainCategoryVC alloc]initWithNibName:@"MainCategoryVC" bundle:nil];
        [self.navigationController pushViewController:mainCategoryVC animated:YES];
    }
    
//    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)inCartBtnAct:(UIButton *)sender
{
    sender.userInteractionEnabled = NO;
    
    if ([bangeLbl.text integerValue] == 0)
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Your Cart is Empty"]];
    }
    else
    {
        InCartVC *inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
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
    [titleLabelButton setTitle:@"Search Results" forState:UIControlStateNormal];
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
    ////btnLib.showsTouchWhenHighlighted=YES;
    [btnLib addTarget:self action:@selector(inCartBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:btnLib];
    [arrRightBarItems addObject:barButtonItem2];
    
    
    filterBtnObj = [UIButton buttonWithType: UIButtonTypeCustom];
    filterBtnObj.frame = CGRectMake(width-80, 5, 30, 30);
    //    filterBtnObj.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    [filterBtnObj addTarget:self action:@selector(filterBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    [filterBtnObj setImage:[UIImage imageNamed:@"ic_sort.png"] forState:UIControlStateNormal];
    UIBarButtonItem *barButtonItem3 = [[UIBarButtonItem alloc] initWithCustomView:filterBtnObj];
    //[self.navigationController.navigationBar addSubview:filterBtnObj];
    
     [arrRightBarItems addObject:barButtonItem3];
    
    //    [btnSetting setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
    //    btnSetting.frame = CGRectMake(0, 0, 32, 32);
    //    //btnSetting.showsTouchWhenHighlighted=YES;
    //    [btnSetting addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    //    [arrRightBarItems addObject:barButtonItem];
    
    bangeLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,-5 , 18, 18)];
    bangeLbl.text = appDelegate.bangeStr;
    bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:9];
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




- (void)insertRowAtBottom {
    
    pageNumber ++;
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    __weak SearchListVC *weakSelf = self;
    
    //    int64_t delayInSeconds = .0;
    //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //        [itemDetailsTblVew beginUpdates];
    
    if (searchStr.length > 0 && [sortStr isEqualToString:@"Search"])
    {
        
//        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"loadmore"] integerValue] == 0)
//        {
//            [itemDetailsTblVew endUpdates];
//            [itemDetailsTblVew.infiniteScrollingView stopAnimating];
//            [self.view addSubview:[[ToastAlert alloc] initWithText:@"No More Products"]];
//            
//            return ;
//        }
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        {
            
            NSString * tempURL1=[NSString stringWithFormat:@"%@/api/rest/solrbridge/search?q=%@&storeid=%@&p=%i", solarSearchUrl , searchStr, storeIdStr  , pageNumber];
            NSString *tempURL;
            if ([quantityId length] > 1 && [brandId length] > 1)
            {
                tempURL = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&order=%@&%@&%@", tempURL1 , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString, quantityId, brandId];
            }
            else if ([quantityId length] > 1)
            {
                tempURL = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&order=%@&%@", tempURL1 , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString, quantityId];
            }
            else if ([brandId length] > 1)
            {
                tempURL = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&order=%@&%@", tempURL1 , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString, brandId];
            }
            else
            {
                tempURL = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&order=%@", tempURL1 , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString];
            }
            
            self.moreBtnObj.hidden = YES;
//            [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
            
            
//            NSLog(@"search %@", tempURL);
            
            NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                         NULL,
                                                                                                         (CFStringRef)tempURL,
                                                                                                         NULL,
                                                                                                         (CFStringRef)@"<>",
                                                                                                         kCFStringEncodingUTF8));
            
            
            
            
            AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:solarSearchUrl]];
            [httpClient setParameterEncoding:AFFormURLParameterEncoding];
            NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                                    path:urlEncoded
                                                              parameters:nil];
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 NSError *jsonError = nil;
                 
                 if (responseObject != 0)
                 {
                     sortStr = @"Search";
                     allDataDict = productDetailsDict;
                     [SVProgressHUD dismiss];
                     tempDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
                     NSArray *arrayCount = [[tempDict valueForKey:@"response"] valueForKey:@"docs"];
                     if ([arrayCount count] == 0)
                     {
                         [self.view addSubview:[[ToastAlert alloc] initWithText:@"No More Products"]];
                     }
                     NSMutableArray * tempArr = [NSMutableArray arrayWithArray:[productDetailsDict arrayByAddingObjectsFromArray:[[tempDict valueForKey:@"response"] valueForKey:@"docs"]]];
                     
                     productDetailsDict = tempArr;
                     appDelegate.filterSearchDict = [[tempDict valueForKey:@"facet_counts"] valueForKey:@"facet_fields"];
                     
//                     NSLog(@"productDetailsDict %@", productDetailsDict);
                     if ([bangeLbl.text integerValue] > 0)
                     {
                         bangeLbl.hidden = NO;
                     }
                     else
                     {
                         bangeLbl.hidden = YES;
                     }
                     
                     if (productDetailsDict.count < 1)
                     {
                         [self.view addSubview:[[ToastAlert alloc] initWithText:@"No product found"]];
                     }
                     
                     if ([[tempDict allKeys] count] < 1)
                     {
                         [self.view addSubview:[[ToastAlert alloc] initWithText:@"No More Products"]];
                     }
                     
                     if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                     {
                         appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                         bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                         productDetailsDict = [tempDict valueForKey:@"data"];
                         
                         
                         
                         for (NSDictionary *cartDict in productDetailsDict)
                         {
                             
                             [cartCountDictLocal setObject:[cartDict valueForKey:@"in_cart"] forKey:[cartDict  valueForKey:@"entity_id"]];
                             [cartCountModifyDict setObject:[cartDict valueForKey:@"cart_itemid"] forKey:[cartDict  valueForKey:@"entity_id"]];
                         }
                         
                         [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                         [[NSUserDefaults standardUserDefaults] synchronize];
                     }
                     else
                     {
                         
                     }
                     [itemDetailsTblVew reloadData];
                     [itemDetailsTblVew endUpdates];
                     [itemDetailsTblVew.infiniteScrollingView stopAnimating];
                 }
                 else
                 {
                     
                 }
                 
                 
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 [SVProgressHUD dismiss];
//                 NSLog(@"Error: %@", error);
             }];
                 [operation start];

            
            
            
            
            
            
            
            
            
            
//            NSURL *url = [NSURL URLWithString:urlEncoded];
//            
//            NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
//            NSString *oauth_token = [temp objectForKey:@"oauth_token"];
//            
//            
//            NSURLRequest *request = [NSURLRequest requestWithURL:url];
//            [NSURLConnection sendAsynchronousRequest:request
//                                               queue:[NSOperationQueue mainQueue]
//                                   completionHandler:^(NSURLResponse *response,
//                                                       NSData *data, NSError *connectionError)
//             {
//                 if (data.length > 0 && connectionError == nil)
//                 {
//                     
//                 }
//                 else
//                 {
//                     // [self.view addSubview:[[ToastAlert alloc] initWithText:@"No Network Found"]];
//                     [SVProgressHUD dismiss];
//                 }
//             }];
//            
//        }
        
        
        
        
        
        
//        if (sortFlag == YES)
//        {
//            self.moreBtnObj.hidden = YES;
//            
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"loadmore"];
//            
//            NSString * tempURL=[NSString stringWithFormat:@"%@/solrbridge/search?q=%@&storeid=%@&p=%i", baseUrl1, searchBar.text, storeIdStr, pageNumber];
//            
//            NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
//                                                                                                         NULL,
//                                                                                                         (CFStringRef)tempURL,
//                                                                                                         NULL,
//                                                                                                         (CFStringRef)@"<>",
//                                                                                                         kCFStringEncodingUTF8));
//            
//            
//            NSURL *url = [NSURL URLWithString:urlEncoded];
//            NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
//            NSString *oauth_token = [temp objectForKey:@"oauth_token"];
//            if(oauth_token==NULL || [oauth_token isEqual:@""])
//            {
//                NSURLRequest *request = [NSURLRequest requestWithURL:url];
//                [NSURLConnection sendAsynchronousRequest:request
//                                                   queue:[NSOperationQueue mainQueue]
//                                       completionHandler:^(NSURLResponse *response,
//                                                           NSData *data, NSError *connectionError)
//                 {
//                     if (data.length > 0 && connectionError == nil)
//                     {
//                         sortStr = @"Search";
//                         allDataDict = productDetailsDict;
//                         NSMutableArray *tempDict;
//                         tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//                         //NSLog(@"tempDict %@", tempDict);
//                         
//                         appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
//                         bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
//                         
//                         if ([bangeLbl.text integerValue] > 0)
//                         {
//                             bangeLbl.hidden = NO;
//                         }
//                         else
//                         {
//                             bangeLbl.hidden = YES;
//                         }
//                         
//                         
//                         if ([[tempDict valueForKey:@"status"] integerValue] == 1)
//                         {
//                             NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[productDetailsDict arrayByAddingObjectsFromArray:[tempDict valueForKey:@"data"]]];
//                             productDetailsDict = tempArr;
//                             
//                             NSMutableArray *tempDicArr = [tempDict valueForKey:@"data"];
//                             
//                             for (NSDictionary *cartDict in tempDicArr)
//                             {
//                                 NSArray *arr = [[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"];
//                                 for (int i = 0; i < [arr count] ; i++ )
//                                 {
//                                     [cartCountDictLocal setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"in_cart"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
//                                     [cartCountModifyDict setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"cart_itemid"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
//                                 }
//                             }
//                             [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
//                             [[NSUserDefaults standardUserDefaults] synchronize];
//                             [itemDetailsTblVew reloadData];
//                         }
//                         else
//                         {
//                             pageNumber--;
//                             [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
//                         }
//                         
//                         [itemDetailsTblVew endUpdates];
//                         [itemDetailsTblVew.infiniteScrollingView stopAnimating];
//                         
//                     }
//                     else
//                     {
//                         [SVProgressHUD dismiss];
//                         //[self.view addSubview:[[ToastAlert alloc] initWithText:@"No Network Found"]];
//                     }
//                 }];
//                
//            }
//            else
//            {
//                
//                
//                NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlEncoded , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
//                NSDictionary *tempDict = [Webmethods search:cartIdStr];
//                
//                // NSLog(@"globalcartid %@", cartIdStr);
//                
//                [SVProgressHUD dismiss];
//                if ([[tempDict valueForKey:@"status"] integerValue] == 1)
//                {
//                    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[productDetailsDict arrayByAddingObjectsFromArray:[tempDict valueForKey:@"data"]]];
//                    productDetailsDict = tempArr;
//                    
//                    appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
//                    bangeLbl.text = appDelegate.bangeStr;
//                    
//                    if ([bangeLbl.text integerValue] > 0)
//                    {
//                        bangeLbl.hidden = NO;
//                    }
//                    else
//                    {
//                        bangeLbl.hidden = YES;
//                    }
//                    
//                    NSMutableArray *tempDicArr = [tempDict valueForKey:@"data"];
//                    
//                    for (NSDictionary *cartDict in tempDicArr)
//                    {
//                        NSArray *arr = [[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"];
//                        for (int i = 0; i < [arr count] ; i++ )
//                        {
//                            [cartCountDictLocal setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"in_cart"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
//                            [cartCountModifyDict setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"cart_itemid"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
//                        }
//                    }
//                    [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    [itemDetailsTblVew reloadData];
//                }
//                else
//                {
//                    pageNumber--;
//                    [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
//                }
//                
//                [itemDetailsTblVew endUpdates];
//                [itemDetailsTblVew.infiniteScrollingView stopAnimating];
//            }
//            
//        }
//        else
//        {
//            self.moreBtnObj.hidden = YES;
//            
//            NSString * tempURL=[NSString stringWithFormat:@"%@/solrbridge/search?q=%@&storeid=%@&p=%i", baseUrl1, searchStr, storeIdStr, pageNumber];
//            NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
//                                                                                                         NULL,
//                                                                                                         (CFStringRef)tempURL,
//                                                                                                         NULL,
//                                                                                                         (CFStringRef)@"<>",
//                                                                                                         kCFStringEncodingUTF8));
//            NSURL *url = [NSURL URLWithString:urlEncoded];
//            NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
//            NSString *oauth_token = [temp objectForKey:@"oauth_token"];
//            if(oauth_token==NULL || [oauth_token isEqual:@""])
//            {
//                
//                NSURLRequest *request = [NSURLRequest requestWithURL:url];
//                [NSURLConnection sendAsynchronousRequest:request
//                                                   queue:[NSOperationQueue mainQueue]
//                                       completionHandler:^(NSURLResponse *response,
//                                                           NSData *data, NSError *connectionError)
//                 {
//                     if (data.length > 0 && connectionError == nil)
//                     {
//                         sortStr = @"Search";
//                         allDataDict = productDetailsDict;
//                         NSMutableArray *tempDict;
//                         tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//                         //NSLog(@"tempDict %@", tempDict);
//                         
//                         //                         appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
//                         //                         bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
//                         
//                         if ([bangeLbl.text integerValue] > 0)
//                         {
//                             bangeLbl.hidden = NO;
//                         }
//                         else
//                         {
//                             bangeLbl.hidden = YES;
//                         }
//                         
//                         
//                         if ([[tempDict valueForKey:@"status"] integerValue] == 1)
//                         {
//                             
//                             NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[productDetailsDict arrayByAddingObjectsFromArray:[tempDict valueForKey:@"data"]]];
//                             productDetailsDict = tempArr;
//                             
//                             
//                             NSMutableArray *tempDicArr = [tempDict valueForKey:@"data"];
//                             
//                             for (NSDictionary *cartDict in tempDicArr)
//                             {
//                                 NSArray *arr = [[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"];
//                                 for (int i = 0; i < [arr count] ; i++ )
//                                 {
//                                     [cartCountDictLocal setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"in_cart"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
//                                     [cartCountModifyDict setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"cart_itemid"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
//                                 }
//                             }
//                             
//                             
//                             [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
//                             [[NSUserDefaults standardUserDefaults] synchronize];
//                             
//                             [itemDetailsTblVew reloadData];
//                         }
//                         else
//                         {
//                             pageNumber--;
//                             [self.view addSubview:[[ToastAlert alloc] initWithText:@"No More Products"]];
//                             
//                         }
//                         
//                         [itemDetailsTblVew endUpdates];
//                         [itemDetailsTblVew.infiniteScrollingView stopAnimating];
//                         
//                     }
//                     else
//                     {
//                         [SVProgressHUD dismiss];
//                         //[self.view addSubview:[[ToastAlert alloc] initWithText:@"No Network Found"]];
//                     }
//                 }];
//                
//            }
//            else
//            {
//                
//                NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlEncoded , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
//                NSDictionary *tempDict = [Webmethods search:cartIdStr];
//                
//                //NSLog(@"globalcartid %@", cartIdStr);
//                
//                if ([[tempDict valueForKey:@"status"] integerValue] == 1)
//                {
//                    [SVProgressHUD dismiss];
//                    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[productDetailsDict arrayByAddingObjectsFromArray:[tempDict valueForKey:@"data"]]];
//                    productDetailsDict = tempArr;
//                    
//                    //                    appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
//                    //                    bangeLbl.text = appDelegate.bangeStr;
//                    
//                    if ([bangeLbl.text integerValue] > 0)
//                    {
//                        bangeLbl.hidden = NO;
//                    }
//                    else
//                    {
//                        bangeLbl.hidden = YES;
//                    }
//                    
//                    
//                    NSMutableArray *tempDicArr = [tempDict valueForKey:@"data"];
//                    
//                    for (NSDictionary *cartDict in tempDicArr)
//                    {
//                        NSArray *arr = [[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"];
//                        for (int i = 0; i < [arr count] ; i++ )
//                        {
//                            [cartCountDictLocal setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"in_cart"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
//                            [cartCountModifyDict setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"cart_itemid"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
//                        }
//                    }
//                    
//                    
//                    [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                    
//                    [itemDetailsTblVew reloadData];
//                }
//                else if ([[tempDict valueForKey:@"status"] integerValue] == 0)
//                {
//                    [SVProgressHUD dismiss];
//                }
//                else
//                {
//                    pageNumber--;
//                    [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
//                    
//                }
//                
//                [itemDetailsTblVew endUpdates];
//                [itemDetailsTblVew.infiniteScrollingView stopAnimating];
//                
//                
//            }
//        }
    }
    
    //    });
    
    
    }
}




-(void) setupView
{
    bangeLbl.layer.cornerRadius = 9;
    bangeLbl.layer.masksToBounds = YES;
    
    
    self.footerImg.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:132.0/255.0 blue:36.0/255.0 alpha:1];
    logoSmallImg.hidden = YES;
    //searchBar.hidden = YES;
    logoLargeImg.hidden = NO;
    _searchBg.hidden = YES;
}

-(IBAction)filterBtnAct:(id)sender
{
    searchSortFilterVC = [[SearchSortFilterVC alloc] initWithNibName:@"SearchSortFilterVC" bundle:nil];
    //sortFilterVC.productHeader=productHeader;
    [self.navigationController pushViewController:searchSortFilterVC animated:NO];
    
//    sortFilterVC = [[SortFilterVC alloc] initWithNibName:@"SortFilterVC" bundle:nil];
//    sortFilterVC.productHeader=productHeader;
//    [self.navigationController pushViewController:sortFilterVC animated:NO];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [filterBtnObj removeFromSuperview];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[NSUserDefaults standardUserDefaults] setObject:counterDict forKey:@"counterDict"];
    pageNumber = 1;
    
    if (counterDict == nil)
    {
        counterDict = [[NSMutableDictionary alloc] init];
    }
    else
    {
        counterDict = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] valueForKey:@"counterDict"]];
    }
    
//    [itemDetailsTblVew setContentOffset:CGPointZero animated:YES];
    
    //[itemDetailsTblVew setContentOffset:CGPointMake(0.0f, -itemDetailsTblVew.contentInset.top) animated:YES];
    
    bangeLbl.hidden = YES;
    
    [searchBar1 resignFirstResponder];
    
    self.navigationController.navigationBar.hidden = NO;
    [self navigationView];
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
    
    
//    sortString = @"popular";
//    descString = @"desc";
    
//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"sortingBy"] isEqualToString:@"Price Low to High"])
//    {
//        sortString = @"price";
//        descString = @"asc";
//    }
//    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"sortingBy"] isEqualToString:@"Price High to Low"])
//    {
//        sortString = @"price";
//        descString = @"desc";
//    }
//    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"sortingBy"] isEqualToString:@"Popularity"])
//    {
//        sortString = @"popular";
//        descString = @"desc";
//    }
//    else
//    {
//        sortString = @"popular";
//        descString = @"desc";
//    }
//    
//    
//    brandId = [[NSUserDefaults standardUserDefaults] valueForKey:@"brandId"];
//    quantityId = [[NSUserDefaults standardUserDefaults] valueForKey:@"quantityId"];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:11];
    }
    else
    {
        bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:15];
    }
    
    bangeLbl.text = appDelegate.bangeStr;
    
    if ([bangeLbl.text integerValue] < 1)
    {
        bangeLbl.hidden = YES;
    }
    else
    {
        bangeLbl.hidden = NO;
    }

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma UItableViewDelegate


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 20)];
    
    
    
    //    menuHeader
    
    
    UILabel *llabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width-100, 18)];
    llabel.textAlignment = NSTextAlignmentLeft;
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        llabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    }
    else
    {
        llabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    }
    
    
    llabel.textColor = [UIColor whiteColor];
    //    NSString *string = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_name_token"];
    [llabel setText:productHeader];
    [view addSubview:llabel];
    
    
    
    UILabel *rlabel = [[UILabel alloc] initWithFrame:CGRectMake(-10, 0, tableView.frame.size.width, 18)];
    rlabel.textAlignment = NSTextAlignmentRight;
    rlabel.textColor = [UIColor whiteColor];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        rlabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    }
    else
    {
        rlabel.font = [UIFont fontWithName:@"Helvetica" size:17];
    }
    
    NSString *rstring = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_name_token"];
    [rlabel setText:rstring];
    [view addSubview:rlabel];
    
    [view setBackgroundColor:[UIColor colorWithRed:86.0/255.0 green:134.0/255.0 blue:0.0/255.0 alpha:1]]; //your background color...
    return view;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@">>>>>%@",productDetailsDict);
    return [productDetailsDict count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell10";
    SearchCell *cell;
    if (cell == nil)
    {
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            [[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:self options:nil];
//        }
//        else
//        {
//            [[NSBundle mainBundle] loadNibNamed:@"SearchCell~iPad" owner:self options:nil];
//        }
        cell = _itemDetailsCell;
    }
    
    
    UIImageView *seperatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(screenX, 129, width, 1)];
    seperatorImg.backgroundColor = kColor_Orange;
    [cell addSubview:seperatorImg];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.productDetailsBtnObj.tag = indexPath.row;
    
    NSString *trimmedString = [[[productDetailsDict  objectAtIndex:indexPath.row] valueForKey:@"name_varchar"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    cell.name.text = trimmedString;
    
//    [cell.img sd_setImageWithURL:[NSURL URLWithString:[[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"thumb_varchar"]]];
    
    [cell.img sd_setImageWithURL:[NSURL URLWithString:[[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"thumb_varchar"]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    
    cell.plusObj.tag = indexPath.row;
    cell.minusObj.tag = indexPath.row;
    cell.addCartBtnObj.tag = indexPath.row;
    cell.count.tag = indexPath.row;

    
    if ([[[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"promotion_tags_value"] isKindOfClass:[NSNull class]])
    {
        cell.promotionLbl.text = @"";
    }
    else
    {
        cell.promotionLbl.text = [[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"promotion_tags_value"];
    }
    
    
    NSArray *keyArr = [[productDetailsDict  objectAtIndex:indexPath.row] allKeys];
    
    if ([keyArr containsObject:@"INR_0_price_decimal"])
    
        if ([[[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"INR_0_special_price_decimal"] integerValue] < 1)
        {
            cell.mrp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"INR_0_price_decimal"] floatValue]];
            cell.sp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"INR_0_price_decimal"] floatValue]];
            cell.mrpCutLbl.hidden = YES;
            cell.mrp.text = @"";
            
        }
        else
        {
            cell.mrp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"INR_0_price_decimal"] floatValue]];
            cell.sp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"INR_0_special_price_decimal"] floatValue]];
            cell.mrpCutLbl.hidden = NO;
        }
    
    else if ([keyArr containsObject:@"INR_1_price_decimal"])
    {
        if ([[[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"INR_1_special_price_decimal"] integerValue] < 1)
        {
            cell.mrp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"INR_1_price_decimal"] floatValue]];
            cell.sp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"INR_1_price_decimal"] floatValue]];
            cell.mrpCutLbl.hidden = YES;
            cell.mrp.text = @"";
            
        }
        else
        {
            cell.mrp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"INR_1_price_decimal"] floatValue]];
            cell.sp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[productDetailsDict objectAtIndex:indexPath.row] valueForKey:@"INR_1_special_price_decimal"] floatValue]];
            cell.mrpCutLbl.hidden = NO;
        }
    }
    
    
    
    NSString *itemsCount = [counterDict valueForKey:[NSString stringWithFormat:@"%li", (long)indexPath.row]];
    
    
    if ([itemsCount integerValue] < 1)
    {
        cell.count.text = [NSString stringWithFormat:@"%@", @""];
        cell.addCartBtnObj.hidden = YES;
    }
    else
    {
        cell.count.text = [NSString stringWithFormat:@"%@", itemsCount];
        cell.addCartBtnObj.hidden = NO;
    }

//    cell.count.text = [counterDict valueForKey:[NSString stringWithFormat:@"%li", (long)indexPath.row]];

    
    return cell;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 130;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView reloadData];
    
}


//-(void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
//
//
//    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
//        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
//        UIView* content = castView.contentView;
//        UIColor* color = [UIColor colorWithRed:86.0/255.0 green:134.0/255.0 blue:0.0/255.0 alpha:1]; // substitute your color here
//        content.backgroundColor = color;
//
//        [castView.textLabel setTextColor:[UIColor whiteColor]];
//        castView.textLabel.font = [UIFont fontWithName:@"Helvetica" size:17];
//        }
//}


- (IBAction)weightPlusBtnAct:(UIButton *)sender
{
    SearchCell *selectedCell = (SearchCell *)[itemDetailsTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    count1 = [selectedCell.count.text integerValue];
    
    //    if (count < 5)
    //    {
    count1 ++;
    cartItemCount++;
    selectedCell.count.text = [NSString stringWithFormat:@"%i", count1];
    if ([selectedCell.count.text integerValue] > 0)
    {
        selectedCell.addCartBtnObj.hidden = NO;
    }
    
    [self addCartBtnAct:sender];
    //    }
    //    else{
    //
    //        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Maximum five quantity per item"]];
    ////        selectedCell.plusBtnObj.hidden=YES;
    ////        selectedCell.plus_img.hidden=YES;
    //
    //    }
    
    
}

- (IBAction)weightMinusBtnAct:(UIButton *)sender
{
    
    
    SearchCell *selectedCell = (SearchCell *)[itemDetailsTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    
    //    NSString *itemId = [[[[[productDetailsDict objectAtIndex:sender.tag] valueForKey:@"super_attribute"] valueForKey:@"values"]  objectAtIndex:rowSelected] valueForKey:@"cart_itemid"];
    
    
    NSString *itemId = [NSString stringWithFormat:@"%@", [cartCountModifyDict valueForKey:[[productDetailsDict objectAtIndex:sender.tag] valueForKey:@"products_id"]]];
    
    int count = (int)[selectedCell.count.text integerValue];
    
    if (count > 0)
    {
        count --;
        selectedCell.count.text = [NSString stringWithFormat:@"%i",count];
    }
    else
    {
        selectedCell.count.text = [NSString stringWithFormat:@"%@",@""];
    }
    
    
    NSDictionary *cartDictLocal = [productDetailsDict objectAtIndex:sender.tag];
    
    if ([selectedCell.count.text integerValue] < 1)
    {
        selectedCell.addCartBtnObj.hidden = YES;
        if ([[cartCountDictLocal valueForKey:[NSString stringWithFormat:@"%@",[[[[[productDetailsDict objectAtIndex:sender.tag] valueForKey:@"super_attribute"] valueForKey:@"values"]  objectAtIndex:rowSelected] valueForKey:@"id"]]] integerValue] > 0)
        {
            itemId = [cartCountModifyDict valueForKey:[NSString stringWithFormat:@"%@",[[[[[productDetailsDict objectAtIndex:sender.tag] valueForKey:@"super_attribute"] valueForKey:@"values"]  objectAtIndex:rowSelected] valueForKey:@"id"]]];
        }
    }
    
    if ([itemId intValue] < 1)
    {
        return ;
    }
    
    if (count == 0)
    {
        
        
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
        NSString *URL=[NSString stringWithFormat:@"%@/cart/delete/?itemid=%@&store=%@&cartid=%@", baseUrl1, itemId, storeIdStr, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        
        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        NSString * oauth_token =[temp objectForKey:@"oauth_token"];
        
        //        if(oauth_token==NULL || [oauth_token isEqual:@""])
        //        {
        NSURL *url = [NSURL URLWithString:URL];
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
                 
                 appDelegate.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
                 bangeLbl.text = appDelegate.bangeStr;
                 [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                 //                     [self getcartdata];
                 
                 [cartCountDictLocal setObject:selectedCell.count.text forKey:[cartDictLocal  valueForKey:@"products_id"]];
                 
                 [cartCountModifyDict setObject:@"0" forKey:[cartDictLocal  valueForKey:@"products_id"]];
                 
                 [counterDict setObject:selectedCell.count.text forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
                 
                 //                     [cartCountDictLocal setObject:selectedCell.numberOfItems.text forKey:[[[[cartDictLocal valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:rowSelected] valueForKey:@"id"]];
                 //
                 //                     [cartCountModifyDict setObject:[NSString stringWithFormat:@"%@", [tempDict objectForKey:@"item_id"]] forKey:[[[[cartDictLocal valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:rowSelected] valueForKey:@"id"]];
                 
                 
                 //                     [self refreshCategory];
                 if ([bangeLbl.text integerValue] > 0)
                 {
                     bangeLbl.hidden = NO;
                 }
                 else
                 {
                     bangeLbl.hidden = YES;
                 }
                 [itemDetailsTblVew reloadData];
                 [SVProgressHUD dismiss];
             }
         }];
        //        }
        //        else
        //        {
        //
        //            NSDictionary *tempDict = [Webmethods DeleteItemFromCart:URL];
        //            //NSLog(@"tempDict %@", tempDict);
        //            appDelegate.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
        //            bangeLbl.text = appDelegate.bangeStr;
        //
        //            [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
        //
        //            [cartCountDictLocal setObject:selectedCell.numberOfItems.text forKey:[cartDictLocal  valueForKey:@"products_id"]];
        //
        //            [cartCountModifyDict setObject:@"0" forKey:[cartDictLocal  valueForKey:@"products_id"]];
        //
        //            [counterDict setObject:selectedCell.numberOfItems.text forKey:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
        //
        ////            [cartCountDictLocal setObject:selectedCell.numberOfItems.text forKey:[[[[cartDictLocal valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:rowSelected] valueForKey:@"id"]];
        ////            [cartCountModifyDict setObject:[NSString stringWithFormat:@"%@", [tempDict objectForKey:@"item_id"]] forKey:[[[[cartDictLocal valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:rowSelected] valueForKey:@"id"]];
        //
        //            //            [self getcartdata];
        //            //            [self refreshCategory];
        //            if ([bangeLbl.text integerValue] > 0)
        //            {
        //                bangeLbl.hidden = NO;
        //            }
        //            else
        //            {
        //                bangeLbl.hidden = YES;
        //            }
        //            [itemDetailsTblVew reloadData];
        //            [HUD hide:YES];
        //        }
    }
    else
    {
        [self addCartBtnAct:sender];
    }
}
-(void)threadStartAnimating2:(id)dat
{
    [SVProgressHUD show];
}
- (IBAction)addCartBtnAct:(UIButton *)sender
{
    //    pageNumber = 1;
    
    [SVProgressHUD show];
    if ([sender.titleLabel.text isEqualToString:@"OUT OF Stock"])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"OUT OF Stock"]];
        return ;
    }
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    
    SearchCell *selectedCell = (SearchCell *)[itemDetailsTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    
    
    if (rowSeletcedIs == sender.tag)
    {
        
    }
    else
    {
        rowSelected = (int)[[kgIndexDict valueForKey:[NSString stringWithFormat:@"%ld", sender.tag]] integerValue];
    }
    
    selectedCell.addCartBtnObj.userInteractionEnabled = NO;
    
    // [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
    
    NSString *pidStr = [[productDetailsDict objectAtIndex:sender.tag] valueForKey:@"products_id"];
    NSString *qtyStr = selectedCell.count.text;
    NSString *optionStr =  [[[[[productDetailsDict objectAtIndex:sender.tag] valueForKey:@"super_attribute"] valueForKey:@"values"]  objectAtIndex:[[kgIndexDict valueForKey:[NSString stringWithFormat:@"%li",(long)sender.tag]] integerValue]] valueForKey:@"value_index"];
    NSString *attribute = [[[productDetailsDict objectAtIndex:sender.tag] valueForKey:@"super_attribute"] valueForKey:@"attribute_id"];
    
    NSString *cpidStr = [[productDetailsDict objectAtIndex:sender.tag] valueForKey:@"entity_id"];
    
    NSDictionary *cartDictLocal = [productDetailsDict objectAtIndex:sender.tag];
    
    NSString *inCartStr = [NSString stringWithFormat:@"%@", [cartCountModifyDict valueForKey:[cartDictLocal valueForKey:@"products_id"]]];
    
    
    
    NSString *itemId = [[[[[productDetailsDict objectAtIndex:sender.tag] valueForKey:@"super_attribute"] valueForKey:@"values"]  objectAtIndex:rowSelected] valueForKey:@"cart_itemid"];
    
    
    
    
    for (int i = 0; i < sortArray.count; i++)
    {
        if ([[sortArray objectAtIndex:sender.tag] isEqualToString:[[productDetailsDict objectAtIndex:i] valueForKey:@"final_price"]])
        {
            pidStr = [[[[[[productDetailsDict objectAtIndex:i] valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:0] objectAtIndex:[[kgIndexDict valueForKey:[NSString stringWithFormat:@"%li",(long)i]] integerValue]] valueForKey:@"id"];
            qtyStr = selectedCell.count.text;
            optionStr =  [[[[[[productDetailsDict objectAtIndex:i] valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:0] objectAtIndex:[[kgIndexDict valueForKey:[NSString stringWithFormat:@"%i",i]] integerValue]] valueForKey:@"value_index"];
            attribute = [[[productDetailsDict objectAtIndex:i] valueForKey:@"super_attribute"] valueForKey:@"attribute_id"];
            
            break;
        }
    }
    
    //    rowSelected = 0;
    NSError *error;
    
    if ([selectedCell.count.text isEqualToString:@"0"])
    {
        //        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please add item in cart"]];
        qtyStr = @"1";
        //        return;
    }
    else
    {
        qtyStr = [NSString stringWithFormat:@"%li", (long)[selectedCell.count.text integerValue]];
        //  - [[[[[[productDetailsDict objectAtIndex:sender.tag] valueForKey:@"super_attribute"] valueForKey:@"values"] valueForKey:@"in_cart"] objectAtIndex:rowSelected] integerValue]];
    }
    
    
    if ( [inCartStr integerValue] < 1 )
    {
        
        
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        NSString *urlStr = [NSString stringWithFormat:@"%@/cart/add/?pid=%@&qty=%@&store=%@", baseUrl1, pidStr, qtyStr, storeIdStr];
        
        
        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        NSString * oauth_token =[temp objectForKey:@"oauth_token"];
        
        
        
        //            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        
        NSString *cartIdStr;
        
        cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        //            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        
        NSURL *url = [NSURL URLWithString:cartIdStr];
        
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 selectedCell.userInteractionEnabled = YES;
                 [SVProgressHUD dismiss];
                 NSDictionary *currentArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                 if ([[currentArray valueForKey:@"status"] integerValue] == 1)
                 {
                     
                     
                     selectedCell.count.text = [NSString stringWithFormat:@"%i", count1];
                     
                     if ([[currentArray valueForKey:@"cartid"] integerValue] > 0)
                     {
                         [[NSUserDefaults standardUserDefaults] setObject:[currentArray valueForKey:@"cartid"] forKey:@"globalcartid"];
                     }
                     
                     
                     /***
                      Add To Cart Event Start
                      ***/
                     NSMutableDictionary *addtocartDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                           [currentArray valueForKey:@"cartid"], kCartIdProperty,
                                                           nil];
                     [SH_TrackingUtility trackEventOfSpencerEvents:addToCartEvent eventProp:addtocartDict];
                     /***
                      Add To Cart Event End
                      ***/
                     
                     
                     [cartCountDictLocal setObject:selectedCell.count.text forKey:[cartDictLocal valueForKey:@"products_id"]];
                     
                     [cartCountModifyDict setObject:[NSString stringWithFormat:@"%@", [currentArray objectForKey:@"item_id"]] forKey:[cartDictLocal valueForKey:@"products_id"]];
                     
                     [counterDict setObject:selectedCell.count.text forKey:[NSString stringWithFormat:@"%i", sender.tag]];
                     appDelegate.bangeStr = [NSString stringWithFormat:@"%@",[currentArray valueForKey:@"cart_count"]];
                     bangeLbl.text = [NSString stringWithFormat:@"%@",[currentArray valueForKey:@"cart_count"]];
                     
                     //                         NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:rowSeletcedIs inSection:0];
                     //                         NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
                     //                         [itemDetailsTblVew reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
                     
                     
                     
                     if ([bangeLbl.text integerValue] > 0)
                     {
                         bangeLbl.hidden = NO;
                     }
                     else
                     {
                         bangeLbl.hidden = YES;
                     }
                     [self.view addSubview:[[ToastAlert alloc] initWithText:[currentArray valueForKey:@"message"]]];
                     
                 }
                 else{
                     [self.view addSubview:[[ToastAlert alloc] initWithText:[currentArray valueForKey:@"message"]]];
                 }
                 
                 [itemDetailsTblVew reloadData];
                 
             }
             else{
                 [SVProgressHUD dismiss];
             }
         }];
        
        
    }
    else
    {
        
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
        NSString *URL=[NSString stringWithFormat:@"%@/cart/update/?cart[%@]=%@&store=%@", baseUrl1,inCartStr, selectedCell.count.text, storeIdStr];
        
        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        NSString * oauth_token =[temp objectForKey:@"oauth_token"];
        
        
        
        //            @"cartid=%@"[[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]
        NSString *urlStr = [NSString stringWithFormat:@"%@&cartid=%@", URL, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        NSURL *url = [NSURL URLWithString:urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 
                 
                 [SVProgressHUD dismiss];
                 
                 
                 NSMutableDictionary *tempDict;
                 
                 
                 tempDict = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                 
                 
                 //                     appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                 //                     bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                 //
                 //                     if ([bangeLbl.text integerValue] > 0)
                 //                     {
                 //                         bangeLbl.hidden = NO;
                 //                     }
                 //                     else
                 //                     {
                 //                         bangeLbl.hidden = YES;
                 //                     }
                 
                 
                 
                 if ([[tempDict valueForKey:@"cartid"] integerValue] > 0)
                 {
                     [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"cartid"] forKey:@"globalcartid"];
                 }
                 
                 
                 
                 
                 
                 if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                 {
                     
                     
                     [counterDict setObject:selectedCell.count.text forKey:[NSString stringWithFormat:@"%i", sender.tag]];
                     
                     selectedCell.count.text = [NSString stringWithFormat:@"%i", count1];
                     
                     appDelegate.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
                     bangeLbl.text = appDelegate.bangeStr;
                     
                     
                     
                     [cartCountDictLocal setObject:selectedCell.count.text forKey:[cartDictLocal valueForKey:@"products_id"]];
                     
                     [cartCountModifyDict setObject:[NSString stringWithFormat:@"%@", [tempDict objectForKey:@"item_id"]] forKey:[cartDictLocal valueForKey:@"products_id"]];
                     
                     
                     if ([bangeLbl.text integerValue] > 0)
                     {
                         bangeLbl.hidden = NO;
                     }
                     else
                     {
                         bangeLbl.hidden = YES;
                     }
                     [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                     
                     [itemDetailsTblVew reloadData];
                 }
                 else
                 {
                     [itemDetailsTblVew reloadData];
                     [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                 }
                 
             }
             
             selectedCell.addCartBtnObj.userInteractionEnabled = YES;
         }];
        
        
    }
    
}


- (IBAction)sortBtnAct:(UIButton *)sender {
    //[searchBar resignFirstResponder];
    sortFlag = YES;
    sortView.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width,self.view.frame.size.height);
    [self.view addSubview:sortView];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    [sortView addGestureRecognizer:singleTap];
    
    //    NSArray *arr = [[NSArray alloc] initWithObjects:@"Low to High", @"High to Low", @"Popularity", nil];
    //    NSArray *numberArray = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", nil];
    //    if(dropDown == nil)
    //    {
    //        CGFloat f = 90;
    //        dropDown = [[NIDropDown alloc]showDropDown2:sender :&f :arr :numberArray :@"down"];
    //        dropDown.delegate = self;
    //        [self.view endEditing:YES];
    //    }
    //    else
    //    {
    //        [dropDown hideDropDown:sender];
    //        [self rel];
    //        [self.view endEditing:YES];
    //    }
    //    dropDown.tag = 2;
    //
    //    [self.view addSubview:sortView];
    
    
}






-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    searchStr = textField.text;
    [textField resignFirstResponder];
    [self searchBtnAct];
    
    return YES;
}

-(void)searchBtnAct
{
    rowSelected = 0;
    if (searchBar.hidden == YES)
    {
        searchBar.text = @"";
        [searchBar becomeFirstResponder];
        searchBar.hidden = NO;
        logoSmallImg.hidden = NO;
        logoLargeImg.hidden = YES;
        logoLargeBtn.hidden = YES;
        _searchBg.hidden = NO;
    }
    else
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
        searchBar.hidden = YES;
        logoSmallImg.hidden = YES;
        logoLargeImg.hidden = NO;
        logoLargeBtn.hidden = NO;
        _searchBg.hidden = YES;
        [searchBar resignFirstResponder];
        if (![searchBar.text isEqualToString:@""])
        {
            
            
            
            if (searchStr.length > 0 && [sortStr isEqualToString:@"Search"])
            {
                self.moreBtnObj.hidden = YES;
                
                storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
                
                [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
                
                //                http://spencers.in/api/rest/solrbridge/search?storeid=%@&q=%@
                
                NSString * tempURL=[NSString stringWithFormat:@"%@/solrbridge/search?q=%@&storeid=%@",baseUrl1, searchBar.text, storeIdStr];
              
                
                NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                             NULL,
                                                                                                             (CFStringRef)tempURL,
                                                                                                             NULL,
                                                                                                             (CFStringRef)@"<>",
                                                                                                             kCFStringEncodingUTF8));
                
                NSURL *url = [NSURL URLWithString:urlEncoded];
                
                NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
                NSString *oauth_token = [temp objectForKey:@"oauth_token"];
                
                
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse *response,
                                                           NSData *data, NSError *connectionError)
                 {
                     if (data.length > 0 && connectionError == nil)
                     {
                         sortStr = @"Search";
                         allDataDict = productDetailsDict;
                         [SVProgressHUD dismiss];
                         NSMutableArray *tempDict;
                         tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                         //NSLog(@"tempDict %@", tempDict);
                         productDetailsDict = [[tempDict valueForKey:@"response"] valueForKey:@"docs"];
                         if (productDetailsDict.count < 1)
                         {
                             [self.view addSubview:[[ToastAlert alloc] initWithText:@"No product found"]];
                         }
                         
                         if ([bangeLbl.text integerValue] > 0)
                         {
                             bangeLbl.hidden = NO;
                         }
                         else
                         {
                             bangeLbl.hidden = YES;
                         }
                         
                         
                         if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                         {
                             appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                             bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                             
                             for (NSDictionary *cartDict in productDetailsDict)
                             {
                                 NSArray *arr = [[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"];
                                 for (int i = 0; i < [arr count] ; i++ )
                                 {
                                     [cartCountDictLocal setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"in_cart"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                                     [cartCountModifyDict setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"cart_itemid"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                                 }
                             }
                             
                             [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                             [[NSUserDefaults standardUserDefaults] synchronize];
                         }
                         else
                         {
                             //                                 productDetailsDict = nil;
                             //                                 [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                         }
                         [itemDetailsTblVew reloadData];
                     }
                     else
                     {
                         [SVProgressHUD dismiss];
                     }
                 }];
                
                
            }
            
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
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        //        appDelegate.categoryId
        NSString *urlStr = [NSString stringWithFormat:@"%@/category/products/%@?page=%i&store=%@", baseUrl1, @"295", pageNumber, storeIdStr];
        
        ProductVC *itemDetailsVC;
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            itemDetailsVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//        }
//        else
//        {
//            itemDetailsVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//        }
        //        itemDetailsVC.productHeader = [[[[currentArray valueForKey:@"data"] valueForKey:@"categories"] objectAtIndex:imageView.tag] valueForKey:@"name"];
        itemDetailsVC.categoryUrl = urlStr;
        [self.navigationController pushViewController:itemDetailsVC animated:NO];
        
        
        //        NSString *  storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        //        urlStr = [NSString stringWithFormat:@"http://apis.spencers.in/api/rest/category/products/%@?page=%i&store=%@", [[[[currentArray valueForKey:@"data"] valueForKey:@"categories"] objectAtIndex:imageView.tag] valueForKey:@"category_id"], pageNumber, storeIdStr];
        
        [self viewWillAppear:YES];
        
        //        BOOL reach = [Webmethods checkNetwork];
        //        if (reach == NO) {
        //            return ;
        //        }
        //
        //        productHeader = appDelegate.GlobalOfferName;
        //        categoryUrl = appDelegate.GlobalofferURL;
        //        //            itemDetailsVC.offerCheckBool = YES;
        //        //        [itemDetailsTblVew reloadData];
        //
        //        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        //        NSString *oauth_token = [temp objectForKey:@"oauth_token"];
        //
        //        if(oauth_token==NULL || [oauth_token isEqual:@""])
        //        {
        //            [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
        //            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:categoryUrl]];
        //            [NSURLConnection sendAsynchronousRequest:request
        //                                               queue:[NSOperationQueue mainQueue]
        //                                   completionHandler:^(NSURLResponse *response,
        //                                                       NSData *data, NSError *connectionError)
        //             {
        //                 if (data.length > 0 && connectionError == nil)
        //                 {
        //
        //                     NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        //
        //                     appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
        //                     bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
        //
        //                     if ([bangeLbl.text integerValue] > 0)
        //                     {
        //                         bangeLbl.hidden = NO;
        //                     }
        //                     else
        //                     {
        //                         bangeLbl.hidden = YES;
        //                     }
        //
        //
        //                     [HUD hide:YES];
        //                     if ([[tempDict valueForKey:@"status"] integerValue] == 1)
        //                     {
        //                         productDetailsDict = [tempDict valueForKey:@"data"];
        //
        //                         [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
        //                         [[NSUserDefaults standardUserDefaults] synchronize];
        //
        //                         [itemDetailsTblVew reloadData];
        //                     }
        //                     else
        //                     {
        //                         [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
        //                     }
        //                 }
        //                 else
        //                 {
        //                     [self.view addSubview:[[ToastAlert alloc] initWithText:@"No Network Found"]];
        //                     [HUD hide:YES];
        //                 }
        //             }];
        //        }
        //        else
        //        {
        //
        //
        //
        //            [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
        //            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        //            NSDictionary *tempDict = [Webmethods product:cartIdStr];
        //
        //
        //            //  NSLog(@"globalcartid %@", cartIdStr);
        //
        //            [HUD hide:YES];
        //            //NSLog(@"tempDict %@", tempDict);
        //
        //            if ([[tempDict valueForKey:@"status"] integerValue] == 1)
        //            {
        //                productDetailsDict = [tempDict valueForKey:@"data"];
        //
        //                appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
        //                bangeLbl.text = appDelegate.bangeStr;
        //
        //
        //                if ([bangeLbl.text integerValue] > 0)
        //                {
        //                    bangeLbl.hidden = NO;
        //                }
        //                else
        //                {
        //                    bangeLbl.hidden = YES;
        //                }
        //
        //                [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
        //                [[NSUserDefaults standardUserDefaults] synchronize];
        //
        //                [HUD hide:YES];
        //                [itemDetailsTblVew reloadData];
        //            }
        //            else
        //            {
        //                [self.view addSubview:[[ToastAlert alloc] initWithText:@"No Network Found"]];
        //                [HUD hide:YES];
        //            }
        //
        //        }
        
        
        
        
        
    }
    else if (sender == searchBtnObj)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        
        searchStr = searchBar.text;
        sortStr = @"Search";
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
            
            LoginVC * loginpage;
//            if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//            {
                loginpage = [[LoginVC alloc]initWithNibName:@"LoginView" bundle:nil];
//            }
//            else
//            {
//                loginpage = [[LoginVC alloc]initWithNibName:@"LoginView~iPad" bundle:nil];
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



- (IBAction)checkBtn:(UIButton *)sender {
    pageNumber = 1;
    rowSelected=0;
    //    if (sender.tag == 3)
    //    {
    //        return ;
    //    }
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        [sortView removeFromSuperview];
        return ;
    }
    else
    {
        [sortView removeFromSuperview];
    }
    
    if ([sender.titleLabel.text isEqualToString:@"Price - Low to High"])
    {
        sortString = @"price";
        descString = @"asc";
    }
    else if ([sender.titleLabel.text isEqualToString:@"Price - High to Low"])
    {
        sortString = @"price";
        descString = @"desc";
    }
    else if ([sender.titleLabel.text isEqualToString:@"Popularity"])
    {
        sortString = @"popular";
        descString = @"desc";
    }
    
    if (searchStr.length > 0 && [sortStr isEqualToString:@"Search"])
    {
        self.moreBtnObj.hidden = YES;
        
        [cartCountDictLocal removeAllObjects];
        [cartCountModifyDict removeAllObjects];
        
        
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
        
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        NSString * tempURL=[NSString stringWithFormat:@"%@/solrbridge/search?q=%@&storeid=%@",baseUrl1, searchBar.text,storeIdStr];
        
        
        
        NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                     NULL,
                                                                                                     (CFStringRef)tempURL,
                                                                                                     NULL,
                                                                                                     (CFStringRef)@"<>",
                                                                                                     kCFStringEncodingUTF8));
        
        NSURL *url = [NSURL URLWithString:urlEncoded];
        
        
        NSUserDefaults *temp;
        temp=[NSUserDefaults standardUserDefaults];
        NSString *oauth_token = [temp objectForKey:@"oauth_token"];
        
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 if (data.length > 0 && connectionError == nil)
                 {
                     sortStr = @"Search";
                     allDataDict = productDetailsDict;
                     NSMutableArray *tempDict;
                     tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                     //NSLog(@"tempDict %@", tempDict);
                     
                     appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                     bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                     
                     if ([bangeLbl.text integerValue] > 0)
                     {
                         bangeLbl.hidden = NO;
                     }
                     else
                     {
                         bangeLbl.hidden = YES;
                     }
                     
                     
                     
                     if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                     {
                         //                         NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[productDetailsDict arrayByAddingObjectsFromArray:[tempDict valueForKey:@"data"]]];
                         productDetailsDict = [tempDict valueForKey:@"data"];
                         
                         
                         for (NSDictionary *cartDict in productDetailsDict)
                         {
                             [cartCountDictLocal setObject:[cartDict valueForKey:@"in_cart"] forKey:[cartDict  valueForKey:@"entity_id"]];
                             [cartCountModifyDict setObject:[cartDict valueForKey:@"cart_itemid"] forKey:[cartDict  valueForKey:@"entity_id"]];
                             
                             //                             for (int i = 0; i < [[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] count] ; i++ )
                             //                             {
                             //                                 [cartCountDictLocal setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"in_cart"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                             //                                 [cartCountModifyDict setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"cart_itemid"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                             //                             }
                         }
                         
                         
                         [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                         [[NSUserDefaults standardUserDefaults] synchronize];
                         [itemDetailsTblVew setContentOffset:CGPointZero animated:NO];
                         [itemDetailsTblVew reloadData];
                     }
                     else
                     {
                         pageNumber--;
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                     }
                     [SVProgressHUD dismiss];
                     [itemDetailsTblVew endUpdates];
                     [itemDetailsTblVew.infiniteScrollingView stopAnimating];
                     
                 }
                 else
                 {
                     [SVProgressHUD dismiss];
                 }
             }];
            
        }
        else
            
        {
            
            
            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlEncoded , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            NSDictionary *tempDict = [Webmethods search:cartIdStr];
            
            //  NSLog(@"globalcartid %@", cartIdStr);
            
            if ([[tempDict valueForKey:@"status"] integerValue] == 1)
            {
                [SVProgressHUD dismiss];
                productDetailsDict = [tempDict valueForKey:@"data"];
                
                appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                bangeLbl.text = appDelegate.bangeStr;
                
                if ([bangeLbl.text integerValue] > 0)
                {
                    bangeLbl.hidden = NO;
                }
                else
                {
                    bangeLbl.hidden = YES;
                }
                
                for (NSDictionary *cartDict in productDetailsDict)
                {
                    [cartCountDictLocal setObject:[cartDict valueForKey:@"in_cart"] forKey:[cartDict  valueForKey:@"entity_id"]];
                    [cartCountModifyDict setObject:[cartDict valueForKey:@"cart_itemid"] forKey:[cartDict  valueForKey:@"entity_id"]];
                    //                    for (int i = 0; i < [[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] count] ; i++ )
                    //                    {
                    //                        [cartCountDictLocal setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"in_cart"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                    //                        [cartCountModifyDict setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"cart_itemid"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                    //                    }
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            else
            {
                [SVProgressHUD dismiss];
                [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
            }
            [itemDetailsTblVew setContentOffset:CGPointZero animated:NO];
            [itemDetailsTblVew reloadData];
        }
        
        
    }
    else
    {
        [cartCountDictLocal removeAllObjects];
        [cartCountModifyDict removeAllObjects];
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
        NSString * URL=[NSString stringWithFormat:@"%@/category/products/%@/?sort=%@&dir=%@&page=%i&store=%@", baseUrl1,appDelegate.categoryId,sortString,descString, pageNumber, storeIdStr];
        
        NSURL *url = [NSURL URLWithString:URL];
        
        NSUserDefaults *temp;
        temp=[NSUserDefaults standardUserDefaults];
        NSString *oauth_token = [temp objectForKey:@"oauth_token"];
        
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 if (data.length > 0 && connectionError == nil)
                 {
                     [SVProgressHUD dismiss];
                     
                     NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                     
                     appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                     bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                     
                     if ([bangeLbl.text integerValue] > 0)
                     {
                         bangeLbl.hidden = NO;
                     }
                     else
                     {
                         bangeLbl.hidden = YES;
                     }
                     
                     
                     if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                     {
                         productDetailsDict = [tempDict valueForKey:@"data"];
                         
                         
                         for (NSDictionary *cartDict in productDetailsDict)
                         {
                             
                             NSArray *arr = [[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"];
                             for (int i = 0; i < [arr count] ; i++ )
                             {
                                 [cartCountDictLocal setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"in_cart"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                                 [cartCountModifyDict setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"cart_itemid"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                             }
                         }
                         
                         [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                         [[NSUserDefaults standardUserDefaults] synchronize];
                         [itemDetailsTblVew setContentOffset:CGPointZero animated:NO];
                         [itemDetailsTblVew reloadData];
                     }
                     else
                     {
                         [self.view addSubview:[[ToastAlert alloc] initWithText:@"No More Products"]];
                     }
                     
                     
                 }
             }];
        }
        else
        {
            
            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", URL , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            NSDictionary *tempDict = [Webmethods product:cartIdStr];
            
            // NSLog(@"globalcartid %@", cartIdStr);
            
            [SVProgressHUD dismiss];
            
            if ([[tempDict valueForKey:@"status"] integerValue] == 1)
            {
                productDetailsDict = [tempDict valueForKey:@"data"];
                
                appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                bangeLbl.text = appDelegate.bangeStr;
                
                
                if ([bangeLbl.text integerValue] > 0)
                {
                    bangeLbl.hidden = NO;
                }
                else
                {
                    bangeLbl.hidden = YES;
                }
                
                for (NSDictionary *cartDict in productDetailsDict)
                {
                    NSArray *arr = [[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"];
                    for (int i = 0; i < [arr count] ; i++ )
                    {
                        [cartCountDictLocal setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"in_cart"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                        [cartCountModifyDict setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"cart_itemid"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                    }
                    
                    
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [itemDetailsTblVew setContentOffset:CGPointZero animated:NO];
                [itemDetailsTblVew reloadData];
            }
            else
            {
                [self.view addSubview:[[ToastAlert alloc] initWithText:@"No More Products"]];
            }
            
        }
        
    }
    
    
}

-(void)oneTap:(UIGestureRecognizer *)gusture;
{
    pageNumber = 1;
    [sortView removeFromSuperview];
}




-(void)refreshCategory
{
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    //    if(imageView.image.tag==1)
    //        [imageView setImage:[UIImage imageNamed:@"anyImage.png"]];
    
    
    NSUserDefaults *temp;
    temp=[NSUserDefaults standardUserDefaults];
    NSString *oauth_token = [temp objectForKey:@"oauth_token"];
    //[NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:categoryUrl]];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             if (data.length > 0 && connectionError == nil)
             {
                 //                 [HUD hide:YES];
                 
                 
                 NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                 
                 appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                 bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                 
                 if ([bangeLbl.text integerValue] > 0)
                 {
                     bangeLbl.hidden = NO;
                 }
                 else
                 {
                     bangeLbl.hidden = YES;
                 }
                 
                 
                 productDetailsDict = [tempDict valueForKey:@"data"];
                 [itemDetailsTblVew reloadData];
             }
             else
             {
                 //                 [HUD hide:YES];
             }
         }];
    }
    else
    {
        
        
        
        NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        NSDictionary *tempDict = [Webmethods product:cartIdStr];
        
        // NSLog(@"globalcartid %@", cartIdStr);
        
        appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
        bangeLbl.text = appDelegate.bangeStr;
        
        
        if ([bangeLbl.text integerValue] > 0)
        {
            bangeLbl.hidden = NO;
        }
        else
        {
            bangeLbl.hidden = YES;
        }
        
        [SVProgressHUD dismiss];
        //NSLog(@"tempDict %@", tempDict);
        productDetailsDict = [tempDict valueForKey:@"data"];
        [itemDetailsTblVew reloadData];
    }
}



-(void)search
{
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    if (searchStr.length > 0 && [sortStr isEqualToString:@"Search"])
    {
        self.moreBtnObj.hidden = YES;
        //        [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
        
        
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        NSString * tempURL=[NSString stringWithFormat:@"%@/solrbridge/search?q=%@storeid=%@",baseUrl1,searchBar.text, storeIdStr ];
        
        NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                     NULL,
                                                                                                     (CFStringRef)tempURL,
                                                                                                     NULL,
                                                                                                     (CFStringRef)@"<>",
                                                                                                     kCFStringEncodingUTF8));
        
        NSURL *url = [NSURL URLWithString:urlEncoded];
        
        
        NSUserDefaults *temp;
        temp=[NSUserDefaults standardUserDefaults];
        NSString *oauth_token = [temp objectForKey:@"oauth_token"];
        
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
            
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             
            
            
             {
                 if (data.length > 0 && connectionError == nil)
                 {
                     sortStr = @"Search";
                     allDataDict = productDetailsDict;
                     //                 [HUD hide:YES];
                     NSMutableArray *tempDict;
                     tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                     //NSLog(@"tempDict %@", tempDict);
                     
                     appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                     bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                     
                     if ([bangeLbl.text integerValue] > 0)
                     {
                         bangeLbl.hidden = NO;
                     }
                     else
                     {
                         bangeLbl.hidden = YES;
                     }
                     
                     
                     if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                     {
                         productDetailsDict = [tempDict valueForKey:@"data"];
                         
                         
                         for (NSDictionary *cartDict in productDetailsDict)
                         {
                             NSArray *arr = [[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"];
                             for (int i = 0; i < [arr count] ; i++ )
                             {
                                 [cartCountDictLocal setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"in_cart"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                                 [cartCountModifyDict setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"cart_itemid"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                             }
                         }
                         
                         [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                         [[NSUserDefaults standardUserDefaults] synchronize];
                     }
                     else
                     {
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                     }
                     [itemDetailsTblVew reloadData];
                 }
                 else
                 {
                     //                 [HUD hide:YES];
                 }
             }];
            
        }
        else
        {
            
            
            
            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlEncoded , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            NSDictionary *tempDict = [Webmethods search:cartIdStr];
            
            // NSLog(@"globalcartid %@", cartIdStr);
            
            [SVProgressHUD dismiss];
            if ([[tempDict valueForKey:@"status"] integerValue] == 1)
            {
                productDetailsDict = [tempDict valueForKey:@"data"];
                
                appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                bangeLbl.text = appDelegate.bangeStr;
                
                if ([bangeLbl.text integerValue] > 0)
                {
                    bangeLbl.hidden = NO;
                }
                else
                {
                    bangeLbl.hidden = YES;
                }
                
                for (NSDictionary *cartDict in productDetailsDict)
                {
                    NSArray *arr = [[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"];
                    for (int i = 0; i < [arr count] ; i++ )
                    {
                        [cartCountDictLocal setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"in_cart"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                        [cartCountModifyDict setObject:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"cart_itemid"] forKey:[[[[cartDict valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:i] valueForKey:@"id"]];
                    }
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            else
            {
                [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
            }
            [itemDetailsTblVew reloadData];
            
        }
        
    }
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString * searchStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
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
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandId"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"quantityId"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sortingBy"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandIdSearchArr"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"quantityIdSearchArr"];
            
            
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



- (IBAction)productDetailsBtnAct:(UIButton *)sender
{

    NSMutableDictionary *itmeClickDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          [[productDetailsDict objectAtIndex:sender.tag] valueForKey:@"entity_id"], kItemIdProperty,
                                          [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], kCartIdProperty,
                                          [[productDetailsDict  objectAtIndex:sender.tag] valueForKey:@"item_name"], kItemNameProperty,
                                          [[productDetailsDict  objectAtIndex:sender.tag] valueForKey:@"attribute_id"], kAttributeIdProperty,
                                          [[productDetailsDict  objectAtIndex:sender.tag] valueForKey:@"pid"], kPIDProperty,
                                          sender.tag, kValueIndexProperty,
                                          nil];
    [SH_TrackingUtility trackEventOfSpencerEvents:itemClickEvent eventProp:itmeClickDict];
    /***
     itemClickEvent Event End
     ***/
    
    ProductCell *selectedCell = (ProductCell *)[itemDetailsTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    //    count1 = (int)[selectedCell.count.text integerValue];
    
     ProductDetailPage *productDetailPage= [[ProductDetailPage alloc] initWithNibName:@"ProductDetailPage" bundle:nil];
        productDetailPage.pushedFlag = 2;
        productDetailPage.entity_id = [[productDetailsDict objectAtIndex:sender.tag] valueForKey:@"products_id"];
        productDetailPage.counterDict = counterDict;
        productDetailPage.indexNumber = (int)sender.tag;
        [self.navigationController pushViewController:productDetailPage animated:NO];
}

    
    
-(void) callGetproductsAPI
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO)
        {
            return ;
        }
        [SVProgressHUD show];
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"sortingBy"] isEqualToString:@"Price Low to High"])
        {
            sortString = @"price";
            descString = @"asc";
        }
        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"sortingBy"] isEqualToString:@"Price High to Low"])
        {
            sortString = @"price";
            descString = @"desc";
        }
        else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"sortingBy"] isEqualToString:@"Popularity"])
        {
            sortString = @"popular";
            descString = @"desc";
        }
        else
        {
            sortString = @"popular";
            descString = @"desc";
        }
        
        
        brandId = [[NSUserDefaults standardUserDefaults] valueForKey:@"brandId"];
        quantityId = [[NSUserDefaults standardUserDefaults] valueForKey:@"quantityId"];
        
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        if (searchStr.length > 0 && [sortStr isEqualToString:@"Search"])
        {
            NSString * tempURL1=[NSString stringWithFormat:@"%@/api/rest/solrbridge/search?q=%@&storeid=%@&p=%i", solarSearchUrl, searchStr ,storeIdStr , pageNumber];
            NSString *tempURL;
            if ([quantityId length] > 1 && [brandId length] > 1)
            {
                tempURL = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&order=%@&%@&%@", tempURL1 , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString, quantityId, brandId];
            }
            else if ([quantityId length] > 1)
            {
                tempURL = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&order=%@&%@", tempURL1 , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString, quantityId];
            }
            else if ([brandId length] > 1)
            {
                tempURL = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&order=%@&%@", tempURL1 , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString, brandId];
            }
            else
            {
                tempURL = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&order=%@", tempURL1 , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString];
            }
            
            self.moreBtnObj.hidden = YES;
            //    [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
            
            
            //    NSLog(@"search %@", tempURL);
            
            NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                         NULL,
                                                                                                         (CFStringRef)tempURL,
                                                                                                         NULL,
                                                                                                         (CFStringRef)@"<>",
                                                                                                         kCFStringEncodingUTF8));
            
            
            
            AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1]];
            [httpClient setParameterEncoding:AFFormURLParameterEncoding];
            NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                                    path:urlEncoded
                                                              parameters:nil];
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 NSError *jsonError = nil;
                 
                 
                 sortStr = @"Search";
                 
                 [SVProgressHUD dismiss];
                 // NSMutableArray *tempDict;
                 
                 tempDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
                 
                 
                 // tempDict = [NSJSONSerialization JSONObjectWithData:result options:0 error:NULL];
                 
                 //             priceStr = [[[[tempDict valueForKey:@"responseHeader"] valueForKey:@"params"] valueForKey:@"stats.field"] objectAtIndex:0];
                 //
                 //             specialPriceStr = [[[[tempDict valueForKey:@"responseHeader"] valueForKey:@"params"] valueForKey:@"stats.field"] objectAtIndex:1];
                 
                 
                 productDetailsDict = [[tempDict valueForKey:@"response"] valueForKey:@"docs"];
                 allDataDict = productDetailsDict;
                 appDelegate.filterSearchDict = [[tempDict valueForKey:@"facet_counts"] valueForKey:@"facet_fields"];
                 
                 //             NSLog(@"productDetailsDict %@", productDetailsDict);
                 if ([bangeLbl.text integerValue] > 0)
                 {
                     bangeLbl.hidden = NO;
                 }
                 else
                 {
                     bangeLbl.hidden = YES;
                 }
                 
                 if (productDetailsDict.count < 1)
                 {
                     [self.view addSubview:[[ToastAlert alloc] initWithText:@"No product found"]];
                 }
                 
                 if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                 {
                     appDelegate.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                     bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                     productDetailsDict = [tempDict valueForKey:@"data"];
                     
                     
                     
                     for (NSDictionary *cartDict in productDetailsDict)
                     {
                         
                         [cartCountDictLocal setObject:[cartDict valueForKey:@"in_cart"] forKey:[cartDict  valueForKey:@"entity_id"]];
                         [cartCountModifyDict setObject:[cartDict valueForKey:@"cart_itemid"] forKey:[cartDict  valueForKey:@"entity_id"]];
                     }
                     
                     [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                 }
                 else
                 {
                     
                 }
                 [itemDetailsTblVew reloadData];
                 [SVProgressHUD dismiss];
             }
             
             
                                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                 [SVProgressHUD dismiss];
                                                 //                                         NSLog(@"Error: %@", error);
                                             }];
            [operation start];
            
            
            __weak SearchListVC *weakSelf = self;
            
            
            // setup infinite scrolling
            [itemDetailsTblVew addInfiniteScrollingWithActionHandler:^{
                [weakSelf insertRowAtBottom];
            }];
            
            
            
            
            
           
            
            sortFlag = NO;
            
            if ([productDetailsDict count] < 10)
            {
                self.moreBtnObj.hidden = YES;
            }
            [itemDetailsTblVew reloadData];
            
            cartCountDict = appDelegate.cartDict;
            //NSLog(@"cartCountDict %@", cartCountDict);
            bangeLbl.text = appDelegate.bangeStr;
            if ([bangeLbl.text integerValue] > 0)
            {
                bangeLbl.hidden = NO;
            }
            else
            {
                bangeLbl.hidden = YES;
            }
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"Addtitle"];
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"slotKey"];
            
            
        }
    
        
        
    }
    

@end
