//
//  CategoryPage.h
//  Spencer
//
//  Created by Binary Semantics on 7/6/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAI.h"

@interface CategoryPage : GAITrackedViewController <UISearchBarDelegate>
{
    CGFloat width;
    CGFloat height;
    CGFloat screenX, screenY;
    IBOutlet UIScrollView *mainMenuScrVew;
    NSMutableArray *listImageArray;
    NSMutableArray *listNameArray;
    IBOutlet UIButton *currentLocationBtnObj;
    
    int pageNumber;
    NSString *storeIdStr;
    
    IBOutlet UISearchBar *searchBar1;
    NSUserDefaults * temp;
    UILabel *bangeLbl;
}

@property (nonatomic, strong) NSMutableArray *currentArray;

- (IBAction)backBtnAct:(UIButton *)sender;
- (IBAction)currentLocationBtnAct:(UIButton *)sender;

- (IBAction)footerBtnAct:(UIButton *)sender;

@end
