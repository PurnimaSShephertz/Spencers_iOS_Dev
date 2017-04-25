//
//  ProfilePage.h
//  MeraGrocer
//
//  Created by Binary Semantics on 6/26/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "GAI.h"

#import "VSDropdown.h"

#import "ProfilePage.h"
#import "GAI.h"

@interface ProfilePage : GAITrackedViewController <UIWebViewDelegate, UITextFieldDelegate, VSDropdownDelegate>
{
    VSDropdown *_dropdown;
    IBOutlet UIWebView * webview;
    
    IBOutlet UIButton *offerObj;
}

@property (nonatomic, retain) NSString *headerStr;
@property(nonatomic,retain)NSString * url_Str;

@property (strong, nonatomic) IBOutlet UILabel *versionLbl;

@property (strong, nonatomic) NSString *versionStr;

@property (nonatomic, retain) IBOutlet UIButton *menuBtnObj, *searchBtnObj, *cartBtnObj, *myProfileBtnObj, *logoLargeBtn;
@property (strong, nonatomic) IBOutlet UITextField *searchBar;
@property (strong, nonatomic) IBOutlet UIImageView *searchBg;
@property (strong, nonatomic) IBOutlet UIImageView *logoLargeImg,*logoSmallImg, *footerImg, *myProfileImg;
@property (strong, nonatomic) IBOutlet UILabel *bangeLbl;

@property (strong, nonatomic) NSString *htmlFile,* TagUrl;


@end
