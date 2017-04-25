//
//  ManualLocationVC.h
//  SpencerKolkata
//
//  Created by binary on 30/06/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "DEMOMenuViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <sys/utsname.h>
#import "LocationController.h"
#import "GAI.h"

@interface ManualLocationVC : GAITrackedViewController <UITableViewDataSource, UITableViewDelegate, REFrostedViewControllerDelegate,UISearchBarDelegate,CLLocationManagerDelegate>
{
    NSString *storeIdStr;
    CGFloat width ;
    CGFloat height ;
    CGFloat screenX ;
    CGFloat screenY ;
    IBOutlet UIButton  *currentLocationBtnObj;
    IBOutlet UITableView *locationTblVew;
    IBOutlet UIImageView *locationImgVew;
    IBOutlet UILabel *locationTitLbl;
    NSDictionary * allLocationDataIs;
    BOOL isSearching;
    NSMutableArray *filteredContentList;
    NSString *  AddressStr;
    BOOL shouldBeginEditing;
}
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar1;
@property(nonatomic,retain)NSString * headercheck;
@property (nonatomic, assign) int flag;
- (IBAction)backBtnAct:(UIButton *)sender;
- (IBAction)cancelBtnAct:(UIButton *)sender;
- (IBAction)currentLocationBtnAct:(UIButton *)sender;

@end
