//
//  MainCategoryVC.m
//  SpencerKolkata
//
//  Created by binary on 30/06/16.
//  Copyright © 2016 Binary. All rights reserved.
//
//  9873393835

#import "MainCategoryVC.h"
#import "DEMONavigationController.h"
#import "Const.h"
#import "VSDropdown.h"
#import "ToastAlert.h"
#import "SearchVC.h"
#import "IQKeyboardManager.h"
#import "ProductVC.h"
#import "AppDelegate.h"
#import "Webmethods.h"
#import <sys/utsname.h>
#import "ProductListVC.h"
#import "CategoryPage.h"
#import "MyProfileVC.h"
#import "UIButton+WebCache.h"
#import "OfferVC.h"
#import "SH_TrackingUtility.h"


@interface MainCategoryVC ()
{
    SearchVC *searchVC;
    ProductVC *productVC;
    ProductListVC *productListVC;
    CategoryPage*Categoryvc;
    OfferVC *offerVC;
    NSUserDefaults *defaults;
    int isScrolling;
    
    int difference1, difference2;
    int categorySelection;
}
@end

@implementation MainCategoryVC

@synthesize carousel;
@synthesize currentArray;
@synthesize pageControl;


-(void)DrawerMenu_Act:(id)sender
{
    
}


- (void)dealloc
{
    carousel.delegate = nil;
    carousel.dataSource = nil;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return;
    }
//    NSDictionary * srcTempDict = [Webmethods applySRC:@"0"];
//    NSDictionary * tempDict = [Webmethods applyWallet:@"0"];
    
    categorySelection = -10;
    self.screenName = @"Main Category Screen";
    mainMenuScrVew.bounces = NO;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    yOffset = 0.0;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cat_subcat" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    currentArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    bangeLbl.layer.cornerRadius = 9;
    bangeLbl.layer.masksToBounds = YES;
    bangeLbl.layer.borderColor = [UIColor whiteColor].CGColor;
    bangeLbl.layer.borderWidth = 1;
    
    storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    appDele =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    bangeLbl.text = appDele.bangeStr;
    
    [[IQKeyboardManager sharedManager] setEnable:FALSE];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:FALSE];
    
    //    searchBar.barTintColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1];
    
    
    
    listImageArray = [[NSMutableArray alloc] initWithObjects:@"ic_fruits&veg.png", @"ic_grocery.png", @"ic_meat.png", @"ic_beverages.png", @"ic_brandedfood.png", @"ic_bread-dairy.png", @"ic_personalcare.png", @"ic_household.png", @"ic_imp & gourmet.png", nil];
    listNameArray = [[NSMutableArray alloc] initWithObjects:@"Fruit & Vegetables", @"Grocery & Staples", @"Non-Veg", @"Beverages", @"Branded Foods", @"Bread Dairy & Eggs", @"Personal Care", @"Household", @"Imported and Gourmet", nil];
    
    listNameArray = [[NSMutableArray alloc] initWithArray:[[currentArray valueForKey:@"data"] valueForKey:@"categories"]];
    NSLog(@"listNameArray: %@", listNameArray);
    
    //configure carousel
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    screenX = [UIScreen mainScreen].bounds.origin.x;
    screenY =[UIScreen mainScreen].bounds.origin.y;
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"HeaderNav.png"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    headerNavImage.backgroundColor = [UIColor colorWithPatternImage:image];
    
     defaults=[NSUserDefaults standardUserDefaults];
    ImagesArray=[[NSMutableArray alloc]init];
    
    carousel.type = iCarouselTypeCoverFlow2;
    //    carousel.delegate = self;
    //    carousel.dataSource = self;
    self.wrap = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(PushCallSetUp) name:@"ScrollPageNotification" object:nil];
    
    
    
    self.navigationController.navigationBar.tintColor = [UIColor brownColor];
    //    UIButton *backBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    //    UIImage *backBtnImage = [UIImage imageNamed:@"menu-icon.png"];
    //    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    //    [backBtn addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    //    backBtn.frame = CGRectMake(0, 0, 40, 50);
    //    [headerNavImage addSubview:backBtn];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    mainMenuScrVew.contentInset = UIEdgeInsetsZero;
    mainMenuScrVew.scrollIndicatorInsets = UIEdgeInsetsZero;
    mainMenuScrVew.contentOffset = CGPointMake(0.0, 0.0);
    
//    NSArray *colorArray = [[NSArray alloc] initWithObjects:[UIColor greenColor], [UIColor grayColor], [UIColor purpleColor], [UIColor lightTextColor], [UIColor blueColor], [UIColor greenColor], [UIColor grayColor], [UIColor purpleColor], [UIColor lightTextColor], [UIColor blueColor], nil];
    [self performSelectorInBackground:@selector(getCartWishlist) withObject:nil];
    
    carousel.pagingEnabled = YES;
    
    @try {
//        NSMutableArray *resultArray = [NSMutableArray arrayWithArray:[defaults objectForKey:@"ImageArray"]];
//        if (resultArray != nil && resultArray.count > 0) {
//            ImagesArray = resultArray;
//            carousel.delegate = self;
//            carousel.dataSource = self;
        
            [self showCrosel];
//            pageControl.numberOfPages = ImagesArray.count;
//            pageControl.currentPage = 0;
//            pageControl = [[UIPageControl alloc] init];
//            pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
//            pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
//            pageControl.transform = CGAffineTransformMakeScale(0.7, 0.7);
//            pageControl.numberOfPages = ImagesArray.count;
//            pageControl.currentPage = 0;
//            [mainMenuScrVew addSubview:pageControl];
//            browse_lbl.hidden=NO;
//            line_lbl.hidden=NO;
//            
        
    } @catch (NSException *exception) {
        
    }

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 10)
    {
//        if (buttonIndex)
//        {
//            exit(0);
//        }
//        exit(0);
        
        if (buttonIndex == 1)
        {
            
//            NSString *iTunesLink = @"itms://itunes.apple.com/app/id1156464267?mt=8";
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
            
            NSString * appId = @"1156464267";
            NSString * theUrl = [NSString  stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software",appId];
            if ([[UIDevice currentDevice].systemVersion integerValue] > 6) theUrl = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",appId];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:theUrl]];
        }
        
        [SVProgressHUD dismiss];
    }
    else if (alertView.tag == 11)
    {
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
        [SVProgressHUD dismiss];
        
        LoginVC* loginpage;
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC" bundle:nil];
//        }
//        else
//        {
//            loginpage = [[LoginVC alloc]initWithNibName:@"LoginVC~iPad" bundle:nil];
//        }
        loginpage.CheckProfileStatus=@"002";
        loginpage.sessionExpireStr = @"session";
        sessionExpireStr = @"session";
        
        [self.navigationController pushViewController:loginpage animated:NO];
    }
    
    
    
    
    
    
//    if (buttonIndex)
//    {
//        exit(0);
//    }
//    exit(0);
    
}

-(void)navigationView
{
    UIButton *backBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0.0f, -30.0f, 0.0f, 0.0f);
    UIImage *backBtnImage = [UIImage imageNamed:@"menu.png"];
    //    [backBtn setBackgroundColor:[UIColor redColor]];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:(DEMONavigationController *)self.navigationController action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(5, 0, 25, 25);
    UIBarButtonItem *menubutton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:menubutton , nil]];
    self.navigationItem.leftBarButtonItem = menubutton;
    
    UIButton *titleLabelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    [titleLabelButton setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"userLocation"] forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
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
    bangeLbl.text =appDele.bangeStr;
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
    
    
    //    UIButton *btnRefresh = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btnRefresh setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
    //    btnRefresh.frame = CGRectMake(0, 0, 32, 32);
    //    btnRefresh.showsTouchWhenHighlighted=YES;
    //    [btnRefresh addTarget:self action:@selector(onRefreshBtn:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:btnRefresh];
    //
    //    [arrRightBarItems addObject:barButtonItem1];
    
    self.navigationItem.rightBarButtonItems=arrRightBarItems;
    
    
    //    UIView* buttonsView= [[UIView alloc] initWithFrame:CGRectMake(30, 0, 90, 32)];
    //    buttonsView.backgroundColor=[UIColor redColor];
    //
    //    UIButton * arrow = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [arrow  addTarget:self  action:@selector(currentLocationBtnAct:)  forControlEvents:UIControlEventTouchUpInside ];
    //    arrow.backgroundColor = [UIColor redColor];
    //    arrow.frame = CGRectMake( 0, 10, 20, 10 );
    //    [arrow setImage:[UIImage imageNamed:@"ic_arw_down.png"] forState:UIControlStateNormal];
    //
    //
    //
    //
    //
    //    UIImage * cartimage=[UIImage imageNamed:@"ic_cart.png"];
    //    CGRect rect = CGRectMake(0,0,40,30);
    //    UIGraphicsBeginImageContext( rect.size );
    //    [cartimage drawInRect:rect];
    //    UIImage *picture1 = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //
    //    NSData *imageData = UIImagePNGRepresentation(picture1);
    //    UIImage *img=[UIImage imageWithData:imageData];
    //
    //
    //
    //    UIButton * CartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [CartButton  addTarget:self  action:@selector(inCartBtnAct:)  forControlEvents:UIControlEventTouchUpInside ];
    //    CartButton.frame = CGRectMake( 60,0, 40,30);
    //    [CartButton setBackgroundImage:img forState:UIControlStateNormal];
    //    CartButton.enabled=YES;
    //
    //    [buttonsView addSubview:arrow];
    //    [buttonsView addSubview:CartButton];
    
    // UIBarButtonItem *faceBtn = [[UIBarButtonItem alloc] initWithCustomView:buttonsView];
    
    
    //[self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:faceBtn , nil]];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"quantityId"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sortingBy"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"brandIdSearchArr"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"quantityIdSearchArr"];
    
    
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
    
    bangeLbl.hidden = YES;
    
    [self navigationView];
    
    [currentLocationBtnObj setTitle:[[NSUserDefaults standardUserDefaults] valueForKey:@"userLocation"] forState:UIControlStateNormal];
    
    bangeLbl.text = appDele.bangeStr;
    [searchBar1 resignFirstResponder];
    self.navigationController.navigationBar.hidden = NO;
    
    if ([sessionExpireStr isEqualToString:@"session"])
    {
        [self getCartWishlist];
        sessionExpireStr = @"";
    }
    
//    [self showCrosel];
    if (categorySelection == 9)
    {
        
    }
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    appDele =  (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    if (appDele.Scrollcheck==YES)
    {
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        
        RotateView.transform = CGAffineTransformMakeRotation(M_PI);
        [RotateView.layer addAnimation:rotation forKey:@"rotatationRandom"];
        rotation.duration = 1.0f;
        rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        rotation.fillMode = kCAFillModeForwards;
        rotation.removedOnCompletion = YES;
        [mainMenuScrVew setContentOffset:CGPointZero animated:YES];
        appDele.Scrollcheck=NO;
        rotateCheck=NO;
        
    }
    else
    {
        rotateCheck=NO;
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        
        RotateView.transform = CGAffineTransformMakeRotation(M_PI);
        [RotateView.layer addAnimation:rotation forKey:@"rotatationRandom"];
        rotation.duration = 1.0f;
        rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        rotation.fillMode = kCAFillModeForwards;
        rotation.removedOnCompletion = NO;
        
    }
    
    
   
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    appDele.Scrollcheck=YES;
}


- (IBAction)backBtnAct:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)PushCallSetUp
{
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    pageControl.currentPage = appDele.indexNumberIs;
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //generate 100 buttons
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    return [ImagesArray count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIButton *button = (UIButton *)view;
    if (button == nil)
    {
        //no button available to recycle, so create new one
        UIImage *image = [UIImage imageNamed:[ImagesArray objectAtIndex:index]];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20.0f, 0.0f, width-40, width/2-20);
        
        
        if (height == 1024 || height == 2048)
        {
            pageControl.frame = CGRectMake(width/2-100, 285, 200,10);
            browse_lbl.frame=CGRectMake(screenX+8,300, width-16, 21);
            line_lbl.frame=CGRectMake(screenX+8, browse_lbl.frame.origin.y+browse_lbl.frame.size.height+10, browse_lbl.frame.size.width-16, 2);
        }
        else
        {
            pageControl.frame = CGRectMake(width/2-100, 200, 200,10);
//            browse_lbl.frame=CGRectMake(screenX+8,10, width-16, 21);
//            line_lbl.frame=CGRectMake(screenX+8, browse_lbl.frame.origin.y+browse_lbl.frame.size.height+10, browse_lbl.frame.size.width-16, 2);
        }
        
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        
        
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:[ImagesArray objectAtIndex:index]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
        
        //        [button sd_setImageWithURL:[NSURL URLWithString:[[productArr objectAtIndex:indexPath.row] valueForKey:@"image_url"]] placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]]
        
        
        //        button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //set button label
    //    [button setTitle:[NSString stringWithFormat:@"%li", (long)index] forState:UIControlStateNormal];
    
    return button;
}
- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return [ImagesArray count];
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIButton *button = (UIButton *)view;
    if (button == nil)
    {
        //no button available to recycle, so create new one
        UIImage *image = [UIImage imageNamed:[ImagesArray objectAtIndex:index]];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(20.0f, 0.0f, width-40, 200);
        
        pageControl.frame = CGRectMake(width/2-100, button.frame.origin.y+button.frame.size.height+30, 200,10);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //set button label
    [button setTitle:[NSString stringWithFormat:@"%i", (int)index] forState:UIControlStateNormal];
    
    return button;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carousel.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return self.wrap;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

#pragma mark -
#pragma mark iCarousel taps

//- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
//{
//    NSNumber *item = (self.items)[(NSUInteger)index];
//    NSLog(@"Tapped view number: %@", item);
//}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
//    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
//    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
//    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
//    NSLog(@"Index: %@", @(self.carousel.currentItemIndex));
    
}

#pragma mark -
#pragma mark Button tap event

- (void)buttonTapped:(UIButton *)sender
{
    //get item index for button
    NSInteger index = [carousel indexOfItemViewOrSubview:sender];
    
    //    [[[UIAlertView alloc] initWithTitle:@"Button Tapped"
    //                                message:[NSString stringWithFormat:@"You tapped button number %li", (long)index]
    //                               delegate:nil
    //                      cancelButtonTitle:@"OK"
    //                      otherButtonTitles:nil] show];
}

-(void)getTag:(UIButton *)sender
{
    
    BOOL reach = [Webmethods checkNetwork];
    if (reach == NO) {
        return ;
    }
    
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    appDele.categoryId = [[[listNameArray objectAtIndex:imageView.tag] valueForKey:@"category_id"] integerValue];
    
//    imageView.image = [UIImage imageNamed:@"ic_offers_hover.png"];
    categorySelection = (int)imageView.tag;
    storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    
    pageNumber = 1;
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/category/products/%@?page=%i&store=%@", baseUrl1, [[listNameArray objectAtIndex:imageView.tag] valueForKey:@"category_id"], pageNumber, storeIdStr];
    
    
//    if ([[[listNameArray objectAtIndex:imageView.tag] valueForKey:@"category_id"] integerValue] != 295)
//    {
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            productVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//        }
//        else
//        {
//            productVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//        }
        productVC.productHeader = [[listNameArray objectAtIndex:imageView.tag] valueForKey:@"name"];
        productVC.categoryUrl = urlStr;
        [self.navigationController pushViewController:productVC animated:YES];
    
//    }
//    else
//    {
//        offerVC = [[OfferVC alloc] initWithNibName:@"OfferVC" bundle:nil];
//        [self.navigationController pushViewController:offerVC animated:YES];
//    }
//    [self performSelector:@selector(pushVC) withObject:nil afterDelay:1];
    
    
    /***
     Offer_Page_Click Event Start
     ***/
    
    NSMutableDictionary *isOfferDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                                  @true, kIsOfferPushKey,
                                                  nil];
    
    [SH_TrackingUtility trackEventOfSpencerEvents:offerPageClickEvent eventProp:isOfferDict];
    
    /***
     Offer_Page_Click Event End
     ***/
}

-(void)pushVC
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat contentOffSet = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height;
    
    difference1 = contentHeight - contentOffSet;
    
    if (difference1 > difference2) {
//        NSLog(@"Up");
        rotateCheck = YES;
    }else{
//        NSLog(@"Down");
        rotateCheck = NO;
    }
    
    difference2 = contentHeight - contentOffSet;
    
    
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (rotateCheck==NO)
    {
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        
        RotateView.transform = CGAffineTransformMakeRotation(M_PI - 3.14159);
        [RotateView.layer addAnimation:rotation forKey:@"rotatationRandom"];
        rotation.duration = 1.0f;
        rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        rotation.fillMode = kCAFillModeForwards;
        rotation.removedOnCompletion = YES;
//        rotateCheck=YES;
        
        CGPoint bottomOffset = CGPointMake(0, mainMenuScrVew.contentSize.height - mainMenuScrVew.bounds.size.height);
        [mainMenuScrVew setContentOffset:bottomOffset animated:YES];
        
    }
    else
    {
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        
        RotateView.transform = CGAffineTransformMakeRotation(M_PI);
        [RotateView.layer addAnimation:rotation forKey:@"rotatationRandom"];
        rotation.duration = 1.0f;
        rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        rotation.fillMode = kCAFillModeForwards;
        rotation.removedOnCompletion = YES;
        [mainMenuScrVew setContentOffset:CGPointZero animated:YES];
//        rotateCheck=NO;
    }
    
}



- (IBAction)scrollTopBtnAct:(UIButton *)sender
{
    
    if (rotateCheck==NO)
    {
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        
        RotateView.transform = CGAffineTransformMakeRotation(M_PI - 3.14159);
        [RotateView.layer addAnimation:rotation forKey:@"rotatationRandom"];
        rotation.duration = 1.0f;
        rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        rotation.fillMode = kCAFillModeForwards;
        rotation.removedOnCompletion = YES;
        rotateCheck=YES;
        
        CGPoint bottomOffset = CGPointMake(0, mainMenuScrVew.contentSize.height - mainMenuScrVew.bounds.size.height);
        [mainMenuScrVew setContentOffset:bottomOffset animated:YES];
        
    }
    else
    {
        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        
        RotateView.transform = CGAffineTransformMakeRotation(M_PI);
        [RotateView.layer addAnimation:rotation forKey:@"rotatationRandom"];
        rotation.duration = 1.0f;
        rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        rotation.fillMode = kCAFillModeForwards;
        rotation.removedOnCompletion = YES;
        [mainMenuScrVew setContentOffset:CGPointZero animated:YES];
        rotateCheck=NO;
    }
    
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

- (IBAction)footerBtnAct:(UIButton *)sender {
    switch (sender.tag)
    {
        case 11:
            
            break;
        case 12:
        {
            BOOL reach = [Webmethods checkNetwork];
            if (reach == NO) {
                return ;
            }
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
            
            BOOL reach = [Webmethods checkNetwork];
            if (reach == NO) {
                return ;
            }
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
//                offerVC= [[OfferVC alloc]initWithNibName:@"OfferVC" bundle:nil];
//                [self.navigationController pushViewController:offerVC animated:YES];
//            }
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

- (IBAction)currentLocationBtnAct:(UIButton *)sender
{
    manualLocationVC = [[ManualLocationVC alloc] initWithNibName:@"ManualLocationVC" bundle:nil];
    manualLocationVC.headercheck=@"1001";
    [self.navigationController pushViewController:manualLocationVC animated:YES];
}


#pragma mark StartupService

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
        
        //        NSString *cartIdStr = [NSString stringWithFormat:@"%@&cartid=%@", urlStr , [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        
        //        /startups?store=%@&ostype=
        //        [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"] integerValue] > 0)
        {
            urlStr1 = [NSString stringWithFormat:@"%@/startups?deviceid=%@&regid=%@&store=%@&ostype=%@&deviceversion=%@&mobmodel=%@&version=%@&cartid=%@", baseUrl1, currentDeviceId, [[NSUserDefaults standardUserDefaults] valueForKey:@"devicetoken"] , [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"], @"iOS", [[UIDevice currentDevice] systemVersion], str, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        }
        else
        {
            urlStr1 = [NSString stringWithFormat:@"%@/startups?deviceid=%@&regid=%@&store=%@&ostype=%@&deviceversion=%@&mobmodel=%@&version=%@", baseUrl1, currentDeviceId, [[NSUserDefaults standardUserDefaults] valueForKey:@"devicetoken"] , [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"], @"iOS", [[UIDevice currentDevice] systemVersion], str, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        }
        
    }
    else
    {
        if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"] integerValue] > 0)
        {
            urlStr1 = [NSString stringWithFormat:@"%@/startups?store=%@&ostype=%@&deviceversion=%@&mobmodel=%@&version=%@&cartid=%@",  baseUrl1, [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"], @"iOS", [[UIDevice currentDevice] systemVersion], str, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]];
        }
        else
        {
            urlStr1 = [NSString stringWithFormat:@"%@/startups?store=%@&ostype=%@&deviceversion=%@&mobmodel=%@&version=%@",  baseUrl1, [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"], @"iOS", [[UIDevice currentDevice] systemVersion], str, [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        }
        
        //        url = urlStr1;
    }

    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        
        NSURL *url = [NSURL URLWithString:urlStr1];
        
        
        
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO)
        {
            return ;
        }
        [SVProgressHUD show];
        
//        
//        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1]];
//        [httpClient setParameterEncoding:AFFormURLParameterEncoding];
//        NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
//                                                                path:urlStr1
//                                                          parameters:nil];
//        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//        [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
//        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
//         {
//             NSError *jsonError = nil;
//             [SVProgressHUD dismiss];
//             
//             
//             id tempDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
//             
//             if ([[tempDict valueForKey:@"status"] integerValue] == 1)
//             {
//                 
//                 
//                 
//                 ImagesArray = [[NSMutableArray alloc] init];
//                 NSArray *checkCountArr = [tempDict valueForKey:@"slideshow"];
//                 if ([checkCountArr count] > 0)
//                 {
//                     NSArray *bannerImg = [[tempDict valueForKey:@"slideshow"] allKeys];
//                     for (int i = 0; i < [bannerImg count] ; i++)
//                     {
//                         [ImagesArray addObject:[[tempDict valueForKey:@"slideshow"] valueForKey:[bannerImg objectAtIndex:i]]];
//                     }
//                     
//                     carousel.delegate = self;
//                     carousel.dataSource = self;
//                 }
//                 if (ImagesArray.count>0)
//                 {
//                     [self showCrosel];
//                     pageControl.numberOfPages = ImagesArray.count;
//                     pageControl.currentPage = 0;
//                     pageControl = [[UIPageControl alloc] init];
//                     pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
//                     pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
//                     pageControl.transform = CGAffineTransformMakeScale(0.7, 0.7);
//                     pageControl.numberOfPages = ImagesArray.count;
//                     pageControl.currentPage = 0;
//                     [mainMenuScrVew addSubview:pageControl];
//                 }
//                 else
//                 {
//                     [self dissableCrosel];
//                     
//                     browse_lbl.frame=CGRectMake(screenX+8,10, width-16, 21);
//                     line_lbl.frame=CGRectMake(screenX+8, browse_lbl.frame.origin.y+browse_lbl.frame.size.height+10, browse_lbl.frame.size.width-16, 2);
//                     
//                 }
//                 
//                 browse_lbl.hidden=NO;
//                 line_lbl.hidden=NO;
//                 if ([[tempDict valueForKey:@"cartid"] isKindOfClass:[NSNull class]])
//                 {
//                     [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"globalcartid"];
//                     appDele.bangeStr = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
//                     bangeLbl.text = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
//                     if ([bangeLbl.text integerValue] > 0)
//                     {
//                         bangeLbl.hidden = NO;
//                     }
//                     else
//                     {
//                         bangeLbl.hidden = YES;
//                     }
//                     return ;
//                 }
//                 else{
//                     [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"cartid"] forKey:@"globalcartid"];
//                     
//                     appDele.bangeStr = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
//                     bangeLbl.text = [NSString stringWithFormat:@"%@",[tempDict valueForKey:@"cart_count"]];
//                     if ([bangeLbl.text integerValue] > 0)
//                     {
//                         bangeLbl.hidden = NO;
//                     }
//                     else
//                     {
//                         bangeLbl.hidden = YES;
//                     }
//                 }
//                 
//                 
//                 
//             }
//             else if ([[tempDict valueForKey:@"message"] isKindOfClass:[NSString class]])
//             {
//                 if ([[tempDict valueForKey:@"message"] length] > 0 )
//                 {
//                      [[UIAlertView alloc] initWithTitle:@"spencer's" message:[tempDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] ;
//                 }
//             }
//             
//             else
//             {
//                 //                      [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
//                 
//                 [[[UIAlertView alloc] initWithTitle:@"spencer's" message:@"Please use other credentials to login." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
//                 
//             }
//             
//             
//         }
//                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                             NSLog(@"Error: %@", error);
//                                             [SVProgressHUD dismiss];
//                                         }];
//        [operation start];
        
        
        
        
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
//                         NSLog(@"startup response %@", tempDict);
                         [SVProgressHUD dismiss];
                         if ([[tempDict valueForKey:@"status"] integerValue] == 1)
                         {
        
        
        
                             ImagesArray = [[NSMutableArray alloc] init];
                             NSArray *checkCountArr = [tempDict valueForKey:@"slideshow"];
                             if ([checkCountArr count] > 0)
                             {
                                 NSArray *bannerImg = [[tempDict valueForKey:@"slideshow"] allKeys];
                                 for (int i = 0; i < [bannerImg count] ; i++)
                                 {
                                     [ImagesArray addObject:[[tempDict valueForKey:@"slideshow"] valueForKey:[bannerImg objectAtIndex:i]]];
                                 }
        
                                 carousel.delegate = self;
                                 carousel.dataSource = self;
                             }
                             if (ImagesArray.count>0)
                             {
                                 [self showCrosel];
                                 pageControl.numberOfPages = ImagesArray.count;
                                 pageControl.currentPage = 0;
                                 pageControl = [[UIPageControl alloc] init];
                                 pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
                                 pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
                                 pageControl.transform = CGAffineTransformMakeScale(0.7, 0.7);
                                 pageControl.numberOfPages = ImagesArray.count;
                                 pageControl.currentPage = 0;
                                 [mainMenuScrVew addSubview:pageControl];
                                 
                                 [defaults setObject:ImagesArray forKey:@"ImageArray"];
                                 [defaults synchronize];
                             }
                             else
                             {
                                 [self dissableCrosel];
        
                                 if (height == 1024 || height == 2048)
                                 {
                                     browse_lbl.frame=CGRectMake(screenX+8,90, width-16, 21);
                                     line_lbl.frame=CGRectMake(screenX+8, browse_lbl.frame.origin.y+browse_lbl.frame.size.height+10, browse_lbl.frame.size.width-16, 2);
                                 }
                                 else
                                 {
                                     browse_lbl.frame=CGRectMake(screenX+8,10, width-16, 21);
                                     line_lbl.frame=CGRectMake(screenX+8, browse_lbl.frame.origin.y+browse_lbl.frame.size.height+10, browse_lbl.frame.size.width-16, 2);
                                 }
                                 
        
                             }
        
                             browse_lbl.hidden=NO;
                             line_lbl.hidden=NO;
                             if ([[tempDict valueForKey:@"cartid"] isKindOfClass:[NSNull class]])
                             {
                                 [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"globalcartid"];
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
                                 return ;
                             }
                             else{
                                 [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"cartid"] forKey:@"globalcartid"];
        
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
                             }
        
        
        
                         }
                         else if ([[tempDict valueForKey:@"message"] isKindOfClass:[NSString class]])
                         {
                             if ([[tempDict valueForKey:@"message"] length] > 0 )
                             {
                                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"spencer's" message:[tempDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil] ;
                                 alertView.tag = 10;
                                 [alertView show];
                             }
                         }
                         
                         else
                         {
                             //                      [self.view addSubview:[[ToastAlert alloc] initWithText:[tempDict valueForKey:@"message"]]];
                             
                             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"spencer's" message:@"Please use other credentials to login." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] ;
                             alertView.tag = 11;
                             [alertView show];
                             
                         }
                         
                     }
                     else{
                         [SVProgressHUD dismiss];
                     }
                     
                     
                     
                     
                 }];
    }
    else
    {
        
        
        NSDictionary *tempDict = [Webmethods getCartWishlist:urlStr1];
        
        [SVProgressHUD dismiss];
//        NSLog(@"startup response %@", tempDict);
        if ([[tempDict valueForKey:@"status"] integerValue] == 1)
        {
            
            ImagesArray = [[NSMutableArray alloc] init];
            
//            NSArray *bannerImg = [[tempDict valueForKey:@"slideshow"] allKeys];
//            for (int i = 0; i < [bannerImg count] ; i++)
//            {
//                [ImagesArray addObject:[[tempDict valueForKey:@"slideshow"] valueForKey:[bannerImg objectAtIndex:i]]];
//            }
            
            
            NSArray *checkCountArr = [tempDict valueForKey:@"slideshow"];
            if ([checkCountArr count] > 0)
            {
                NSArray *bannerImg = [[tempDict valueForKey:@"slideshow"] allKeys];
                for (int i = 0; i < [bannerImg count] ; i++)
                {
                    [ImagesArray addObject:[[tempDict valueForKey:@"slideshow"] valueForKey:[bannerImg objectAtIndex:i]]];
                }
                
                
                carousel.delegate = self;
                carousel.dataSource = self;
            }
            if (ImagesArray.count>0)
            {
                [self showCrosel];
                pageControl.numberOfPages = ImagesArray.count;
                pageControl.currentPage = 0;
                pageControl = [[UIPageControl alloc] init];
                pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
                pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
                pageControl.transform = CGAffineTransformMakeScale(0.7, 0.7);
                pageControl.numberOfPages = ImagesArray.count;
                pageControl.currentPage = 0;
                [mainMenuScrVew addSubview:pageControl];
                [defaults setObject:ImagesArray forKey:@"ImageArray"];
                [defaults synchronize];
            }
            else
            {
                [self dissableCrosel];
                if (height == 1024 || height == 2048)
                {
                    browse_lbl.frame=CGRectMake(screenX+8,90, width-16, 21);
                    line_lbl.frame=CGRectMake(screenX+8, browse_lbl.frame.origin.y+browse_lbl.frame.size.height+10, browse_lbl.frame.size.width-16, 2);
                }
                else
                {
                    browse_lbl.frame=CGRectMake(screenX+8,10, width-16, 21);
                    line_lbl.frame=CGRectMake(screenX+8, browse_lbl.frame.origin.y+browse_lbl.frame.size.height+10, browse_lbl.frame.size.width-16, 2);
                }
                
            
            }
            
            browse_lbl.hidden=NO;
            line_lbl.hidden=NO;
            if ([[tempDict valueForKey:@"cartid"] isKindOfClass:[NSNull class]])
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"globalcartid"];
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
                return ;
            }
            else
            {
                [[NSUserDefaults standardUserDefaults] setObject:[tempDict valueForKey:@"cartid"] forKey:@"globalcartid"];
                
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
            }
            
            
//            carousel.delegate = self;
//            carousel.dataSource = self;
            
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
        }
        
        else if ([[tempDict valueForKey:@"message"] isKindOfClass:[NSString class]])
        {
            if ([[tempDict valueForKey:@"message"] length] > 0 )
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"spencer's" message:[tempDict valueForKey:@"message"] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil] ;
                alertView.tag = 10;
                [alertView show];
            }
        }
        
        else
        {
            
            UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"spencer's" message:@"Please use other credentials to login." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            alertView.tag = 11;
            [alertView show];
        }
        
    }
    
}
-(void)showCrosel
{
    
//    for (UIView *view in [mainMenuScrVew subviews])
//    {
//        if (view.tag == 100)
//        {
//            
//        }
//        else
//        {
//            [view removeFromSuperview];
//        }
//    }
    
    
    [carousel setHidden:NO];
    for (int i = 0; i <= listNameArray.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        int count = i/2;
        imageView.tag = i;
        
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor = [UIColor darkGrayColor];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        }
        else
        {
            titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
        }
        
        
        titleLabel.textAlignment = NSTextAlignmentLeft;
        if (i == 0)
        {
            //            imageView.frame = CGRectMake(mainMenuScrVew.frame.origin.x+2, self.view.frame.origin.y, mainMenuScrVew.frame.size.width-4, mainMenuScrVew.frame.size.height/3+5);
            //            titleLabel.hidden = YES;
            //            titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width, 20);
        }
        else
        {
            if (height == 480)
            {
                if (i % 2 == 1)
                {
                    
                    
                    imageView.frame = CGRectMake(screenX+width/8, (height/5.5*(count+1))+170, width/4, width/4);
                    titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width, 50);
                }
                else
                {
                    imageView.frame = CGRectMake(width/2+width/8, (height/5.5*(count))+170, width/4, width/4);
                    titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width-5, 50);
                }
            }
            else if (height == 1024 || height == 2048)
            {
                if (i % 2 == 1)
                {
                    imageView.frame = CGRectMake(screenX+width/8, (height/5.5*(count+1))+130, width/4, width/4);
                    titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width, 50);
                }
                else
                {
                    imageView.frame = CGRectMake(width/2+width/8, (height/5.5*(count))+130, width/4, width/4);
                    titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width-5, 50);
                }
            }
            else
            {
                if (i % 2 == 1)
                {
                    imageView.frame = CGRectMake(screenX+width/8, (height/5.5*(count+1))+150, width/4, width/4);
                    titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width, 50);
                }
                else
                {
                    imageView.frame = CGRectMake(width/2+width/8, (height/5.5*(count))+150, width/4, width/4);
                    titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width-5, 50);
                }
            }
            
        }
        
        if (i == 0)
        {
            //            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getTag:)];
            //            imageView.contentMode=UIViewContentModeScaleToFill;
            //            [imageView setUserInteractionEnabled:YES];
            //            [imageView addGestureRecognizer: singleTap];
        }
        else
        {
            
//            if (categorySelection != i-1)
//            {
                imageView.image = [UIImage imageNamed:[[listNameArray objectAtIndex:i-1] valueForKey:@"thumb_img"]];
//            }
//            else
//            {
//                
//            }
            
            //            imageView.backgroundColor = [UIColor redColor];
            //            titleLabel.backgroundColor = [UIColor greenColor];
            
            titleLabel.text = [NSString stringWithFormat:@"%@", [[listNameArray objectAtIndex:i-1] valueForKey:@"name"]];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.backgroundColor = [UIColor clearColor];
            
            titleLabel.numberOfLines = 2;
            imageView.tag=i-1;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (getTag:)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            [imageView setUserInteractionEnabled:YES];
            [imageView addGestureRecognizer: singleTap];
        }
        if (height == 480)
        {
            [mainMenuScrVew setContentSize:CGSizeMake(width-200, (height/3.4*(listNameArray.count/2+1)) )];
        }
        else
        {
            [mainMenuScrVew setContentSize:CGSizeMake(width-200, (height/4.2*(listNameArray.count/2+1)) )];
        }
        
        [mainMenuScrVew addSubview:imageView];
        [imageView addSubview:titleLabel];
    }

}
-(void)dissableCrosel
{
    [carousel setHidden:YES];
    
    for (int i = 0; i <= listNameArray.count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        int count = i/2;
        imageView.tag = i;
        
        
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textColor = [UIColor darkGrayColor];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:13];
        }
        else
        {
            titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:17];
        }
        
        
        titleLabel.textAlignment = NSTextAlignmentLeft;
        if (i == 0)
        {
            
        }
        else
        {
            if (height == 480)
            {
                if (i % 2 == 1)
                {
                    imageView.frame = CGRectMake(screenX+width/8, (height/5.5*(count+1)-70), width/4, width/4);
                    titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width, 50);
                }
                else
                {
                    imageView.frame = CGRectMake(width/2+width/8, (height/5.5*(count)-70), width/4, width/4);
                    titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width-5, 50);
                }
            }
            else
            {
                if (i % 2 == 1)
                {
                    imageView.frame = CGRectMake(screenX+width/8, (height/5.5*(count+1)-70), width/4, width/4);
                    titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width, 50);
                }
                else
                {
                    imageView.frame = CGRectMake(width/2+width/8, (height/5.5*(count)-70), width/4, width/4);
                    titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width-5, 50);
                }
            }
            
        }
        
        if (i == 0)
        {
            //            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getTag:)];
            //            imageView.contentMode=UIViewContentModeScaleToFill;
            //            [imageView setUserInteractionEnabled:YES];
            //            [imageView addGestureRecognizer: singleTap];
        }
        else
        {
            imageView.image = [UIImage imageNamed:[[listNameArray objectAtIndex:i-1] valueForKey:@"thumb_img"]];
            
            titleLabel.text = [NSString stringWithFormat:@"%@", [[listNameArray objectAtIndex:i-1] valueForKey:@"name"]];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.backgroundColor = [UIColor clearColor];
            
            titleLabel.numberOfLines = 2;
            imageView.tag=i-1;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector (getTag:)];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
            [imageView setUserInteractionEnabled:YES];
            [imageView addGestureRecognizer: singleTap];
        }
        if (height == 480)
        {
            [mainMenuScrVew setContentSize:CGSizeMake(width-20, (height/6.6*(listNameArray.count/2+1)) )];
        }
        else
        {
            [mainMenuScrVew setContentSize:CGSizeMake(width-20, (height/6.1*(listNameArray.count/2+1)) )];
        }
        
        [mainMenuScrVew addSubview:imageView];
        [imageView addSubview:titleLabel];
    }

}
//-(void)scrollViewDidScroll: (UIScrollView *)scrollView
//{
//    if (scrollView.contentOffset.y < yOffset)
//    {
//        
//        // scrolls down.
//        yOffset = scrollView.contentOffset.y;
//        if (yOffset<0)
//        {
//            yOffset=height;
//        }
//        
//        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//        
//        RotateView.transform = CGAffineTransformMakeRotation(M_PI - 3.14159);
//        [RotateView.layer addAnimation:rotation forKey:@"rotatationRandom"];
//        rotation.duration = 0.0f;
//        rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        rotation.fillMode = kCAFillModeForwards;
//        //rotation.removedOnCompletion = NO;
//        rotateCheck=YES;
//        
//        CGPoint bottomOffset = CGPointMake(0, mainMenuScrVew.contentSize.height - mainMenuScrVew.bounds.size.height);
//        [mainMenuScrVew setContentOffset:bottomOffset animated:YES];
//    
//    }
//    
//    else
//    {
//        // scrolls up.
//        yOffset = scrollView.contentOffset.y;
//        
//        CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//        
//        RotateView.transform = CGAffineTransformMakeRotation(M_PI);
//        [RotateView.layer addAnimation:rotation forKey:@"rotatationRandom"];
//        rotation.duration = 0.0f;
//        rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        rotation.fillMode = kCAFillModeForwards;
//        //rotation.removedOnCompletion = NO;
//        [mainMenuScrVew setContentOffset:CGPointZero animated:YES];
//        rotateCheck=NO;
//        // Your Action goes here...
//    }
//    
//    
//}
@end
