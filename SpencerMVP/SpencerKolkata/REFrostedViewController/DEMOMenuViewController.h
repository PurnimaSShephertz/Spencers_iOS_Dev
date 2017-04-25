//
//  DEMOMenuViewController.h
//  REFrostedViewControllerExample
//
//  Created by Roman Efimov on 9/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "listViewCell.h"
@class ManualLocationVC;

@class AppDelegate;

@class RegistrationVC;
@class LoginVC;
#import "ProfilePage.h"

@interface DEMOMenuViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, REFrostedViewControllerDelegate>
{
    ProfilePage *profilepage;
    
    NSArray *titles;
    NSArray*images_array;
    
    UITapGestureRecognizer * tapgesture;
    UIButton *userimg, *Login_Button, *SigUp_Burron, *Edit_button, *FullAddress_Button;
    
    UILabel *Address;
    ManualLocationVC *manualLocationVC;
    
    LoginVC *loginVC;
    RegistrationVC *registrationVC;
    
    NSUserDefaults *temp;
    NSString *oauth_token;
    AppDelegate *appDele;
    CGFloat width;
    UILabel *userNameLbl;
    NSDictionary *userDict;
}
@property (strong, nonatomic)IBOutlet listViewCell * distcel;
@end
