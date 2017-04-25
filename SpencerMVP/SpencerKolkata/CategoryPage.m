//
//  CategoryPage.m
//  Spencer
//
//  Created by Binary Semantics on 7/6/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "CategoryPage.h"
#import "ManualLocationVC.h"
#import "ProductListVC.h"
#import "SearchVC.h"
#import "MainCategoryVC.h"
#import "MyProfileVC.h"
#import "AppDelegate.h"
#import "OfferVC.h"
#import "ProductVC.h"

@interface CategoryPage ()
{
    ManualLocationVC *manualLocationVC;
    ProductListVC *productListVC;
    SearchVC *searchVC;
    AppDelegate *appDele;
    
    CategoryPage *Categoryvc;
    OfferVC *offerVC;
    ProductVC *productVC;
}
@end

@implementation CategoryPage

@synthesize currentArray;


-(void)navigationView
{
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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
    //btnLib.showsTouchWhenHighlighted=YES;
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
}



- (IBAction)currentLocationBtnAct:(UIButton *)sender
{
    manualLocationVC = [[ManualLocationVC alloc] initWithNibName:@"ManualLocationVC" bundle:nil];
    manualLocationVC.headercheck=@"1001";
    [self.navigationController pushViewController:manualLocationVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    bangeLbl.hidden = YES;
    [searchBar1 resignFirstResponder];
    self.navigationController.navigationBar.hidden = NO;
    [self navigationView];
    self.navigationController.navigationBar.barTintColor = kColor_Orange;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"Category Screen";
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    listImageArray = [[NSMutableArray alloc] initWithObjects:@"ic_fruits&veg.png", @"ic_grocery.png", @"ic_meat.png", @"ic_beverages.png", @"ic_brandedfood.png", @"ic_bread-dairy.png", @"ic_personalcare.png", @"ic_household.png", @"ic_imp & gourmet.png", nil];
    listNameArray = [[NSMutableArray alloc] initWithObjects:@"Fruit & Vegetables", @"Grocery & Staples", @"Non-Veg", @"Beverages", @"Branded Foods", @"Bread Dairy & Eggs", @"Personal Care", @"Household", @"Imported and Gourmet", nil];
    
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cat_subcat" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    currentArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    listNameArray = [[NSMutableArray alloc] initWithArray:[[currentArray valueForKey:@"data"] valueForKey:@"categories"]];
    
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    screenX = [UIScreen mainScreen].bounds.origin.x;
    screenY =[UIScreen mainScreen].bounds.origin.y;
    self.automaticallyAdjustsScrollViewInsets = NO;
    mainMenuScrVew.contentInset = UIEdgeInsetsZero;
    mainMenuScrVew.scrollIndicatorInsets = UIEdgeInsetsZero;
    mainMenuScrVew.contentOffset = CGPointMake(0.0, 0.0);
    self.navigationController.navigationBar.hidden = NO;
    NSArray *colorArray = [[NSArray alloc] initWithObjects:[UIColor greenColor], [UIColor grayColor], [UIColor purpleColor], [UIColor lightTextColor], [UIColor blueColor], [UIColor greenColor], [UIColor grayColor], [UIColor purpleColor], [UIColor lightTextColor], [UIColor blueColor], nil];
    
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
                    imageView.frame = CGRectMake(screenX+width/8, (height/5.5*(count+1)-80), width/4, width/4);
                    titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width, 50);
                }
                else
                {
                    imageView.frame = CGRectMake(width/2+width/8, (height/5.5*(count)-80), width/4, width/4);
                    titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width-5, 50);
                }
            }
            else
            {
                if (i % 2 == 1)
                {
                    imageView.frame = CGRectMake(screenX+width/8, (height/5.5*(count+1)-90), width/4, width/4);
                    titleLabel.frame = CGRectMake(0, imageView.frame.size.height-20, imageView.frame.size.width, 50);
                }
                else
                {
                    imageView.frame = CGRectMake(width/2+width/8, (height/5.5*(count)-90), width/4, width/4);
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
            [mainMenuScrVew setContentSize:CGSizeMake(width-20, (height/5.6*(colorArray.count/2+1)) )];
        }
        else
        {
            [mainMenuScrVew setContentSize:CGSizeMake(width-20, (height/5.6*(colorArray.count/2+1)) )];
        }
        
        [mainMenuScrVew addSubview:imageView];
        [imageView addSubview:titleLabel];
    }
    // Do any additional setup after loading the view from its nib.
}


-(void)getTag:(id)sender
{
    pageNumber = 1;
    UIGestureRecognizer *recognizer = (UIGestureRecognizer*)sender;
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    UILabel *titleLbl = (UILabel *)[[imageView subviews] objectAtIndex:0];
    
    
    //    appDele.categoryId = [[[listNameArray objectAtIndex:imageView.tag] valueForKey:@"category_id"] integerValue];
    
    
    //    NSString *urlStr = [NSString stringWithFormat:@"%@/category/products/%@?page=%i&store=%@", baseUrl1, [[listNameArray objectAtIndex:imageView.tag] valueForKey:@"category_id"], pageNumber, storeIdStr];
    //    productVC.productHeader = [[listNameArray objectAtIndex:imageView.tag] valueForKey:@"name"];
    //    productVC.categoryUrl = urlStr;
    
    
    
    
    NSArray *categoryListArr = [[listNameArray objectAtIndex:imageView.tag] valueForKey:@"Sub_Categories"];
    if ([categoryListArr count] > 0)
    {
        productListVC = [[ProductListVC alloc] initWithNibName:@"ProductListVC" bundle:nil];
        productListVC.productListArray = [[listNameArray objectAtIndex:imageView.tag] valueForKey:@"Sub_Categories"];
        productListVC.headerTitleStr = titleLbl.text;
        productListVC.catId = (int)[[[listNameArray objectAtIndex:imageView.tag] valueForKey:@"category_id"] integerValue];
        [self.navigationController pushViewController:productListVC animated:YES];
    }
    else
    {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"cat_subcat" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary * currentArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSMutableArray *listNameArray = [[NSMutableArray alloc] initWithArray:[[currentArray valueForKey:@"data"] valueForKey:@"categories"]];
        
        NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/category/products/%@?page=%@&store=%@", baseUrl1, [[listNameArray objectAtIndex:9] valueForKey:@"category_id"], @"1", storeIdStr];
//        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//        {
            productVC = [[ProductVC alloc] initWithNibName:@"ProductVC" bundle:nil];
//        }
//        else
//        {
//            productVC = [[ProductVC alloc] initWithNibName:@"ProductVC~iPad" bundle:nil];
//        }
        productVC.productHeader = [[listNameArray objectAtIndex:9] valueForKey:@"name"];
        productVC.categoryUrl = urlStr;
        [self.navigationController pushViewController:productVC animated:YES];
    }
    
}



- (IBAction)backBtnAct:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        InCartVC *inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
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
            temp=[NSUserDefaults standardUserDefaults];
            NSString *oauth_token =[temp objectForKey:@"oauth_token"];
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



@end
