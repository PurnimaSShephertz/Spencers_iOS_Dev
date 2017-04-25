//
//  ProductVC.h
//  Spencer
//
//  Created by binary on 02/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVPullToRefresh.h"
#import "ProductCell.h"
#import "ACPScrollMenu.h"
#import "SortFilterVC.h"

#import "GAI.h"

@interface ProductVC : GAITrackedViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, ACPScrollDelegate>
{
    IBOutlet UISearchBar *searchBar1;
    CGFloat width ;
    CGFloat height ;
    CGFloat screenX ;
    CGFloat screenY ;
    IBOutlet UITableView *productListTblVew;
    IBOutlet ProductCell *productCell;
    
    
    UILabel *headerTitLbl;
    UIImageView *headerDropDownImg;
    UIImageView *headerImgVew;
    UIButton *hederFilterBtnObj;
    
    int pageNumber;
    
    BOOL sortFlag;
    NSString * storeIdStr;
    
    UIScrollView *slideMenuScrVew;
    UIButton *filterBtnObj;
    
    SortFilterVC *sortFilterVC;
    IBOutlet UIButton *currentLocationBtnObj;
    
    NSString *sortString, *descString, *sortStr;
    NSMutableDictionary *cartCountDictLocal;
    NSMutableDictionary *cartCountModifyDict;
    
    NSArray *sortArray;

    IBOutlet UIButton *offerBtnObj;
}
@property (strong, nonatomic) IBOutlet UIButton *productDetailsBtnObj;

- (IBAction)productDetailsBtnAct:(UIButton *)sender;

@property (strong, nonatomic) NSDictionary *productDetailsDict;
@property (strong, nonatomic) IBOutlet ACPScrollMenu *scrollMenu;

@property (nonatomic, retain) NSString *categoryUrl;
- (IBAction)minusAct:(UIButton *)sender;
- (IBAction)plusAct:(UIButton *)sender;
- (IBAction)backBtnAct:(UIButton *)sender;
@property (nonatomic, assign) int pageNumber;
- (IBAction)inCartBtnAct:(UIButton *)sender;
- (IBAction)footerBtnAct:(UIButton *)sender;
- (IBAction)currentLocationBtnAct:(UIButton *)sender;

- (IBAction)addCartBtnAct:(UIButton *)sender;

@property (nonatomic, retain) NSString *productHeader;

@end
