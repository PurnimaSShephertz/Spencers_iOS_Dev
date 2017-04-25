//
//  SearchVC.h
//  Spencer
//
//  Created by binary on 02/07/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InCartVC.h"
#import "SearchListVC.h"
#import "GAI.h"


@interface SearchVC : GAITrackedViewController <UISearchBarDelegate>
{
    NSString *storeIdStr;
    CGFloat width ;
    CGFloat height ;
    CGFloat screenX ;
    CGFloat screenY ;
    IBOutlet UIButton *backBtnObj;
    IBOutlet UITableView *searchTblVew;
    IBOutlet UISearchBar *searchBar1;
    IBOutlet UIImageView *headerNavImage;
    IBOutlet UIButton *cancelBtnObj;
    
    IBOutlet UIImageView *locationImgVew;
    IBOutlet UILabel *locationTitLbl;
    InCartVC *inCartVC;
    BOOL shouldBeginEditing;
}
@property (strong, nonatomic)IBOutlet UISearchController *searchController;
- (IBAction)backBtnAct:(UIButton *)sender;
- (IBAction)cancelBtnAct:(UIButton *)sender;

@end
