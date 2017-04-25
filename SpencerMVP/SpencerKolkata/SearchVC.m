//
//  SearchVC.m
//  Spencer
//
//  Created by binary on 02/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "SearchVC.h"
#import "Const.h"
#import "ToastAlert.h"
#import "AppDelegate.h"
#import "SearchListVC.h"


@interface SearchVC () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *searchResult;
    UILabel *bangeLbl;
    AppDelegate *appDele;
}
@end

@implementation SearchVC


#pragma mark ViewLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.screenName = @"Search Screen";
    
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDele.navigationBool = 10;
    locationImgVew.hidden = YES;
    locationTitLbl.hidden = YES;
    
    storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    
    searchBar1.barTintColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    cancelBtnObj.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    screenX = [UIScreen mainScreen].bounds.origin.x;
    screenY =[UIScreen mainScreen].bounds.origin.y;
    
    headerNavImage.backgroundColor = kColor_gray;
    // Do any additional setup after loading the view from its nib.
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
    
    
    [titleLabelButton setTitle:@"Search" forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    //    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleLabelButton;
    
    NSMutableArray *arrRightBarItems = [[NSMutableArray alloc] init];
    
    
    //    UIButton *btnSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    
//    UIButton *btnLib = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnLib setImage:[UIImage imageNamed:@"ic_cart.png"] forState:UIControlStateNormal];
//    btnLib.frame = CGRectMake(0, 0, 32, 32);
//    ////btnLib.showsTouchWhenHighlighted=YES;
//    [btnLib addTarget:self action:@selector(inCartBtnAct:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:btnLib];
//    [arrRightBarItems addObject:barButtonItem2];
    
    
    //    [btnSetting setImage:[UIImage imageNamed:@"ic_arrow_down.png"] forState:UIControlStateNormal];
    //    btnSetting.frame = CGRectMake(0, 0, 32, 32);
    //    //btnSetting.showsTouchWhenHighlighted=YES;
    //    [btnSetting addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnSetting];
    //    [arrRightBarItems addObject:barButtonItem];
    
//    bangeLbl = [[UILabel alloc] initWithFrame:CGRectMake(20,-5 , 18, 18)];
//    bangeLbl.text = appDele.bangeStr;
//    bangeLbl.font = [UIFont fontWithName:@"Helvetica" size:11];
//    bangeLbl.backgroundColor = [UIColor clearColor];
//    bangeLbl.textColor = [UIColor whiteColor];
//    bangeLbl.textAlignment = NSTextAlignmentCenter;
//    bangeLbl.backgroundColor = kColor_gray;
//    bangeLbl.layer.cornerRadius = 9;
//    bangeLbl.layer.masksToBounds = YES;
//    bangeLbl.layer.borderColor = [UIColor whiteColor].CGColor;
//    bangeLbl.layer.borderWidth = 1;
//    if ([bangeLbl.text integerValue] > 0)
//    {
//        bangeLbl.hidden = NO;
//    }
//    else
//    {
//        bangeLbl.hidden = YES;
//    }
//    [btnLib addSubview:bangeLbl];
    
    self.navigationItem.rightBarButtonItems=arrRightBarItems;
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [self performSelector:@selector(setCorrectFocus) withObject:NULL afterDelay:0.2];
   
    [super viewDidAppear:animated];
    
}
-(void) setCorrectFocus
{
//    [self.searchController setActive:YES];
//    [self.searchController.searchBar becomeFirstResponder];
    [searchBar1 becomeFirstResponder];
}
- (void)didPresentSearchController:(UISearchController *)searchController
{
    [searchController.searchBar becomeFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    shouldBeginEditing = YES;
//    [[UINavigationBar appearance] setBarTintColor:kColor_gray];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationController.navigationBar.barTintColor = kColor_gray;
    
    bangeLbl.hidden = YES;
    
    [searchBar1 becomeFirstResponder];
    [self navigationView];
    
    if (searchResult.count < 1)
    {
        locationImgVew.hidden = NO;
        locationTitLbl.hidden = NO;
        searchTblVew.hidden = YES;
    }
    else
    {
        locationImgVew.hidden = YES;
        locationTitLbl.hidden = YES;
        searchTblVew.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark ButtonAction
- (IBAction)backBtnAct:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)cancelBtnAct:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deleteBtnAct:(UIButton *)sender
{

}


#pragma mark UItableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    UIImageView *seperatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(screenX, 43, width, 1)];
    seperatorImg.backgroundColor = kColor_Orange;
    [cell addSubview:seperatorImg];
    
    cell.textLabel.text = [searchResult objectAtIndex:indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return searchResult.count;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    searchBar1.text = [searchResult objectAtIndex:indexPath.row];
    
    SearchListVC *searchListVC = [[SearchListVC alloc] initWithNibName:@"SearchListVC" bundle:nil];
    searchListVC.searchStr = searchBar1.text;
    searchListVC.sortStr = @"Search";
    [self.navigationController pushViewController:searchListVC animated:YES];
}
-(void)resignFirstResponder22
{
    [searchBar1 resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark SearchBarDelegate
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString * searchStr = [searchBar1.text stringByReplacingCharactersInRange:range withString:text];
//    NSLog(@"%@", searchStr);
    
    NSString *storeId = [[NSUserDefaults standardUserDefaults]valueForKey:@"store_id_token"];
    if (searchStr.length > 2)
    {
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO)
        {
            return nil;
        }
        [SVProgressHUD show];
        
            NSString * finalURL=[NSString stringWithFormat:@"%@/sb.php?q=%@&storeid=%@&customergroupid=%@&storetimestamp=%@&currencycode=%@&timestamp=%@",solarSearchUrl, searchStr, storeId, @"0", @"1466176750", @"INR", @"1466156966987"];
        NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                     NULL,
                                                                                                     (CFStringRef)finalURL,
                                                                                                     NULL,
                                                                                                     (CFStringRef)@"<>",
                                                                                                     kCFStringEncodingUTF8));
        
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1]];
        
        [httpClient setParameterEncoding:AFFormURLParameterEncoding];
        NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET"
                                                                path:urlEncoded
                                                          parameters:nil];
        request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             [SVProgressHUD dismiss];
             NSError *jsonError = nil;
             id searchFinalDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&jsonError];
             if ([searchFinalDict valueForKey:@"keywordsraw"]  != nil)
             {
                 searchResult = [searchFinalDict valueForKey:@"keywordsraw"];
                 
                 if (searchResult.count>0)
                 {
                     [searchTblVew reloadData];
                 }
                 else
                 {
                     [self.view addSubview:[[ToastAlert alloc] initWithText:@"No matching products"]];
                 }
                 
                 
             }
             else
             {
                 [self.view addSubview:[[ToastAlert alloc] initWithText:@"No matching products"]];
             }
             
             if (searchResult.count < 1)
             {
                 locationImgVew.hidden = NO;
                 locationTitLbl.hidden = NO;
                 searchTblVew.hidden = YES;
             }
             else
             {
                 locationImgVew.hidden = YES;
                 locationTitLbl.hidden = YES;
                 searchTblVew.hidden = NO;
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             NSLog(@"Error: %@", error);
             [SVProgressHUD dismiss];
         }];
             [operation start];
        
        
            
           // searchBar1.text = searchStr;
//            [self.view endEditing:YES];
            
            
            
            
//            NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlEncoded]];
//            NSURLResponse * response = nil;
//            NSError * error = nil;
//            NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
//                                                  returningResponse:&response
//                                                              error:&error];
//            
//            NSError *jsonError = nil;
//            NSDictionary * searchFinalDict= [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//            [SVProgressHUD dismiss];
//            //        [searchBar resignFirstResponder];
//            if ([searchFinalDict valueForKey:@"keywordsraw"]  != nil)
//            {
//                searchResult = [searchFinalDict valueForKey:@"keywordsraw"];
//                
//                if (searchResult.count>0)
//                {
//                    [searchTblVew reloadData];
//                }
//                else
//                {
//                    [self.view addSubview:[[ToastAlert alloc] initWithText:@"No matching products"]];
//                }
//                
//                
//            }
//            else
//            {
//                [self.view addSubview:[[ToastAlert alloc] initWithText:@"No matching products"]];
//            }
//            
//            if (searchResult.count < 1)
//            {
//                locationImgVew.hidden = NO;
//                locationTitLbl.hidden = NO;
//                searchTblVew.hidden = YES;
//            }
//            else
//            {
//                locationImgVew.hidden = YES;
//                locationTitLbl.hidden = YES;
//                searchTblVew.hidden = NO;
//            }
//        
//
//
//        });
    }
        return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
//    searchBar1.text = [searchResult objectAtIndex:indexPath.row];
    
    SearchListVC *searchListVC = [[SearchListVC alloc] initWithNibName:@"SearchListVC" bundle:nil];
    searchListVC.searchStr = searchBar1.text;
    searchListVC.sortStr = @"Search";
    [self.navigationController pushViewController:searchListVC animated:YES];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
//    NSLog(@"Cancel clicked");
    searchBar.text = @"";
    searchTblVew.hidden = YES;
    [searchBar resignFirstResponder];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)bar {
    // reset the shouldBeginEditing BOOL ivar to YES, but first take its value and use it to return it from the method call
    BOOL boolToReturn = shouldBeginEditing;
    shouldBeginEditing = YES;
    return boolToReturn;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    //    [filteredContentList removeAllObjects];
    //
    //    if([searchText length] != 0)
    //    {
    //        [locationTblVew reloadData];
    //    }
    //    else
    //    {
    //
    //        [searchBar resignFirstResponder];
    //        [self.view endEditing:YES];
    //        locationImgVew.hidden = NO;
    //        locationTitLbl.hidden = NO;
    //        locationTblVew.hidden = YES;
    //        [locationTblVew reloadData];
    //
    //    }
    
    if ([searchText length] == 0)
    {
        // The user clicked the [X] button or otherwise cleared the text.
        [self performSelector: @selector(resignFirstResponder1)
                   withObject: nil
                   afterDelay: 0.1];
    }
    else if (![searchBar isFirstResponder]) {
        // The user clicked the [X] button while the keyboard was hidden
        shouldBeginEditing = NO;
    }
    
}
-(void)resignFirstResponder1
{
    [searchBar1 resignFirstResponder];
    [self.view endEditing:YES];
    
    searchTblVew.hidden = YES;
    [searchTblVew reloadData];
    
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
        [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please add product in cart"]];
    }
    else
    {
        inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
        [self.navigationController pushViewController:inCartVC animated:YES];
    }
}


@end
