//
//  ProfilePage.m
//  MeraGrocer
//
//  Created by Binary Semantics on 6/26/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import "ProfilePage.h"
#import "AppDelegate.h"
#import "ProductVC.h"
#import "Webmethods.h"
#import "SVProgressHUD.h"
#import "LocationController.h"
#import "InCartVC.h"
#import "ManualLocationVC.h"


@interface ProfilePage ()
{
    AppDelegate *appDelegate;
    ProductVC *itemDetailsVC;
}

@end

@implementation ProfilePage
@synthesize headerStr;

@synthesize cartBtnObj, footerImg, logoLargeImg, logoSmallImg, menuBtnObj, myProfileBtnObj, myProfileImg, searchBar, searchBtnObj, bangeLbl;
@synthesize logoLargeBtn;

@synthesize htmlFile;

@synthesize versionLbl, versionStr;



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.screenName = @"Profile Screen";
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.navigationController.navigationBar.hidden = NO;
    
    _dropdown = [[VSDropdown alloc]initWithDelegate:self];
    [_dropdown setAdoptParentTheme:YES];
    [_dropdown setShouldSortItems:YES];
    
    versionLbl.text =  [NSString stringWithFormat:@"  %@", versionStr];
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        versionLbl.font = [UIFont fontWithName:@"calibri" size:12];
    }
    else
    {
        versionLbl.font = [UIFont fontWithName:@"calibri" size:12];
    }
    
    versionLbl.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:132.0/255.0 blue:36.0/255.0 alpha:1];
    
    
    
//    [self.view setBackgroundColor: [appDelegate colorWithHexString:@"f1f1f1"]];
//   NSString *mapstrr=[NSString stringWithFormat:@"%@",_url_Str];
//    
//    HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.navigationController.view addSubview:HUD];
//    
//    HUD.delegate = self;
//    HUD.labelText = @"Loading";
//    
//    [HUD show: YES];
//    
//    //Create a URL object.
//    NSURL *url = [NSURL URLWithString:mapstrr];
//    
//    //URL Requst Object
//    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
//    
//    //Load the request in the UIWebView.
//    [webview loadRequest:requestObj];
    
    
    [self setupView];
    
    if ([_TagUrl isEqualToString:@"Terms"])
    {
        
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO)
        {
            return ;
        }
        [SVProgressHUD show];
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1]];
        [httpClient setParameterEncoding:AFFormURLParameterEncoding];
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                                path:[NSString stringWithFormat:@"%@",htmlFile]
                                                          parameters:nil];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             // NSError *jsonError = nil;
             [webview loadRequest:request];
             //id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
//             [SVProgressHUD dismiss];
         }
         
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                                             NSLog(@"Error: %@", error);
                                             [SVProgressHUD dismiss];
                                         }];
        [operation start];
        
    }
    else
    {
       // NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
       
        
        
        NSString* htmlString3 = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
        NSString *path3 = [[NSBundle mainBundle] bundlePath];
        NSURL *baseUR1L3 = [NSURL fileURLWithPath:path3];
//        webview.scalesPageToFit = YES;
        [webview loadHTMLString:htmlString3 baseURL:baseUR1L3];
        webview.scrollView.bounces = true;

    }
    
    
    
    

    if ([bangeLbl.text integerValue] > 0)
    {
        bangeLbl.hidden = NO;
    }
    else
    {
        bangeLbl.hidden = YES;
    }
    
    searchBar.returnKeyType = UIReturnKeySearch;
    searchBar.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:230/255.0 green:149/255.0 blue:59/255.0 alpha:1]];
//    UIGraphicsBeginImageContext(self.view.frame.size);
//    [[UIImage imageNamed:@"firstBack_img.png"] drawInRect:self.view.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [UIColor colorWithPatternImage:image];
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:230/255.0 green:149/255.0 blue:59/255.0 alpha:1];
    
    [self navigationView];
}

-(void)navigationView
{
    
    
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
    [titleLabelButton setTitle:headerStr forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
//    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleLabelButton;
    
    NSMutableArray *arrRightBarItems = [[NSMutableArray alloc] init];
    
    
    UIButton *btnLib = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLib setImage:[UIImage imageNamed:@"ic_cart.png"] forState:UIControlStateNormal];
    btnLib.frame = CGRectMake(0, 0, 32, 32);
    ////btnLib.showsTouchWhenHighlighted=YES;
    [btnLib addTarget:self action:@selector(inCartBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:btnLib];
    [arrRightBarItems addObject:barButtonItem2];
    
//    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnSetting setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
//    btnSetting.frame = CGRectMake(0, 0, 32, 32);
//    //btnSetting.showsTouchWhenHighlighted=YES;
////    [btnSetting addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
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
    
    [btnLib addSubview:bangeLbl];
    
    if ([bangeLbl.text integerValue] > 0)
    {
        bangeLbl.hidden = NO;
    }
    else
    {
        bangeLbl.hidden = YES;
    }
    
    self.navigationItem.rightBarButtonItems=arrRightBarItems;
}


- (IBAction)currentLocationBtnAct:(UIButton *)sender
{
    ManualLocationVC*  manualLocationVC = [[ManualLocationVC alloc] initWithNibName:@"ManualLocationVC" bundle:nil];
    manualLocationVC.headercheck=@"1001";
    [self.navigationController pushViewController:manualLocationVC animated:YES];
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
        InCartVC * inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
        [self.navigationController pushViewController:inCartVC animated:YES];
    }
}
- (IBAction)backBtnAct:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:NO];
    
}




- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
-(void) setupView
{
    logoSmallImg.hidden = YES;
    searchBar.hidden = YES;
    logoLargeImg.hidden = NO;
    _searchBg.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        NSDictionary * searchFinalDict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/sb.php?q=%@&storeid=%@&customergroupid=%@&storetimestamp=%@&currencycode=%@&timestamp=%@",solarSearchUrl,urlEncoded, storeId, @"0", @"1466176750", @"INR", @"1466156966987"]]] options:NSJSONReadingMutableContainers error:nil];
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


@end
