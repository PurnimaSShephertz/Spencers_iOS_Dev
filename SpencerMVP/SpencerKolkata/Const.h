// UAT Url

//#define baseUrl1 @"http://52.77.39.21/api/rest"
//#define baseBannerUrl1 @"http://52.77.39.21"
//#define area @"http://52.77.39.21/js/areasearch/searchArea.json"
//#define solarSearchUrl @"http://www.spencers.in"

// Production Url


//#define baseUrl1 @"http://apis.spencers.in/api/rest"
//#define baseBannerUrl1 @"http://apis.spencers.in"
//#define area @"http://apis.spencers.in/js/areasearch/searchArea.json"
//#define solarSearchUrl @"http://www.spencers.in"


#define baseUrl1 @"http://apis.spencers.in/upgrade/2017/api/rest"
#define baseBannerUrl1 @"http://apis.spencers.in"
#define area @"http://apis.spencers.in/upgrade/2017/js/areasearch/searchArea.json"
#define solarSearchUrl @"http://www.spencers.in"

//apis.spencers.in/upgrade/2017/


#define login  @"login"
#define regist @"register"

//Color

#define kColor_Seperator [UIColor colorWithRed:53.0/255.0 green:126.0/255.0 blue:167.0/255.0 alpha:1.0]
#define kColor_gray [UIColor colorWithRed:83.0/255.0 green:88.0/255.0 blue:95.0/255.0 alpha:1.0]
#define kColor_NonCompliant [UIColor colorWithRed:190.0/255.0 green:15.0/255.0 blue:52.0/255.0 alpha:1.0]
#define kColor_Compliant [UIColor colorWithRed:87.0/255.0 green:149.0/255.0 blue:0.0/255.0 alpha:1.0]
#define kColor_Orange [UIColor colorWithRed:232.0/255.0 green:138.0/255.0 blue:45/255.0 alpha:1.0]
#define kColor_skyBlue [UIColor colorWithRed:53.0/255.0 green:101.0/255.0 blue:192/255.0 alpha:1.0]
#define kColor_OrangeHeader [UIColor colorWithRed:220.0/255.0 green:142.0/255.0 blue:68/255.0 alpha:1.0]
#define IS_IPHONE_SIMULATOR ([[[UIDevice currentDevice]model] isEqualToString : @"iPhone Simulator"])
#define IS_IPHONE           ([[[UIDevice currentDevice]model] isEqualToString : @"iPhone"])
#define IS_IPOD_TOUCH       ([[[UIDevice currentDevice]model] isEqualToString : @"iPod Touch"])
#define IS_WIDESCREEN  ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double ) 568 ) < DBL_EPSILON )
#define ITS_IPHONE5 ( (IS_IPHONE_SIMULATOR || IS_IPOD_TOUCH || IS_IPHONE) && IS_WIDESCREEN)

#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)736) < DBL_EPSILON)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//iPhone Size





