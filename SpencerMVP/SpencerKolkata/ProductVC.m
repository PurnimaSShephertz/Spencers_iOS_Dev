//
//  ProductVC.m
//  Spencer
//
//  Created by binary on 02/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "ProductVC.h"
#import "Webmethods.h"
#import "UIImageView+WebCache.h"
#import "SearchVC.h"
#import "IQKeyboardManager.h"
#import "AppDelegate.h"
#import "ProductDetailPage.h"
#import "InCartVC.h"
#import "AppDelegate.h"
#import "MainCategoryVC.h"
#import "ManualLocationVC.h"
#import "SVProgressHUD.h"
#import "MyProfileVC.h"
#import "CategoryPage.h"
#import "OfferVC.h"
#import "GAIEcommerceProduct.h"
#import "GAIDictionaryBuilder.h"
#import "SH_TrackingUtility.h"


@interface ProductVC ()
{
    SearchVC *searchVC;
    NSArray *productArr;
    NSDictionary *productDict;
    AppDelegate *appDele;
    InCartVC *inCartVC;
    IBOutlet UILabel *bangeLbl;
    ManualLocationVC *manualLocationVC;
    NSString *brandId;
    NSString *quantityId;
    
    int count1;
}
@end

@implementation ProductVC
@synthesize categoryUrl;
@synthesize productHeader;
@synthesize pageNumber;


#pragma mark VIewLifeCycle

- (void)setUpACPScroll
{
    
    NSArray * TabsArr=[[NSArray alloc]initWithObjects:@"Fruit",@"Vegitables",@"Mango",@"Apple", nil];
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"checkbacground_img"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [TabsArr count]; i++)
    {
        if (i==0)
        {
            
        }
        
        
        ACPItem *item = [[ACPItem alloc] initACPItem:nil
                                           iconImage:nil
                                               label:[TabsArr objectAtIndex:i]
                                           andAction: ^(ACPItem *item)
                         {
                             
                         }];
        
        [item setHighlightedBackground:nil iconHighlighted:nil textColorHighlighted:[UIColor darkGrayColor]];
        [array addObject:item];
        [_scrollMenu setUpACPScrollMenu:array];
        [_scrollMenu setAnimationType:ACPZoomOut];
        _scrollMenu.delegate = self;
      
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
    
    
    [titleLabelButton setTitle:productHeader forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 160, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
//    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([productHeader isEqualToString:@"Offers"])
    {
        [offerBtnObj setImage:[UIImage imageNamed:@"ic_offers_hover.png"] forState:UIControlStateNormal];
        offerBtnObj.userInteractionEnabled = NO;
    }
    else
    {
        [offerBtnObj setImage:[UIImage imageNamed:@"ic_offers.png"] forState:UIControlStateNormal];
        offerBtnObj.userInteractionEnabled = YES;
    }
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    [navView addSubview:titleLabelButton];
    
    self.navigationItem.titleView = navView;
    
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
    [arrRightBarItems addObject:barButtonItem3];
    
    
    
//    [btnSetting setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
//    btnSetting.frame = CGRectMake(0, 0, 32, 32);
//    //btnSetting.showsTouchWhenHighlighted=YES;
//    [btnSetting addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
//    [arrRightBarItems addObject:barButtonItem];
    
    bangeLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,-5 , 18, 18)];
    bangeLbl.text = appDele.bangeStr;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Document Directory %@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]);
    self.screenName = @"Product List Screen";
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandIdMyArr"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"quantityIdMyArr"];
    [[NSUserDefaults standardUserDefaults] setInteger:13 forKey:@"sortingByIndex"];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    cartCountDictLocal = [[NSMutableDictionary alloc] init];
    cartCountModifyDict = [[NSMutableDictionary alloc] init];
    
    bangeLbl.layer.cornerRadius = 9;
    bangeLbl.layer.masksToBounds = YES;
    bangeLbl.layer.borderColor = [UIColor whiteColor].CGColor;
    bangeLbl.layer.borderWidth = 1;
    bangeLbl.hidden = YES;
    
    storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    appDele.ACPBool = 1;
    [[IQKeyboardManager sharedManager] setEnable:FALSE];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:FALSE];
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    screenX = [UIScreen mainScreen].bounds.origin.x;
    screenY =[UIScreen mainScreen].bounds.origin.y;
    
    productListTblVew.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    
//    id tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-89841831-1"];
//    GAIEcommerceProduct *product = [[GAIEcommerceProduct alloc] init];
//    [product setId:@"P12345"];
//    [product setName:@"Android Warhol T-Shirt"];
//    [product setCategory:@"Apparel/T-Shirts"];
//    [product setBrand:@"Google"];
//    [product setVariant:@"Black"];
//    [product setCustomDimension:1 value:@"Member"];
//    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
//    
//    // Sets the product impression for the next available slot, starting with 1.
//    [builder addProductImpression:product
//                   impressionList:@"Search Results"
//                 impressionSource:@"From Search"];
//    [tracker set:@"Product List Screen" value:@"Product List Screen"];
//    [tracker send:[builder build]];
    
    
    
    
//    productListTblVew.tableHeaderView = ({
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,10, 0, 200.0f)];
//
//        
//        UIScrollView *headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width-20, 145)];
//        [view addSubview:headerScrollView];
//        headerScrollView.pagingEnabled = YES;
//        for (int i = 0; i < 2;i++)
//        {
//            headerImgVew = [[UIImageView alloc] initWithFrame:CGRectMake(i*(width-20), 0, width-20, 145)];
//            headerImgVew.contentMode = UIViewContentModeScaleToFill;
//            headerImgVew.image = [UIImage imageNamed:[NSString stringWithFormat:@"carousel_img%i.jpg", i+1]];
//            [headerScrollView addSubview:headerImgVew];
//        }
//        headerScrollView.contentSize = CGSizeMake((width-20)*2, 145);
//        
//        
//        _scrollMenu = [[ACPScrollMenu alloc] initWithFrame:CGRectMake(0, 145, width-78, 50)];
//        _scrollMenu.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
//        [view addSubview:_scrollMenu];
//        
//        
//        filterBtnObj = [UIButton buttonWithType: UIButtonTypeCustom];
//        filterBtnObj.frame = CGRectMake(width-78, 145, 50, 50);
//        filterBtnObj.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
//        [filterBtnObj addTarget:self action:@selector(filterBtnAct:) forControlEvents:UIControlEventTouchUpInside];
//        [filterBtnObj setImage:[UIImage imageNamed:@"ic_sort.png"] forState:UIControlStateNormal];
//        [view addSubview:filterBtnObj];
//      
//         view;
//    });
//    [self setUpACPScroll];

    
    
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
        [productListTblVew setContentOffset:CGPointZero animated:YES];
        [self callGetproductsAPI];
    }
    

-(IBAction)filterBtnAct:(id)sender
{
    sortFilterVC = [[SortFilterVC alloc] initWithNibName:@"SortFilterVC" bundle:nil];
    sortFilterVC.productHeader=productHeader;
    [self.navigationController pushViewController:sortFilterVC animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [filterBtnObj removeFromSuperview];
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
}

//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [[SDImageCache sharedImageCache] removeImageForKey:cacheImgStr fromDisk:YES];
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[productListTblVew setContentOffset:CGPointZero animated:YES];
    
    
    [productListTblVew reloadData];
    
    
    bangeLbl.hidden = YES;
    
    [searchBar1 resignFirstResponder];
    self.navigationController.navigationBar.hidden = NO;
    [self navigationView];
    
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
    
    
//    filterBtnObj = [UIButton buttonWithType: UIButtonTypeCustom];
//    filterBtnObj.frame = CGRectMake(width-80, 5, 30, 30);
////    filterBtnObj.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
//    [filterBtnObj addTarget:self action:@selector(filterBtnAct:) forControlEvents:UIControlEventTouchUpInside];
//    [filterBtnObj setImage:[UIImage imageNamed:@"ic_sort.png"] forState:UIControlStateNormal];
//    [self.navigationController.navigationBar addSubview:filterBtnObj];

    
   
    
    
    
    /***
     Item_Viewed Event Satrt
     ***/
    NSMutableDictionary *addtocartDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], kCartIdProperty,
                                          nil];
    [SH_TrackingUtility trackEventOfSpencerEvents:itemViewedEvent eventProp:addtocartDict];
    /***
     Item_Viewed Event End
     ***/
}

-(
  
  void)popVC
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

-(void)insertRowAtBottom
{
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    
    brandId = [[NSUserDefaults standardUserDefaults] valueForKey:@"brandId"];
    quantityId = [[NSUserDefaults standardUserDefaults] valueForKey:@"quantityId"];
    
    
    pageNumber ++;
    //    int64_t delayInSeconds = .0;
    //    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    //    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    //        [itemDetailsTblVew beginUpdates];
    
    
        
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"loadmore"] integerValue] == 0)
        {
            [productListTblVew endUpdates];
            [productListTblVew.infiniteScrollingView stopAnimating];
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"No More Products"]];
            
            return ;
        }
        
        if (sortFlag == YES)
        {
//            [SVProgressHUD show];
//            NSString * URL=[NSString stringWithFormat:@"http://apis.spencers.in/api/rest/category/products/%d/?sort=%@&dir=%@&page=%i&store=%@&quantity=%@&brand=%@",appDele.categoryId,sortString,descString, pageNumber, storeIdStr, quantityId, brandId];
            storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
            NSString * URL;
            
            if ([quantityId length] > 1 && [brandId length] > 1)
            {
                URL=[NSString stringWithFormat:@"%@/category/products/%d/?sort=%@&dir=%@&page=%i&store=%@&quantity=%@&brand=%@", baseUrl1, appDele.categoryId,sortString, descString, pageNumber, storeIdStr, quantityId, brandId];
            }
            else if ([quantityId length] > 1)
            {
                URL=[NSString stringWithFormat:@"%@/category/products/%d/?sort=%@&dir=%@&page=%i&store=%@&quantity=%@", baseUrl1, appDele.categoryId,sortString, descString, pageNumber, storeIdStr, quantityId];
            }
            else if ([brandId length] > 1)
            {
                URL=[NSString stringWithFormat:@"%@/category/products/%d/?sort=%@&dir=%@&page=%i&store=%@&brand=%@", baseUrl1, appDele.categoryId,sortString, descString, pageNumber, storeIdStr, brandId];
            }
            else
            {
                URL=[NSString stringWithFormat:@"%@/category/products/%d/?sort=%@&dir=%@&page=%i&store=%@", baseUrl1, appDele.categoryId,sortString, descString, pageNumber, storeIdStr];
            }

            
            
            NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
            NSString *oauth_token = [temp objectForKey:@"oauth_token"];
            
            if(oauth_token==NULL || [oauth_token isEqual:@""])
            {
                NSURL *url = [NSURL URLWithString:URL];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                [NSURLConnection sendAsynchronousRequest:request
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:^(NSURLResponse *response,
                                                           NSData *data, NSError *connectionError)
                 {
                     if (data.length > 0 && connectionError == nil)
                     {
                         NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                         appDele.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                         bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                         [SVProgressHUD dismiss];
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
                             NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[productArr arrayByAddingObjectsFromArray:[tempDict valueForKey:@"data"]]];
                             productArr = tempArr;
                             NSMutableArray *tempDicArr = [tempDict valueForKey:@"data"];
                             for (NSDictionary *cartDict in tempDicArr)
                             {
                                 [cartCountDictLocal setObject:[cartDict valueForKey:@"in_cart"] forKey:[cartDict valueForKey:@"entity_id"]];
                                 [cartCountModifyDict setObject:[cartDict valueForKey:@"cart_itemid"] forKey:[cartDict  valueForKey:@"entity_id"]];
                             }
                             [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                             [[NSUserDefaults standardUserDefaults] synchronize];
                             [productListTblVew reloadData];
                         }
                         else
                         {
                             pageNumber--;
                             [self.view addSubview:[[ToastAlert alloc] initWithText:@"No More Products"]];
                         }
                     }
                     
                     else
                     {
                         [SVProgressHUD dismiss];
//                         [HUD hide:YES];
                         //[self.view addSubview:[[ToastAlert alloc] initWithText:@"No Network Found"]];
                     }
                     [productListTblVew endUpdates];
                     [productListTblVew.infiniteScrollingView stopAnimating];
                 }];
                
            }
            else
            {
                
//                [SVProgressHUD show];
//                NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&quantity=%@&brand=%@", URL , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], quantityId, brandId];
                NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", URL , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
                NSDictionary *tempDict = [Webmethods product:cartIdStr];
                
                //NSLog(@"globalcartid %@", cartIdStr);
                
//                [HUD hide:YES];
                if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                {
                    
                    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[productArr arrayByAddingObjectsFromArray:[tempDict valueForKey:@"data"]]];
                    productArr = tempArr;
                    
                    appDele.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                    bangeLbl.text = appDele.bangeStr;
                    
                    
                    if ([bangeLbl.text integerValue] > 0)
                    {
                        bangeLbl.hidden = NO;
                    }
                    else
                    {
                        bangeLbl.hidden = YES;
                    }
                    
                    NSMutableArray *tempDicArr = [tempDict valueForKey:@"data"];
                    
                    for (NSDictionary *cartDict in tempDicArr)
                    {
                        [cartCountDictLocal setObject:[cartDict valueForKey:@"in_cart"] forKey:[cartDict valueForKey:@"entity_id"]];
                        [cartCountModifyDict setObject:[cartDict valueForKey:@"cart_itemid"] forKey:[cartDict  valueForKey:@"entity_id"]];
                    }
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [productListTblVew reloadData];
                }
                else
                {
                    pageNumber--;
                    [self.view addSubview:[[ToastAlert alloc] initWithText:@"No More Products"]];
                }
                [SVProgressHUD dismiss];
                [productListTblVew endUpdates];
                [productListTblVew.infiniteScrollingView stopAnimating];
                
            }
        }
        else
        {
//            [SVProgressHUD show];
            
//            NSString *urlStr = [NSString stringWithFormat:@"http://apis.spencers.in/api/rest/category/products/%d?page=%i&cartid=%@&sort=%@&dir=%@&store=%@&quantity=%@&brand=%@", appDele.categoryId, pageNumber, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], sortString, descString, storeIdStr, quantityId, brandId];
            
            
            
            
            
            NSString *urlStr ;
            storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
            if ([quantityId length] > 1 && [brandId length] > 1)
            {
                urlStr = [NSString stringWithFormat:@"%@/category/products/%d?page=%i&cartid=%@&sort=%@&dir=%@&store=%@&quantity=%@&brand=%@", baseUrl1, appDele.categoryId, pageNumber, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], sortString, descString, storeIdStr, quantityId, brandId];
            }
            else if ([quantityId length] > 1)
            {
                
                urlStr = [NSString stringWithFormat:@"%@/category/products/%d?page=%i&cartid=%@&sort=%@&dir=%@&store=%@&quantity=%@", baseUrl1, appDele.categoryId, pageNumber, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], sortString, descString, storeIdStr, quantityId];
            }
            else if ([brandId length] > 1)
            {
                
                urlStr = [NSString stringWithFormat:@"%@/category/products/%d?page=%i&cartid=%@&sort=%@&dir=%@&store=%@&brand=%@", baseUrl1, appDele.categoryId, pageNumber, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], sortString, descString, storeIdStr, brandId];
            }
            else
            {
                urlStr = [NSString stringWithFormat:@"%@/category/products/%d?page=%i&cartid=%@&sort=%@&dir=%@&store=%@", baseUrl1, appDele.categoryId, pageNumber, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], sortString, descString, storeIdStr];
            }

            
            
            
            
            NSURL *url = [NSURL URLWithString:urlStr];
            
            NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
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
                         NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                         
                         [SVProgressHUD dismiss];
                         
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
                             NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[productArr arrayByAddingObjectsFromArray:[tempDict valueForKey:@"data"]]];
                             productArr = tempArr;
                             
                             
                             appDele.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                             bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                             
                             NSMutableArray *tempDicArr = [tempDict valueForKey:@"data"];
                             
                             for (NSDictionary *cartDict in tempDicArr)
                             {
                                 [cartCountDictLocal setObject:[cartDict valueForKey:@"in_cart"] forKey:[cartDict  valueForKey:@"entity_id"]];
                                 [cartCountModifyDict setObject:[cartDict valueForKey:@"cart_itemid"] forKey:[cartDict  valueForKey:@"entity_id"]];
                             }
                             
                             
                             [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                             [[NSUserDefaults standardUserDefaults] synchronize];
                             
                             
                             [productListTblVew reloadData];
                         }
                         else
                         {
                             pageNumber--;
                             [self.view addSubview:[[ToastAlert alloc] initWithText:@"No More Products"]];
                         }
                         
                         [productListTblVew endUpdates];
                         [productListTblVew.infiniteScrollingView stopAnimating];
                     }
                     else
                     {
                         [SVProgressHUD dismiss];
                     }
                 }];
                
            }
            
            else
            {
                
//                [SVProgressHUD show];
//                NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&quantity=%@&brand=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], quantityId, brandId];
                NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
                
                NSDictionary *tempDict = [Webmethods product:cartIdStr];
                
                //NSLog(@"globalcartid %@", cartIdStr);
//                [HUD hide:YES];
                //NSLog(@"tempDict %@", tempDict);
                [SVProgressHUD dismiss];
                if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                {
                    
                    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:[productArr arrayByAddingObjectsFromArray:[tempDict valueForKey:@"data"]]];
                    productArr = tempArr;
                    
                    appDele.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                    bangeLbl.text = appDele.bangeStr;
                    
                    
                    if ([bangeLbl.text integerValue] > 0)
                    {
                        bangeLbl.hidden = NO;
                    }
                    else
                    {
                        bangeLbl.hidden = YES;
                    }
                    
                    //                    productDetailsDict = [tempDict valueForKey:@"data"];
                    
                    NSMutableArray *tempDicArr = [tempDict valueForKey:@"data"];
                    
                    for (NSDictionary *cartDict in tempDicArr)
                    {
                        
                        [cartCountDictLocal setObject:[cartDict valueForKey:@"in_cart"] forKey:[cartDict  valueForKey:@"entity_id"]];
                        [cartCountModifyDict setObject:[cartDict valueForKey:@"cart_itemid"] forKey:[cartDict  valueForKey:@"entity_id"]];
                    }
                    
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
//                    [HUD hide:YES];
                    [productListTblVew reloadData];
                }
                else
                {
                    [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
//                    [HUD hide:YES];
                }
                [SVProgressHUD dismiss];
                [productListTblVew endUpdates];
                [productListTblVew.infiniteScrollingView stopAnimating];
                
                
            }
        }
    
    //    });
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UITableViewCell Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductCell *cell;
    if (cell == nil)
    {
//        if(UI_USER_INTER1FACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil];
//        }
//        else
//        {
//            [[NSBundle mainBundle] loadNibNamed:@"ProductCell~iPad" owner:self options:nil];
//        }
        cell = productCell;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *seperatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(screenX+8, 129, width-16, 1)];
    seperatorImg.backgroundColor = kColor_Orange;
    [cell addSubview:seperatorImg];
    
    
    
    NSString *trimmedString = [[[productArr  objectAtIndex:indexPath.row] valueForKey:@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    cell.name.text = trimmedString;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:[[productArr objectAtIndex:indexPath.row] valueForKey:@"image_url"]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    cell.count.text = [NSString stringWithFormat:@"%@", [[productArr objectAtIndex:indexPath.row] valueForKey:@"in_cart"]];
    cell.plusObj.tag = indexPath.row;
    cell.minusObj.tag = indexPath.row;
    cell.addCartBtnObj.tag = indexPath.row;
    cell.count.tag = indexPath.row;
    
    
    
    cell.productDetailsBtnObj.tag = indexPath.row;
    
    
    if ([[[productArr objectAtIndex:indexPath.row] valueForKey:@"promotion_tags_value"] isKindOfClass:[NSNull class]])
    {
        cell.promotionLbl.text = @"";
    }
    else
    {
        cell.promotionLbl.text = [[productArr objectAtIndex:indexPath.row] valueForKey:@"promotion_tags_value"];
    }
    
    if ([[[productArr objectAtIndex:indexPath.row] valueForKey:@"special_price"] isKindOfClass:[NSNull class]])
    {
        
        cell.mrpCutLbl.hidden = YES;
        cell.mrp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[productArr objectAtIndex:indexPath.row] valueForKey:@"price"] floatValue]];
        cell.mrp.text = @"";
        cell.sp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[productArr objectAtIndex:indexPath.row] valueForKey:@"price"] floatValue]];
    }
    else
    {
        cell.mrpCutLbl.hidden = NO;
        cell.mrp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[productArr objectAtIndex:indexPath.row] valueForKey:@"price"] floatValue]];
        cell.sp.text = [NSString stringWithFormat:@"Rs. %.2f", [[[productArr objectAtIndex:indexPath.row] valueForKey:@"special_price"] floatValue]];
    }
    
    NSString *itemsCount = [cartCountDictLocal valueForKey:[[productArr objectAtIndex:indexPath.row] valueForKey:@"entity_id"]];
    
    
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

    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return productArr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer  = [[UIView alloc] initWithFrame:CGRectZero];
    return footer;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
    return view;
}
-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 200;
//}


#pragma mark ButtonAction

- (IBAction)minusAct:(UIButton *)sender
{
    
    
    ProductCell *selectedCell = (ProductCell *)[productListTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    
    NSString *eid = [[productArr objectAtIndex:sender.tag] valueForKey:@"entity_id"];
    
    NSString *itemId = [cartCountModifyDict valueForKey:eid];
    
    
    
    count1 = (int)[selectedCell.count.text integerValue];
    if (count1 > 0)
    {
        count1 --;
        selectedCell.count.text = [NSString stringWithFormat:@"%i",count1];
    }
    else
    {
        selectedCell.count.text = [NSString stringWithFormat:@"%@",@""];
        return ;
    }
    
    NSDictionary *cartDictLocal = [productArr objectAtIndex:sender.tag];
    
    
    if ([selectedCell.count.text integerValue] < 1)
    {
        selectedCell.addCartBtnObj.hidden = YES;
        if ([cartCountDictLocal valueForKey:[cartDictLocal valueForKey:@"entity_id"]])
        {
            itemId = [NSString stringWithFormat:@"%@", [cartCountModifyDict valueForKey:[cartDictLocal valueForKey:@"entity_id"]]];
        }
        
        
//        if ([[cartCountDictLocal valueForKey:[NSString stringWithFormat:@"%@",[[[[[productArr objectAtIndex:sender.tag] valueForKey:@"super_attribute"] valueForKey:@"values"]  objectAtIndex:rowSelected] valueForKey:@"id"]]] integerValue] > 0)
//        {
//            itemId = [cartCountModifyDict valueForKey:[NSString stringWithFormat:@"%@",[[[[[productArr objectAtIndex:sender.tag] valueForKey:@"super_attribute"] valueForKey:@"values"]  objectAtIndex:rowSelected] valueForKey:@"id"]]];
//        }
    }
    
    [SVProgressHUD show];
    if ([itemId intValue] < 1)
    {
        [SVProgressHUD dismiss];
        return ;
    }
    
    if (count1 == 0)
    {
        
        
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO) {
            return ;
        }
        [SVProgressHUD show];
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        NSString *URL=[NSString stringWithFormat:@"%@/cart/delete/?itemid=%@&store=%@&cartid=%@", baseUrl1, itemId, storeIdStr, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        
        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        NSString * oauth_token =[temp objectForKey:@"oauth_token"];
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
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
                     
                     [SVProgressHUD dismiss];
                     
//                     NSLog(@"tempDict %@", tempDict);
                     
                     if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                    {
                        appDele.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
                        bangeLbl.text = appDele.bangeStr;
                        [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                        //                     [self getcartdata];
                        
                        [cartCountDictLocal setObject:selectedCell.count.text forKey:[cartDictLocal  valueForKey:@"entity_id"]];
                        
                        [cartCountModifyDict setObject:[NSString stringWithFormat:@"%@", [tempDict objectForKey:@"cart_itemid"]] forKey:[cartDictLocal  valueForKey:@"entity_id"]];
                        
                        
                        //                     [self refreshCategory];
                        if ([bangeLbl.text integerValue] > 0)
                        {
                            bangeLbl.hidden = NO;
                        }
                        else
                        {
                            bangeLbl.hidden = YES;
                        }
                        [productListTblVew reloadData];
                     }
                     [SVProgressHUD dismiss];
//                     [HUD hide:YES];
                 }
             }];
        }
        else
        {
            [SVProgressHUD show];
            NSDictionary *tempDict = [Webmethods DeleteItemFromCart:URL];
            //NSLog(@"tempDict %@", tempDict);
            
            [SVProgressHUD dismiss];
            
            appDele.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
            bangeLbl.text = appDele.bangeStr;
            
            [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
            
            
            
            [cartCountDictLocal setObject:selectedCell.count.text forKey:[cartDictLocal  valueForKey:@"entity_id"]];
            
            [cartCountModifyDict setObject:[NSString stringWithFormat:@"%@", [tempDict objectForKey:@"cart_itemid"]] forKey:[cartDictLocal  valueForKey:@"entity_id"]];
            
            
            //            [cartCountDictLocal setObject:selectedCell.numberOfItems.text forKey:[[[[cartDictLocal valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:rowSelected] valueForKey:@"id"]];
            //            [cartCountModifyDict setObject:[NSString stringWithFormat:@"%@", [tempDict objectForKey:@"item_id"]] forKey:[[[[cartDictLocal valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:rowSelected] valueForKey:@"id"]];
            
            //            [self getcartdata];
            //            [self refreshCategory];
            if ([bangeLbl.text integerValue] > 0)
            {
                bangeLbl.hidden = NO;
            }
            else
            {
                bangeLbl.hidden = YES;
            }
            [SVProgressHUD dismiss];
            [productListTblVew reloadData];
//            [HUD hide:YES];
        }
    }
    else
    {
        [self addCartBtnAct:sender];
    }
    [SVProgressHUD dismiss];
}

- (IBAction)plusAct:(UIButton *)sender
{
    ProductCell *selectedCell = (ProductCell *)[productListTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    count1 = (int)[selectedCell.count.text integerValue];
    count1 ++;
    
//    selectedCell.count.text = [NSString stringWithFormat:@"%i", count1];
    
    if ([selectedCell.count.text integerValue] > 0)
    {
        selectedCell.addCartBtnObj.hidden = NO;
    }
    
    [self addCartBtnAct:sender];
}

- (IBAction)backBtnAct:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"quantityId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sortingBy"];
    [self.navigationController popViewControllerAnimated:NO];
}


#pragma mark SearchBar

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchVC = [[SearchVC alloc] initWithNibName:@"SearchVC" bundle:nil];
    [self.navigationController pushViewController:searchVC animated:NO];
    [searchBar resignFirstResponder];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
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
//                productVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//            }
//            else
//            {
//                productVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//            }
            productHeader = [[listNameArray objectAtIndex:9] valueForKey:@"name"];
            categoryUrl = urlStr;
            [productListTblVew setContentOffset:CGPointZero animated:YES];
            [self callGetproductsAPI];
            
            
//            BOOL flag = NO;
//            for (UIViewController *controller in self.navigationController.viewControllers)
//            {
//                if ([controller isKindOfClass:[OfferVC class]])
//                {
//                    flag = YES;
//                    [self.navigationController popToViewController:controller animated:YES];
//                    break;
//                }
//            }
//            if (flag == NO)
//            {
//                OfferVC * offerVC= [[OfferVC alloc]initWithNibName:@"OfferVC" bundle:nil];
//                [self.navigationController pushViewController:offerVC animated:YES];
//            }
        }
            break;
        case 14:
            {
                NSUserDefaults * temp=[NSUserDefaults standardUserDefaults];
                NSString * oauth_token =[temp objectForKey:@"oauth_token"];
                if(oauth_token==NULL || [oauth_token isEqual:@""])
                {
                    
                    LoginVC* loginpage;
//                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//                    {
                        loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
//                    }
//                    else
//                    {
//                        loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC~iPad" bundle:nil];
//                    }
                    loginpage.CheckProfileStatus=@"002";
                    [self.navigationController pushViewController:loginpage animated:NO];
                }
                else
                {
                    
                    MyProfileVC *myProfile;
                    
//                    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//                    {
                        myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC" bundle:nil];
//                    }
//                    else
//                    {
//                        myProfile = [[MyProfileVC alloc] initWithNibName:@"MyProfileVC~iPad" bundle:nil];
//                    }
                    [self.navigationController pushViewController:myProfile animated:NO];
                    
                }

            }
            
            break;
            
            
        default:
            break;
    }
}

- (IBAction)currentLocationBtnAct:(UIButton *)sender
{
    manualLocationVC = [[ManualLocationVC alloc] initWithNibName:@"ManualLocationVC" bundle:nil];
    manualLocationVC.headercheck=@"1001";
    [self.navigationController pushViewController:manualLocationVC animated:YES];
}


#pragma mark CartDetails
- (IBAction)addCartBtnAct:(UIButton *)sender
{
    //    pageNumber = 1;
    
    
    if ([sender.titleLabel.text isEqualToString:@"OUT OF Stock"])
    {
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"OUT OF Stock"]];
        return ;
    }
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    [SVProgressHUD show];
    
    ProductCell *selectedCell = (ProductCell *)[productListTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    
    
    
    
    selectedCell.addCartBtnObj.userInteractionEnabled = NO;
    
    // [NSThread detachNewThreadSelector:@selector(threadStartAnimating2:) toTarget:self withObject:nil];
    
    NSString *pidStr = [[productArr objectAtIndex:sender.tag] valueForKey:@"entity_id"];
    NSString *qtyStr ;
//    NSString *optionStr =  [[[[[productArr objectAtIndex:sender.tag] valueForKey:@"super_attribute"] valueForKey:@"values"]  objectAtIndex:[[kgIndexDict valueForKey:[NSString stringWithFormat:@"%li",(long)sender.tag]] integerValue]] valueForKey:@"value_index"];
    
    NSDictionary *cartDictLocal = [productArr objectAtIndex:sender.tag];
    
    NSString *inCartStr = [NSString stringWithFormat:@"%@", [cartCountModifyDict valueForKey:[cartDictLocal valueForKey:@"entity_id"]]];
    
//    NSString *itemId = [[[[[productArr objectAtIndex:sender.tag] valueForKey:@"super_attribute"] valueForKey:@"values"]  objectAtIndex:rowSelected] valueForKey:@"cart_itemid"];
    
    
    
    
//    for (int i = 0; i < sortArray.count; i++)
//    {
//        if ([[sortArray objectAtIndex:sender.tag] isEqualToString:[[productArr objectAtIndex:i] valueForKey:@"final_price"]])
//        {
//            pidStr = [[[[[[productArr objectAtIndex:i] valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:0] objectAtIndex:[[kgIndexDict valueForKey:[NSString stringWithFormat:@"%li",(long)i]] integerValue]] valueForKey:@"id"];
//            qtyStr = selectedCell.numberOfItems.text;
//            optionStr =  [[[[[[productDetailsDict objectAtIndex:i] valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:0] objectAtIndex:[[kgIndexDict valueForKey:[NSString stringWithFormat:@"%i",i]] integerValue]] valueForKey:@"value_index"];
//            attribute = [[[productDetailsDict objectAtIndex:i] valueForKey:@"super_attribute"] valueForKey:@"attribute_id"];
//            
//            break;
//        }
//    }
    
    //    rowSelected = 0;
    
    if ([selectedCell.count.text isEqualToString:@"0"])
    {
        //        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please add item in cart"]];
        qtyStr = @"1";
        //        return;
    }
    else
    {
        qtyStr = [NSString stringWithFormat:@"%li", (long)count1];
        //  - [[[[[[productDetailsDict objectAtIndex:sender.tag] valueForKey:@"super_attribute"] valueForKey:@"values"] valueForKey:@"in_cart"] objectAtIndex:rowSelected] integerValue]];
    }
    
    
    if ( [inCartStr integerValue] < 1 )
    {
        
        
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/cart/add/?pid=%@&qty=%@&store=%@", baseUrl1, pidStr, qtyStr, storeIdStr];
        
        
        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        NSString * oauth_token =[temp objectForKey:@"oauth_token"];
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
            
            //            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            
            NSString *cartIdStr;
            
            cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            
//            NSLog(@"add cart With Login url %@", cartIdStr);
            //            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            
            NSURL *url = [NSURL URLWithString:cartIdStr];
            
            
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [NSURLConnection sendAsynchronousRequest:request
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 if (data.length > 0 && connectionError == nil)
                 {
                     selectedCell.userInteractionEnabled = YES;
//                     [HUD hide:YES];
                     NSDictionary *currentArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                     if ([[currentArray valueForKey:@"status"] integerValue] == 1)
                     {
                         
                         
                         
                         
                         
                         selectedCell.count.text = [NSString stringWithFormat:@"%i", count1];
                         
                         if ([[currentArray valueForKey:@"cartid"] integerValue] > 0)
                         {
                             [[NSUserDefaults standardUserDefaults] setObject:[currentArray valueForKey:@"cartid"] forKey:@"globalcartid"];
                         }
                         
                         
                         
                         /***
                          Add To Cart Event Satrt
                          ***/
                         NSMutableDictionary *addtocartDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                               [currentArray valueForKey:@"cartid"], kCartIdProperty,
                                                               nil];
                         [SH_TrackingUtility trackEventOfSpencerEvents:addToCartEvent eventProp:addtocartDict];
                         /***
                          Add To Cart Event End
                          ***/
                         
                         [cartCountDictLocal setObject:selectedCell.count.text forKey:[cartDictLocal valueForKey:@"entity_id"]];
                         
                         [cartCountModifyDict setObject:[NSString stringWithFormat:@"%@", [currentArray objectForKey:@"item_id"]] forKey:[cartDictLocal valueForKey:@"entity_id"]];
                         
                         
                         appDele.bangeStr = [NSString stringWithFormat:@"%@",[currentArray valueForKey:@"cart_count"]];
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
                     [SVProgressHUD dismiss];
                     [productListTblVew reloadData];
                     
                 }
                 else{
//                     [HUD hide:YES];
                     [SVProgressHUD dismiss];
                 }
             }];
        }
        else
        {
            
            
            
            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            
//            NSLog(@"add cart With Login url %@", cartIdStr);
            
            NSDictionary *tempDict = [Webmethods AddtoCart_Login:cartIdStr];
            
            [SVProgressHUD dismiss];
            
            if ([[tempDict valueForKey:@"cartid"] integerValue] > 0)
            {
                [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"cartid"] forKey:@"globalcartid"];
            }
            
//            [HUD hide:YES];
            
            
            if ([[tempDict valueForKey:@"status"] integerValue] == 1)
            {
                
                selectedCell.count.text = [NSString stringWithFormat:@"%i", count1];
                
                
                [cartCountDictLocal setObject:selectedCell.count.text forKey:[cartDictLocal  valueForKey:@"entity_id"]];
                [cartCountModifyDict setObject:[tempDict valueForKey:@"item_id"] forKey:[cartDictLocal  valueForKey:@"entity_id"]];
                
                
                
                appDele.bangeStr = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
                bangeLbl.text = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
                
                if ([bangeLbl.text integerValue] > 0)
                {
                    bangeLbl.hidden = NO;
                }
                else
                {
                    bangeLbl.hidden = YES;
                }
                //                if ([sortStr isEqualToString:@"Search"])
                //                {
                //                    [self search];
                //                }
                //                else
                //                {
                //                    [self refreshCategory];
                //                }
                
                
                //                NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:rowSeletcedIs inSection:0];
                //                NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
                //                [itemDetailsTblVew reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
                
                
                
                [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
            }
            else
            {
                [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
            }
            
            [productListTblVew reloadData];
            selectedCell.addCartBtnObj.userInteractionEnabled = YES;
        }
        
        
    }
    else
    {
        [SVProgressHUD show];
        storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        NSString *URL=[NSString stringWithFormat:@"%@/cart/update/?cart[%@]=%i&store=%@", baseUrl1,inCartStr, count1, storeIdStr];
        
        NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
        NSString * oauth_token =[temp objectForKey:@"oauth_token"];
        
        
        if(oauth_token==NULL || [oauth_token isEqual:@""])
        {
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
                     
                     
//                     [HUD hide:YES];
                     
                     
                     NSMutableDictionary *tempDict;
                     
                     
                     tempDict = [[NSMutableDictionary alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
                     
                     [SVProgressHUD dismiss];
                     
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
                         
                         selectedCell.count.text = [NSString stringWithFormat:@"%i", count1];
                         appDele.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
                         bangeLbl.text = appDele.bangeStr;
                         
                         
                         
                         [cartCountDictLocal setObject:selectedCell.count.text forKey:[cartDictLocal  valueForKey:@"entity_id"]];
                         [cartCountModifyDict setObject:[tempDict valueForKey:@"item_id"] forKey:[cartDictLocal  valueForKey:@"entity_id"]];
                         
                         
                         if ([bangeLbl.text integerValue] > 0)
                         {
                             bangeLbl.hidden = NO;
                         }
                         else
                         {
                             bangeLbl.hidden = YES;
                         }
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                         
                         [productListTblVew reloadData];
                     }
                     else
                     {
                         [productListTblVew reloadData];
                         [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                         [SVProgressHUD dismiss];
                     }
                     
                 }
                 
                 selectedCell.addCartBtnObj.userInteractionEnabled = YES;
             }];
        }
        else
        {
            
            [SVProgressHUD show];
            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", URL , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
            NSDictionary *tempDict = [Webmethods updateItemFromCart:cartIdStr];
            
            [SVProgressHUD dismiss];
            
//            [HUD hide:YES];
            
            if ([[tempDict valueForKey:@"status"] integerValue] == 1)
            {
                
                selectedCell.count.text = [NSString stringWithFormat:@"%i", count1];
                
                [cartCountDictLocal setObject:selectedCell.count.text forKey:[cartDictLocal  valueForKey:@"entity_id"]];
                [cartCountModifyDict setObject:[tempDict valueForKey:@"item_id"] forKey:[cartDictLocal  valueForKey:@"entity_id"]];
                
                
                appDele.bangeStr = [NSString stringWithFormat:@"%ld", (long)[[tempDict valueForKey:@"cart_count"] integerValue]];
                bangeLbl.text = appDele.bangeStr;
                
                
                
                
                //                NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:rowSeletcedIs inSection:0];
                //                NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
                //                [itemDetailsTblVew reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationNone];
                
                
                [productListTblVew reloadData];
                selectedCell.addCartBtnObj.userInteractionEnabled = YES;
                
                if ([bangeLbl.text integerValue] > 0)
                {
                    bangeLbl.hidden = NO;
                }
                else
                {
                    bangeLbl.hidden = YES;
                }
                [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
            }
            else
            {
                [productListTblVew reloadData];
                [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                
            }
            
            
            
        }
        
    }
    
}

-(void)threadStartAnimating2
{
    [SVProgressHUD show];
}

- (IBAction)productDetailsBtnAct:(UIButton *)sender
{
    
//    itemId(entityId),item_price,item_offer,item_name,isOffer,Attribute_id,Pid,Valueindex
    
    
    /***
     itemClickEvent Event Satrt
     ***/
    NSMutableDictionary *itmeClickDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          [[productArr objectAtIndex:sender.tag] valueForKey:@"entity_id"], kItemIdProperty,
                                          [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], kCartIdProperty,
                                          [[productArr  objectAtIndex:sender.tag] valueForKey:@"item_name"], kItemNameProperty,
                                          [[productArr  objectAtIndex:sender.tag] valueForKey:@"attribute_id"], kAttributeIdProperty,
                                          [[productArr  objectAtIndex:sender.tag] valueForKey:@"pid"], kPIDProperty,
                                          sender.tag, kValueIndexProperty,
                                          nil];
    [SH_TrackingUtility trackEventOfSpencerEvents:itemClickEvent eventProp:itmeClickDict];
    /***
     itemClickEvent Event End
     ***/
    
    ProductCell *selectedCell = (ProductCell *)[productListTblVew cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    //    count1 = (int)[selectedCell.count.text integerValue];
    
    ProductDetailPage *productDetailPage= [[ProductDetailPage alloc] initWithNibName:@"ProductDetailPage" bundle:nil];
    productDetailPage.pushedFlag = 1;
    productDetailPage.entity_id = [[productArr objectAtIndex:sender.tag] valueForKey:@"entity_id"];
    productDetailPage.inCartStr = selectedCell.count.text;
    [self.navigationController pushViewController:productDetailPage animated:NO];
}
    - (void) dealloc {
        // view did load
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:@"FilterSortDataUpdated"
                                                      object:nil];
        
    }
    -(void) callGetproductsAPI
    {
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
        
        
        
        [currentLocationBtnObj setTitle:productHeader forState:UIControlStateNormal];
        
        //    for (id view in [_scrollMenu subviews])
        //    {
        //        [view removeAllObjects];
        //    }
        
        [SVProgressHUD show];
        brandId = [[NSUserDefaults standardUserDefaults] valueForKey:@"brandId"];
        quantityId = [[NSUserDefaults standardUserDefaults] valueForKey:@"quantityId"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            //            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortStr];
            
            
            
            {
                NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
                NSString *oauth_token = [temp objectForKey:@"oauth_token"];
                
                NSString *cartIdStr;
                if ([quantityId length] > 1 && [brandId length] > 1)
                {
                    cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@&quantity=%@&brand=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString, quantityId, brandId];
                }
                else if ([quantityId length] > 1)
                {
                    cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@&quantity=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString, quantityId];
                }
                else if ([brandId length] > 1)
                {
                    cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@&brand=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString, brandId];
                }
                else
                {
                    cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortString];
                }
                //            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@&quantity=%@&brand=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortStr, quantityId, brandId];
                //            NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&dir=%@&sort=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], descString, sortStr];
                //            NSLog(@"cartIdStr %@", cartIdStr);
                
                if(oauth_token==NULL || [oauth_token isEqual:@""])
                {
                    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:cartIdStr]];
                    [NSURLConnection sendAsynchronousRequest:request
                                                       queue:[NSOperationQueue mainQueue]
                                           completionHandler:^(NSURLResponse *response,
                                                               NSData *data, NSError *connectionError)
                     {
                         if (data.length > 0 && connectionError == nil)
                         {
                             
                             NSDictionary *tempDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                             
                             if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                             {
                                 appDele.filterDict = [tempDict valueForKey:@"filters"];
                                 
                                 appDele.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                                 bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                                 
                                 
                                 if ([bangeLbl.text integerValue] > 0)
                                 {
                                     bangeLbl.hidden = NO;
                                 }
                                 else
                                 {
                                     bangeLbl.hidden = YES;
                                 }
                                 
                                 
                                 productArr = [tempDict valueForKey:@"data"];
                                 
                                 for (NSDictionary *cartDict in productArr)
                                 {
                                     //                                 [cartCountDictLocal setObject:[cartDict valueForKey:@"in_cart"] forKey:[cartDict valueForKey:@"entity_id"]];
                                     //                                 [cartCountModifyDict setObject:[cartDict valueForKey:@"cart_itemid"] forKey:[cartDict valueForKey:@"cart_itemid"]];
                                     
                                     [cartCountDictLocal setObject:[cartDict valueForKey:@"in_cart"] forKey:[cartDict valueForKey:@"entity_id"]];
                                     [cartCountModifyDict setObject:[cartDict valueForKey:@"cart_itemid"] forKey:[cartDict  valueForKey:@"entity_id"]];
                                 }
                                 
                                 pageNumber = (int)[[tempDict valueForKey:@"loadmore"] integerValue];
                                 [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                                 [[NSUserDefaults standardUserDefaults] synchronize];
                                 
                                 [productListTblVew reloadData];
                                 
                                 //                             pagenumber,itemsCount,category_id
                             }
                             else
                             {
                                 [self performSelector:@selector(popVC) withObject:nil afterDelay:1];
                                 [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                             }
                             [SVProgressHUD dismiss];
                         }
                         else
                         {
                             [SVProgressHUD dismiss];
                             //[self.view addSubview:[[ToastAlert alloc] initWithText:@"No Network Found"]];
                             //                         [HUD hide:YES];
                         }
                     }];
                }
                else
                {
                    //                if ([quantityId length] > 1 && [brandId length] > 1)
                    //                {
                    //                    cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&sort=%@&dir=%@&quantity=%@&brand=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], sortString, descString, quantityId, brandId];
                    //                }
                    //                else
                    //                {
                    //                    cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&sort=%@&dir=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], sortString, descString];
                    //                }
                    
                    //                NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&sort=%@&dir=%@&quantity=%@&brand=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], sortStr, descString, quantityId, brandId];
                    
                    //                NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@&sort=%@&dir=%@", categoryUrl , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"], sortStr, descString];
                    
                    
                    NSDictionary *tempDict = [Webmethods product:cartIdStr];
                    //                [HUD hide:YES];
                    //NSLog(@"tempDict %@", tempDict);
                    
                    
                    // NSLog(@"globalcartid %@", cartIdStr);
                    
                   
                    
                    if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                    {
                        appDele.filterDict = [tempDict valueForKey:@"filters"];
                        
                        productArr = [tempDict valueForKey:@"data"];
                        
                        appDele.bangeStr = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                        bangeLbl.text = [NSString stringWithFormat:@"%@", [tempDict valueForKey:@"cart_count"]];
                        
                        if ([bangeLbl.text integerValue] > 0)
                        {
                            bangeLbl.hidden = NO;
                        }
                        else
                        {
                            bangeLbl.hidden = YES;
                        }
                        
                        for (NSDictionary *cartDict in productArr)
                        {
                            //                        [cartCountDictLocal setObject:[cartDict valueForKey:@"in_cart"] forKey:[cartDict valueForKey:@"entity_id"]];
                            //                        [cartCountModifyDict setObject:[cartDict valueForKey:@"cart_itemid"] forKey:[cartDict valueForKey:@"cart_itemid"]];
                            
                            [cartCountDictLocal setObject:[cartDict valueForKey:@"in_cart"] forKey:[cartDict valueForKey:@"entity_id"]];
                            [cartCountModifyDict setObject:[cartDict valueForKey:@"cart_itemid"] forKey:[cartDict  valueForKey:@"entity_id"]];
                        }
                        
                        
                        
                        //                    [cartCountDictLocal setObject:selectedCell.numberOfItems.text forKey:[[[[cartDictLocal valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:rowSelected] valueForKey:@"id"]];
                        //
                        //
                        //                    [cartCountModifyDict setObject:[NSString stringWithFormat:@"%@", [currentArray objectForKey:@"item_id"]] forKey:[[[[cartDictLocal valueForKey:@"super_attribute"] valueForKey:@"values"] objectAtIndex:rowSelected] valueForKey:@"id"]];
                        
                        pageNumber = (int)[[tempDict valueForKey:@"loadmore"] integerValue];
                        [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"loadmore"] forKey:@"loadmore"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        //                    [HUD hide:YES];
                        [productListTblVew reloadData];
                    }
                    else
                    {
                        [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                        [self performSelector:@selector(popVC) withObject:nil afterDelay:1];
                        //                    [HUD hide:YES];
                    }
                     [SVProgressHUD dismiss];
                    
                }
                
            }
            
            
            
        });
        
        __weak ProductVC *weakSelf = self;
        
        
        // setup infinite scrolling
        [productListTblVew addInfiniteScrollingWithActionHandler:^{
            [weakSelf insertRowAtBottom];
        }];
    }
    
@end
