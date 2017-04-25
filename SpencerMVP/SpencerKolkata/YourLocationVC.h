//
//  YourLocationVC.h
//  SpencerKolkata
//
//  Created by binary on 30/06/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import <sys/utsname.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationController.h"
#import "GAI.h"

@interface YourLocationVC : GAITrackedViewController <REFrostedViewControllerDelegate,CLLocationManagerDelegate>
{
    IBOutlet UIButton *currentLocationBtnObj;
    IBOutlet UIButton *manualLocationBtnObj;
    NSString *  AddressStr;
    
}
@property (nonatomic, strong) CLLocationManager *locationManager;
- (IBAction)currentLocationBtnAct:(UIButton *)sender;
- (IBAction)manualLocationBtnAct:(UIButton *)sender;
- (IBAction)MainCategoryBtnAct:(UIButton *)sender;
@property (nonatomic, assign) int flag;

@end
