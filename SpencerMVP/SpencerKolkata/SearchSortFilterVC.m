//
//  SearchSortFilterVC.m
//  Spencer
//
//  Created by binary on 25/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "SearchSortFilterVC.h"
#import "AppDelegate.h"
#import "Const.h"
#import "InCartVC.h"
#import "MainCategoryVC.h"
#import "CategoryPage.h"
#import "MyProfileVC.h"
#import "OfferVC.h"
#import "ProductVC.h"

@interface SearchSortFilterVC ()
{
    AppDelegate *appDele;
    int selectedBtn;
    NSDictionary *sortFilterDict;
    NSMutableArray * section1SelectionArr, *section2SelectionArr;
    NSUserDefaults * temp;
    
    int globalTag;
    
    int sortingByIndex;
    
    ProductVC *productVC;
}
@end

@implementation SearchSortFilterVC

@synthesize brandIdArr, quantityIdArr;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    @try {
        
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = kColor_gray;
    [self navigationView];
    
    
    sortingByIndex = (int)[[[NSUserDefaults standardUserDefaults] valueForKey:@"sortingSearchIndex"] integerValue];
    
    [self sortByBtnAct:sortingByIndex];
    
    self.screenName = @"Search Sort Filter Screen";
    
    brandSeletedStr = [[NSMutableString alloc] init];
    quantitySelectedStr = [[NSMutableString alloc] init];
    
    //    section1Selection = -10;
    //    section2Selection = -10;
    
    appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    section1SelectionArr = [[NSMutableArray alloc] init];
    section2SelectionArr = [[NSMutableArray alloc] init];
    
    
    
    
    
    NSArray *brandTempArr = [[NSUserDefaults standardUserDefaults] valueForKey:@"brandIdSearchArr"];
    NSArray *quantityTempArr = [[NSUserDefaults standardUserDefaults] valueForKey:@"quantityIdSearchArr"];
    
    
    if ([brandTempArr count] > 0)
    {
        brandIdArr = [[NSMutableArray alloc] initWithArray:brandTempArr];
    }
    else
    {
        brandIdArr = [[NSMutableArray alloc] init];
    }
    
    if ([quantityTempArr count] > 0)
    {
        quantityIdArr = [[NSMutableArray alloc] initWithArray:quantityTempArr];
    }
    else
    {
        quantityIdArr = [[NSMutableArray alloc] init];
    }
    
    sortFilterDict = appDele.filterSearchDict;
    
    selectedSection = -10;
    
    self.sortFilterTblVew.hidden = YES;
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self"
                                                                ascending: YES];
    
    NSArray* tempHeaderArr = [sortFilterDict allKeys];
    NSMutableArray *filterArr= [[NSMutableArray alloc] init];
    for (int i = 0; i < tempHeaderArr.count; i++)
    {
        if ([[tempHeaderArr objectAtIndex:i] isEqualToString: @"INR_0_price_decimal"] || [[tempHeaderArr objectAtIndex:i] isEqualToString: @"INR_1_price_decimal"])
        {
            
        }
        else
        {
            [filterArr addObject:[tempHeaderArr objectAtIndex:i]];
        }
        //        if ([[tempHeaderArr objectAtIndex:i] isEqualToString:@"INR_0_price_decimal"])
        //        {
        //
        //        }
        //        else
        //        {
        //
        //        }
        
    }
    tempHeaderArr = filterArr;
    
    filterHeaderArr = [tempHeaderArr sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    
    //    [[tempHeaderArr reverseObjectEnumerator] allObjects];
    
    brandNameArr = [sortFilterDict valueForKey:[filterHeaderArr objectAtIndex:0]];
    
    quantityRangeArr = [sortFilterDict valueForKey:[filterHeaderArr objectAtIndex:1]];
    
    NSArray * tempBrandKeyArr = [[sortFilterDict valueForKey:[filterHeaderArr objectAtIndex:0]] allKeys];
    NSArray * tempQuantityKeyArr = [[sortFilterDict valueForKey:[filterHeaderArr objectAtIndex:1]] allKeys];
    
    
    brandKeyArr = [tempBrandKeyArr sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    quantityKeyArr = [tempQuantityKeyArr sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    
    
    section1Dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"2003/07/04",@"Acme Alpha",@"2003/07/04",@"Acme Beta",@"2003/07/04",@"Acme Gama", nil];
    infoDict = [[NSDictionary alloc]initWithObjects:
                [NSArray arrayWithObjects:@"5",@"3",@"1", nil]
                                            forKeys:[NSArray arrayWithObjects:@"Coupler",@"Connector",@"Clasp", nil]];
    
    
    applyBtnObj.hidden = YES;
    applyBtnObj.layer.cornerRadius=19.0;
    applyBtnObj.layer.masksToBounds=YES;
    } @catch (NSException *exception) {
        
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
    
    
    [titleLabelButton setTitle:_productHeader forState:UIControlStateNormal];
    titleLabelButton.frame = CGRectMake(0, 0, 200, 44);
    titleLabelButton.titleLabel.numberOfLines=1;
    [titleLabelButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleLabelButton setTitleColor:[UIColor colorWithRed: 255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    titleLabelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16];
    //    [titleLabelButton addTarget:self action:@selector(currentLocationBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleLabelButton;
    
    NSMutableArray *arrRightBarItems = [[NSMutableArray alloc] init];
    
    //    UIButton *btnLib = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btnLib setImage:[UIImage imageNamed:@"ic_cart.png"] forState:UIControlStateNormal];
    //    btnLib.frame = CGRectMake(0, 0, 32, 32);
    //    ////btnLib.showsTouchWhenHighlighted=YES;
    //    [btnLib addTarget:self action:@selector(inCartBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    //    UIBarButtonItem *barButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:btnLib];
    //    [arrRightBarItems addObject:barButtonItem2];
    
    
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
    //
    //    [btnLib addSubview:bangeLbl];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return section0;
    }
    else if(section == 1)
    {
        return section1;
    }
    return 0;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return [filterHeaderArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    
    //    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = @"yyyy/MM/dd";
    //    [dateFormatter dateFromString:dateString] ;
    //
    //    NSDate *yourDate = [dateFormatter dateFromString:dateString];
    //    [dateFormatter setDateFormat:@"d MMMM YYYY"];
    //    NSString *finalDate = [dateFormatter stringFromDate:yourDate];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _sortFilterTblVew.frame.size.width, 44)];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height-2);
    [btn setTag:section];
    [btn setTitle:[NSString stringWithFormat:@"%@",
                   [[[[filterHeaderArr objectAtIndex:section] capitalizedString] componentsSeparatedByString:@"_"] objectAtIndex:0]] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:50/255.0 green:57.0/255.0 blue:67.0/255.0 alpha:1] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    UIImageView *seperatorImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, btn.frame.size.height-1, btn.frame.size.width, 1)];
    seperatorImg.backgroundColor = [UIColor colorWithRed:121/255.0 green:129/255.0 blue:135.0/255.0 alpha:1];
    [view addSubview:seperatorImg];
    
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn1.frame = CGRectMake(_sortFilterTblVew.frame.size.width-50, 15, 20, 10);
    //    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTag:section];
    [btn1 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn1.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    
    if (section == 0)
    {
        if (section0 > 0)
        {
            [btn1 setBackgroundImage:[UIImage imageNamed:@"ic_arw_up.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btn1 setBackgroundImage:[UIImage imageNamed:@"ic_arw_down.png"] forState:UIControlStateNormal];
        }
    }
    else if (section == 1)
    {
        if (section1 > 0)
        {
            [btn1 setBackgroundImage:[UIImage imageNamed:@"ic_arw_up.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btn1 setBackgroundImage:[UIImage imageNamed:@"ic_arw_down.png"] forState:UIControlStateNormal];
        }
    }
    
    //    [btn1 setBackgroundImage:[UIImage imageNamed:@"ic_arw_up.png"] forState:UIControlStateNormal];
    
    //    [btn1 setBackgroundColor:[UIColor whiteColor]];
    //    [btn1 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];
    
    return view;
    
    
}

-(IBAction)btnClicked:(UIButton *)sender
{
    
//    NSLog(@"tag is %d",[sender tag]);
    selectedBtn = (int)sender.tag;
    if([sender tag] == 0)
    {
        if(section0)
        {
            selectedSection = -10;
            section0 = 0;
        }
        else
        {
            
            section1 = 0;
            section2Dict = nil;
            
            selectedSection = 1;
            section0 = [brandNameArr count];
            section1Dict = brandNameArr;
        }
    }
    else if ([sender tag] == 1)
    {
        if(section1)
        {
            selectedSection = -10;
            section1 = 0;
        }
        else
        {
            selectedSection = 2;
            
            section0 = 0;
            section1Dict = nil;
            
            section1 = [quantityRangeArr count];
            section2Dict = quantityRangeArr;
        }
    }
    [self.sortFilterTblVew reloadData];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"eventCell"];
    }
    if (selectedSection == 1)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [brandKeyArr objectAtIndex:indexPath.row]];
        
        BOOL temp = NO;
        NSString *brandIdMainStr = [brandKeyArr objectAtIndex:indexPath.row];
        
        for (NSString *brandIdTempStr in brandIdArr)
        {
            if ([brandIdMainStr isEqualToString:brandIdTempStr])
            {
                temp = YES;
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-50, 12, 20, 20)];
                [image setImage:[UIImage imageNamed:@"ic_tick.png"]];
                [cell addSubview:image];
                break;
            }
        }
        
//        for (int i = 0; i < section1SelectionArr.count; i++)
//        {
//            if ([[section1SelectionArr objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%li", (long)indexPath.row]])
//            {
//                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-50, 12, 20, 20)];
//                [image setImage:[UIImage imageNamed:@"ic_tick.png"]];
//                [cell addSubview:image];
//                break;
//            }
//            
//        }
        
    }
    else if (selectedSection == 2)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [quantityKeyArr objectAtIndex:indexPath.row]];
        
        BOOL temp = NO;
        NSString *brandIdMainStr = [quantityKeyArr objectAtIndex:indexPath.row];
        
        for (NSString *brandIdTempStr in quantityIdArr)
        {
            if ([brandIdMainStr isEqualToString:brandIdTempStr])
            {
                temp = YES;
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-50, 12, 20, 20)];
                [image setImage:[UIImage imageNamed:@"ic_tick.png"]];
                [cell addSubview:image];
                break;
            }
        }
        
        
//        for (int i = 0; i < section2SelectionArr.count; i++)
//        {
//            if ([[section2SelectionArr objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%li", (long)indexPath.row]])
//            {
//                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width-50, 12, 20, 20)];
//                [image setImage:[UIImage imageNamed:@"ic_tick.png"]];
//                [cell addSubview:image];
//                break;
//            }
//            
//        }
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedSection == 1)
    {
        brandSeletedStr = [[NSMutableString alloc] init];
        
        
        BOOL exist = NO;
        for (int  j = 0 ; j < brandIdArr.count; j++ )
        {
            if ([[brandKeyArr objectAtIndex:indexPath.row] isEqualToString:[brandIdArr objectAtIndex:j]])
            {
                exist = YES;
                [brandIdArr removeObject:[brandKeyArr objectAtIndex:indexPath.row]];
                break;
            }
        }
        if (exist == NO)
        {
            [brandIdArr addObject:[brandKeyArr objectAtIndex:indexPath.row]];
        }
        
        
        
//        for (int i = 0; i < section1SelectionArr.count; i++)
//        {
//            if ([[section1SelectionArr objectAtIndex:i] isEqualToString:[NSString stringWithFormat:@"%li", (long)indexPath.row]])
//            {
//                exist = YES;
//                
//                [brandIdArr removeObject:[brandKeyArr objectAtIndex:[[section1SelectionArr objectAtIndex:i] integerValue]]];
//                [section1SelectionArr removeObjectAtIndex:i];
//                
//                break;
//            }
//        }
//        if (exist == NO)
//        {
//            [section1SelectionArr addObject:[NSString stringWithFormat:@"%li", (long)indexPath.row]];
//            [brandIdArr addObject: [brandKeyArr objectAtIndex:indexPath.row]];
//        }
        
        for (int j = 0; j < brandIdArr.count; j++ )
        {
            
//            http://52.77.39.21/api/rest/solrbridge/search?q=Apple&storeid=11&fq[brand][0]=spencer%27s%20Smart%20Choice&fq[brand][1]=Catch&fq[qunatitiy][0]=4&fq[quantity][1]=3
            
            if (j == 0)
            {
                [brandSeletedStr appendFormat:@"fq[brand][%i]=%@", j, [brandIdArr objectAtIndex:j]];
            }
            else
            {
                [brandSeletedStr appendFormat:@"&fq[brand][%i]=%@", j, [brandIdArr objectAtIndex:j]];
            }
            
//            if (j == 0)
//            {
//                [brandSeletedStr appendFormat:@"%@", [brandKeyArr objectAtIndex:[[section1SelectionArr objectAtIndex:j] integerValue]]];
//            }
//            else
//            {
//                [brandSeletedStr appendFormat:@"-%@", [brandKeyArr objectAtIndex:[[section1SelectionArr objectAtIndex:j] integerValue]]];
//            }
            
        }
        //        brandSeletedStr = [brandKeyArr objectAtIndex:indexPath.row];
    }
    else if (selectedSection == 2)
    {
        quantitySelectedStr = [[NSMutableString alloc] init];
        
        BOOL exist = NO;
        for (int  j = 0 ; j < quantityIdArr.count; j++ )
        {
            if ([[quantityKeyArr objectAtIndex:indexPath.row] isEqualToString:[quantityIdArr objectAtIndex:j]])
            {
                exist = YES;
                [quantityIdArr removeObject:[quantityKeyArr objectAtIndex:indexPath.row]];
                break;
            }
        }
        if (exist == NO)
        {
            [quantityIdArr addObject:[quantityKeyArr objectAtIndex:indexPath.row]];
        }
        
        for (int j = 0; j < quantityIdArr.count; j++ )
        {
            if (j == 0)
            {
                [quantitySelectedStr appendFormat:@"fq[quantity][%i]=%@", j, [quantityIdArr objectAtIndex:j]];
            }
            else
            {
                [quantitySelectedStr appendFormat:@"&fq[quantity][%i]=%@", j, [quantityIdArr objectAtIndex:j]];
            }
            
            
            
            
            
//            if (j == 0)
//            {
//                [brandSeletedStr appendFormat:@"fq[brand][%i]=%@", j, [brandKeyArr objectAtIndex:[[section1SelectionArr objectAtIndex:j] integerValue]]];
//            }
//            else
//            {
//                [brandSeletedStr appendFormat:@"&fq[brand][%i]=%@", j, [brandKeyArr objectAtIndex:[[section1SelectionArr objectAtIndex:j] integerValue]]];
//            }
            
            
        }
    }
    [_sortFilterTblVew reloadData];
//    NSLog(@"brandSeletedStr=%@, quantitySelectedStr=%@", brandSeletedStr, quantitySelectedStr);
    
    [[NSUserDefaults standardUserDefaults] setObject:brandIdArr forKey:@"brandIdSearchArr"];
    [[NSUserDefaults standardUserDefaults] setObject:quantityIdArr forKey:@"quantityIdSearchArr"];
    
}


- (IBAction)applyBtnAct:(UIButton *)sender
{
    
    
    [[NSUserDefaults standardUserDefaults] setObject:brandIdArr forKey:@"brandIdSearchArr"];
    [[NSUserDefaults standardUserDefaults] setObject:quantityIdArr forKey:@"quantityIdSearchArr"];
    
    
    brandSeletedStr = [[NSMutableString alloc] init];
    quantitySelectedStr = [[NSMutableString alloc] init];
    
    for (int j = 0; j < brandIdArr.count; j++ )
    {
        if (j == 0)
        {
            [brandSeletedStr appendFormat:@"fq[brand][%i]=%@", j, [brandIdArr objectAtIndex:j]];
        }
        else
        {
            [brandSeletedStr appendFormat:@"&fq[brand][%i]=%@", j, [brandIdArr objectAtIndex:j]];
        }
    }
    
    for (int j = 0; j < quantityIdArr.count; j++ )
    {
        if (j == 0)
        {
            [quantitySelectedStr appendFormat:@"fq[quantity][%i]=%@", j, [quantityIdArr objectAtIndex:j]];
        }
        else
        {
            [quantitySelectedStr appendFormat:@"&fq[quantity][%i]=%@", j, [quantityIdArr objectAtIndex:j]];
        }
    }
    
    if (brandIdArr.count > 0)
    {
        [[NSUserDefaults standardUserDefaults] setValue:brandSeletedStr forKey:@"brandId"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"brandId"];
    }
    
    if (quantityIdArr.count > 0)
    {
        [[NSUserDefaults standardUserDefaults] setValue:quantitySelectedStr forKey:@"quantityId"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"quantityId"];
    }

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"counterDict"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FilterSortUpdated"
                                                        object:self];
    
//    if (brandSeletedStr.length < 1)
//    {
//        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"brandId"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setValue:brandSeletedStr forKey:@"brandId"];
//    }
//    if (quantitySelectedStr.length < 1)
//    {
//        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"quantityId"];
//    }
//    else
//    {
//        [[NSUserDefaults standardUserDefaults] setValue:quantitySelectedStr forKey:@"quantityId"];
//    }
    [self.navigationController popViewControllerAnimated:YES];
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
        InCartVC * inCartVC = [[InCartVC alloc] initWithNibName:@"InCartVC" bundle:nil];
        [self.navigationController pushViewController:inCartVC animated:YES];
    }
}

- (IBAction)sortFilterSegCont:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _sortFilterTblVew.hidden = YES;
        applyBtnObj.hidden = YES;
        [self sortByBtnAct:globalTag];
        
        switch (sortingByIndex)
        {
            case 11:
                hToLBtnObj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                lToHBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                popularityBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                brandsBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                offersBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                check1Img.image = [UIImage imageNamed:@"ic_tick.png"];
                check2Img.image = [UIImage imageNamed:@""];
                check3Img.image = [UIImage imageNamed:@""];
                check4Img.image = [UIImage imageNamed:@""];
                check5Img.image = [UIImage imageNamed:@""];
                break;
                
            case 12:
                hToLBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                lToHBtnObj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                popularityBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                brandsBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                offersBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                check1Img.image = [UIImage imageNamed:@""];
                check2Img.image = [UIImage imageNamed:@"ic_tick.png"];
                check3Img.image = [UIImage imageNamed:@""];
                check4Img.image = [UIImage imageNamed:@""];
                check5Img.image = [UIImage imageNamed:@""];
                break;
                
            case 13:
                hToLBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                lToHBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                popularityBtnObj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                brandsBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                offersBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                check1Img.image = [UIImage imageNamed:@""];
                check2Img.image = [UIImage imageNamed:@""];
                check3Img.image = [UIImage imageNamed:@"ic_tick.png"];
                check4Img.image = [UIImage imageNamed:@""];
                check5Img.image = [UIImage imageNamed:@""];
                break;
                
            case 14:
                hToLBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                lToHBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                popularityBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                brandsBtnObj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                offersBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                check1Img.image = [UIImage imageNamed:@""];
                check2Img.image = [UIImage imageNamed:@""];
                check3Img.image = [UIImage imageNamed:@""];
                check4Img.image = [UIImage imageNamed:@"ic_tick.png"];
                check5Img.image = [UIImage imageNamed:@""];
                break;
                
            case 15:
                hToLBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                lToHBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                popularityBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                brandsBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
                offersBtnObj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                check1Img.image = [UIImage imageNamed:@""];
                check2Img.image = [UIImage imageNamed:@""];
                check3Img.image = [UIImage imageNamed:@""];
                check4Img.image = [UIImage imageNamed:@""];
                check5Img.image = [UIImage imageNamed:@"ic_tick.png"];
                break;
                
            default:
                break;
        }

        
    }
    else if (sender.selectedSegmentIndex == 1)
    {
        _sortFilterTblVew.hidden = NO;
        applyBtnObj.hidden = NO;
        hToLBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
        lToHBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
        popularityBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
        brandsBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
        offersBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
        check1Img.image = [UIImage imageNamed:@""];
        check2Img.image = [UIImage imageNamed:@""];
        check3Img.image = [UIImage imageNamed:@""];
        check4Img.image = [UIImage imageNamed:@""];
        check5Img.image = [UIImage imageNamed:@""];
    }
}






- (IBAction)sortByBtnAct:(int)sortBy
{
    //    if (sortBy > 10 && sortBy < 15)
    //    {
    //        [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d", sortBy] forKey:@"sortingBy"];
    //    }
    
   
    
    switch (sortBy)
    {
        case 11:
            hToLBtnObj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            lToHBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            popularityBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            brandsBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            offersBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            check1Img.image = [UIImage imageNamed:@"ic_tick.png"];
            check2Img.image = [UIImage imageNamed:@""];
            check3Img.image = [UIImage imageNamed:@""];
            check4Img.image = [UIImage imageNamed:@""];
            check5Img.image = [UIImage imageNamed:@""];
            break;
            
        case 12:
            hToLBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            lToHBtnObj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            popularityBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            brandsBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            offersBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            check1Img.image = [UIImage imageNamed:@""];
            check2Img.image = [UIImage imageNamed:@"ic_tick.png"];
            check3Img.image = [UIImage imageNamed:@""];
            check4Img.image = [UIImage imageNamed:@""];
            check5Img.image = [UIImage imageNamed:@""];
            break;
            
        case 13:
            hToLBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            lToHBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            popularityBtnObj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            brandsBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            offersBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            check1Img.image = [UIImage imageNamed:@""];
            check2Img.image = [UIImage imageNamed:@""];
            check3Img.image = [UIImage imageNamed:@"ic_tick.png"];
            check4Img.image = [UIImage imageNamed:@""];
            check5Img.image = [UIImage imageNamed:@""];
            break;
            
        default:
            break;
    }
    
    //    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sortBtnAct:(UIButton *)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:sender.titleLabel.text forKey:@"sortingBy"];
    
    globalTag = (int)sender.tag;
    
    [[NSUserDefaults standardUserDefaults] setInteger:globalTag forKey:@"sortingSearchIndex"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"counterDict"];
    
    switch (sender.tag)
    {
        case 11:
            hToLBtnObj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            lToHBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            popularityBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            brandsBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            offersBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            check1Img.image = [UIImage imageNamed:@"ic_tick.png"];
            check2Img.image = [UIImage imageNamed:@""];
            check3Img.image = [UIImage imageNamed:@""];
            check4Img.image = [UIImage imageNamed:@""];
            check5Img.image = [UIImage imageNamed:@""];
            break;
            
        case 12:
            hToLBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            lToHBtnObj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            popularityBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            brandsBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            offersBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            check1Img.image = [UIImage imageNamed:@""];
            check2Img.image = [UIImage imageNamed:@"ic_tick.png"];
            check3Img.image = [UIImage imageNamed:@""];
            check4Img.image = [UIImage imageNamed:@""];
            check5Img.image = [UIImage imageNamed:@""];
            break;
            
        case 13:
            hToLBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            lToHBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            popularityBtnObj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            brandsBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            offersBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            check1Img.image = [UIImage imageNamed:@""];
            check2Img.image = [UIImage imageNamed:@""];
            check3Img.image = [UIImage imageNamed:@"ic_tick.png"];
            check4Img.image = [UIImage imageNamed:@""];
            check5Img.image = [UIImage imageNamed:@""];
            break;
            
        case 14:
            hToLBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            lToHBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            popularityBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            brandsBtnObj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            offersBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            check1Img.image = [UIImage imageNamed:@""];
            check2Img.image = [UIImage imageNamed:@""];
            check3Img.image = [UIImage imageNamed:@""];
            check4Img.image = [UIImage imageNamed:@"ic_tick.png"];
            check5Img.image = [UIImage imageNamed:@""];
            break;
            
        case 15:
            hToLBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            lToHBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            popularityBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            brandsBtnObj.titleLabel.font = [UIFont systemFontOfSize:15];
            offersBtnObj.titleLabel.font = [UIFont boldSystemFontOfSize:15];
            check1Img.image = [UIImage imageNamed:@""];
            check2Img.image = [UIImage imageNamed:@""];
            check3Img.image = [UIImage imageNamed:@""];
            check4Img.image = [UIImage imageNamed:@""];
            check5Img.image = [UIImage imageNamed:@"ic_tick.png"];
            break;
            
        default:
            break;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FilterSortUpdated"
                                                        object:self];
    [self.navigationController popViewControllerAnimated:YES];
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

@end
