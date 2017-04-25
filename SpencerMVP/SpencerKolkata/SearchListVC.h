//
//  SearchListVC.h
//  Spencer
//
//  Created by binary on 08/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCell.h"
#import "MyProfileVC.h"
#import "LoginVC.h"
#import "SearchSortFilterVC.h"


//#import "FilterVC.h"
@class ProductListVC;
@class InCartVC;

#import "SearchCell.h"

#import "SVPullToRefresh.h"

#import "VSDropdown.h"
#import "GAI.h"

@interface SearchListVC : GAITrackedViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, NSURLConnectionDataDelegate, NSURLConnectionDelegate, VSDropdownDelegate,UISearchBarDelegate>

{
    
    CGFloat width ;
    CGFloat height ;
    CGFloat screenX ;
    CGFloat screenY ;
    
    VSDropdown *_dropdown;
    IBOutlet UITableView *itemDetailsTblVew;
    NSArray *productDetailsKeysArray;
    NSMutableDictionary *kgIndexDict;
    int cartItemCount, wishlistItemCount;
    NSMutableDictionary *productDetailsItemsDict;
    NSMutableDictionary *cartCountDict;
    NSMutableDictionary *wishlistCountDict;
    int rowSelected;
    NSArray *cartCountKeyArr, *wishlistCountKeyArr;
    
    IBOutlet UILabel *bangeLbl;
    int kgButtonTag;
    NSArray *kgArray;
    NSString *kgSelectedStr;
    NSMutableArray * selectedRowsArray,*contentArray;
    NSDictionary * WishListData_Dict;
    NSMutableArray * nameArray;
    NSArray *sortArray;
    
    IBOutlet UIView *sortView;
    IBOutlet UILabel * headerlbl;
    IBOutlet UIImageView * header_img;
    id tempDict;
    NSMutableArray *itemId;
    int pageNumber;
    
    NSString *sortString, *descString ;
    
    BOOL sortFlag;
    
    IBOutlet UIButton *offerObj;
    
    
    NSMutableDictionary *cartCountDictLocal;
    NSMutableDictionary *cartCountModifyDict;
    
    int rowSeletcedIs;
    
    NSString *storeIdStr;
    
    UIButton *filterBtnObj;
    
    NSString *brandId, *quantityId ;
    
}

- (IBAction)productDetailsBtnAct:(UIButton *)sender;
@property (nonatomic, retain) IBOutlet UISearchBar* searchBar1;
@property (nonatomic, retain) IBOutlet UIButton *menuBtnObj, *searchBtnObj, *cartBtnObj, *myProfileBtnObj, *logoLargeBtn;
@property (strong, nonatomic) IBOutlet UITextField *searchBar;
@property (strong, nonatomic) IBOutlet UIImageView *searchBg;
@property (strong, nonatomic) IBOutlet UIImageView *logoLargeImg, *logoSmallImg, *footerImg, *myProfileImg;
@property (strong, nonatomic) IBOutlet UILabel *bangeLbl;
@property (nonatomic, retain) NSMutableArray *productDetailsDict;
@property (nonatomic, retain) NSMutableArray *allDataDict;
@property (nonatomic, retain) NSString *productHeader;
@property (strong, nonatomic) InCartVC *placeOrderVC;
@property (strong, nonatomic) IBOutlet SearchCell *itemDetailsCell;

@property (strong, nonatomic) IBOutlet UIButton *sortBtnObj;
@property (strong, nonatomic) IBOutlet UIButton *filterBtnObj;

@property (nonatomic, assign) BOOL offerCheckBool;

@property (strong, nonatomic) NSString *sortStr;

@property (strong, nonatomic) NSString *searchStr;


- (IBAction)weightPlusBtnAct:(UIButton *)sender;
- (IBAction)weightMinusBtnAct:(UIButton *)sender;
- (IBAction)kgBtnAct:(UIButton *)sender;
- (IBAction)addCartBtnAct:(UIButton *)sender;
- (IBAction)menuBtnAct:(UIButton *)sender;
- (IBAction)addWishListBtnAct:(UIButton *)sender;

- (IBAction)sortBtnAct:(UIButton *)sender;
- (IBAction)filterBtnAct:(UIButton *)sender;


@property (strong, nonatomic) IBOutlet UIImageView *checkImg1, *checkImg2, *checkImg3;
- (IBAction)checkBtn:(UIButton *)sender;

- (IBAction)moreBtnAct:(UIButton *)sender;

@property (nonatomic, assign) int categoryTag;
@property (nonatomic, retain) NSString *categoryUrl;

@property (strong, nonatomic) IBOutlet UIButton *moreBtnObj;


@end
