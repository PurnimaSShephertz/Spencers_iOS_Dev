//
//  SearchSortFilterVC.h
//  Spencer
//
//  Created by binary on 25/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"

@interface SearchSortFilterVC : GAITrackedViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableString *brandSeletedStr, *quantitySelectedStr;
    
    NSArray *brandKeyArr, *quantityKeyArr;
    NSDictionary *section1Dict, *section2Dict;
    NSDictionary *infoDict;
    int selectedSection;
    int section0,section1,section2;
    IBOutlet UILabel *bangeLbl;
    
    IBOutlet UIButton *hToLBtnObj, *lToHBtnObj, *popularityBtnObj, *brandsBtnObj, *offersBtnObj;
    IBOutlet UIImageView *check1Img, *check2Img, *check3Img, *check4Img, *check5Img;
    
    NSArray *quantityRangeArr, *brandNameArr, *filterHeaderArr;
    UIButton *btn;
    IBOutlet UIButton *applyBtnObj;
}

@property (nonatomic, strong) NSMutableArray *brandIdArr, *quantityIdArr;
@property (strong, nonatomic) IBOutlet UITableView *sortFilterTblVew;
@property (nonatomic, retain) NSString *productHeader;

- (IBAction)applyBtnAct:(UIButton *)sender;


- (IBAction)backBtnAct:(UIButton *)sender;
- (IBAction)inCartBtnAct:(UIButton *)sender;
- (IBAction)sortFilterSegCont:(UISegmentedControl *)sender;


- (IBAction)sortBtnAct:(UIButton *)sender;
@end
