//
//  MainCategoryVC.h
//  SpencerKolkata
//
//  Created by binary on 30/06/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "AppDelegate.h"
#import "VSDropdown.h"
#import "InCartVC.h"
#import "ManualLocationVC.h"
#import "GAI.h"

@interface MainCategoryVC : GAITrackedViewController <iCarouselDataSource, iCarouselDelegate, UISearchBarDelegate, VSDropdownDelegate>

{
    NSMutableArray * ImagesArray;
    CGFloat width;
    CGFloat height;
    CGFloat screenX, screenY;
    
    UIPageControl *pageControl;
    AppDelegate *appDele;
    IBOutlet UIScrollView *mainMenuScrVew;
    NSMutableArray *listImageArray;
    NSMutableArray *listNameArray;
    IBOutlet UIImageView *headerNavImage;
    IBOutlet UISearchBar *searchBar1;
    
    VSDropdown *_dropdown;
    IBOutlet UIButton *bgHeaderBtnObj,*scrollTopBtnAct;
    
    int pageNumber;
    NSString *storeIdStr;
    
    IBOutlet UILabel *bangeLbl;
    InCartVC *inCartVC;
    IBOutlet UIButton *currentLocationBtnObj;
    
    ManualLocationVC *manualLocationVC;
    
    NSUserDefaults *temp;
    NSString *oauth_token, *oauth_token_secret;
    IBOutlet UIView * RotateView;
    BOOL rotateCheck;
    IBOutlet UILabel * browse_lbl,*line_lbl;
     CGFloat yOffset;
    NSString *sessionExpireStr;
}

- (IBAction)scrollTopBtnAct:(UIButton *)sender;

@property (nonatomic, strong) IBOutlet iCarousel *carousel;
@property (nonatomic, retain) UIPageControl *pageControl;
- (IBAction)backBtnAct:(UIButton *)sender;

@property (nonatomic, assign) BOOL wrap;

- (IBAction)footerBtnAct:(UIButton *)sender;

- (IBAction)inCartBtnAct:(UIButton *)sender;

- (IBAction)currentLocationBtnAct:(UIButton *)sender;
-(IBAction)DrawerMenu_Act:(id)sender;
@property (nonatomic, strong) NSMutableDictionary *currentArray;

@end
