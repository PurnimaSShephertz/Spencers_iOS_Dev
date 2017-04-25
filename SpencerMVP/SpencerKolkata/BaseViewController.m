//
//  BaseViewController.m
//  CubeDemo
//
//  Created by Vikas Singh on 8/25/15.
//  Copyright (c) 2015 Vikas Singh. All rights reserved.
//

#import "BaseViewController.h"
#import "TestParams.h"
#import "MerchantConstants.h"


@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initializeLayers];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initializers

// Initialize the SDK layer viz CTSAuthLayer/CTSProfileLayer/CTSPaymentLayer
-(void)initializeLayers{
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    CTSKeyStore *keyStore = [[CTSKeyStore alloc] init];
    keyStore.signinId = SignInId;
    keyStore.signinSecret = SignInSecretKey;
    keyStore.signUpId = SubscriptionId;
    keyStore.signUpSecret = SubscriptionSecretKey;
    keyStore.vanity = VanityUrl;
//#ifdef PRODUCTION_MODE
    [CitrusPaymentSDK initializeWithKeyStore:keyStore environment:CTSEnvProduction];
//#else
//    [CitrusPaymentSDK initializeWithKeyStore:keyStore environment:CTSEnvSandbox];
//#endif

    [CitrusPaymentSDK enableDEBUGLogs];
    
    authLayer = [CTSAuthLayer fetchSharedAuthLayer];
    proifleLayer = [CTSProfileLayer fetchSharedProfileLayer];
    paymentLayer = [CTSPaymentLayer fetchSharedPaymentLayer];
    
    NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"];
    NSDictionary *paymentDict = [[NSUserDefaults standardUserDefaults] valueForKey:@"PaymentDict"];
    
    
    if (userDict == nil)
    {
        contactInfo = [[CTSContactUpdate alloc] init];
        contactInfo.firstName = TEST_FIRST_NAME;
        contactInfo.lastName = TEST_LAST_NAME;
        contactInfo.email = TEST_EMAIL;
        contactInfo.mobile = TEST_MOBILE;
        
        
        
        addressInfo = [[CTSUserAddress alloc] init];
        addressInfo.city = TEST_CITY;
        addressInfo.country = TEST_COUNTRY;
        addressInfo.state = TEST_STATE;
        addressInfo.street1 = TEST_STREET1;
        addressInfo.street2 = TEST_STREET2;
        addressInfo.zip = TEST_ZIP;
        
        customParams = @{
                         @"USERDATA2":@"MOB_RC|9988776655",
                         @"USERDATA10":@"test",
                         @"USERDATA4":@"MOB_RC|test@gmail.com",
                         @"USERDATA3":@"MOB_RC|4111XXXXXXXX1111",
                         };
    }
    else if (paymentDict == nil)
    {
        contactInfo = [[CTSContactUpdate alloc] init];
        contactInfo.firstName = TEST_FIRST_NAME;
        contactInfo.lastName = TEST_LAST_NAME;
        contactInfo.email = TEST_EMAIL;
        contactInfo.mobile = TEST_MOBILE;
        
        
        
        addressInfo = [[CTSUserAddress alloc] init];
        addressInfo.city = TEST_CITY;
        addressInfo.country = TEST_COUNTRY;
        addressInfo.state = TEST_STATE;
        addressInfo.street1 = TEST_STREET1;
        addressInfo.street2 = TEST_STREET2;
        addressInfo.zip = TEST_ZIP;
        
        customParams = @{
                         @"USERDATA2":@"MOB_RC|9988776655",
                         @"USERDATA10":@"test",
                         @"USERDATA4":@"MOB_RC|test@gmail.com",
                         @"USERDATA3":@"MOB_RC|4111XXXXXXXX1111",
                         };
    }
    else
    {
        contactInfo = [[CTSContactUpdate alloc] init];
        contactInfo.firstName = [NSString stringWithFormat:@"%@", [[userDict valueForKey:@"data"] valueForKey:@"firstname"]];
        contactInfo.lastName = [NSString stringWithFormat:@"%@", [[userDict valueForKey:@"data"] valueForKey:@"lastname"]];
        contactInfo.email = [NSString stringWithFormat:@"%@", [[userDict valueForKey:@"data"] valueForKey:@"email"]];
        contactInfo.mobile = [NSString stringWithFormat:@"%@", [[[paymentDict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"phone"]];
        
        
        
        addressInfo = [[CTSUserAddress alloc] init];
        addressInfo.city = [NSString stringWithFormat:@"%@", [[[paymentDict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"City"]];
        addressInfo.country = [NSString stringWithFormat:@"%@", [[[paymentDict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"Country"]];
        addressInfo.state = [NSString stringWithFormat:@"%@", [[[paymentDict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"State"]];
//        addressInfo.street1 = TEST_STREET1;
//        addressInfo.street2 = TEST_STREET2;
        addressInfo.zip = [NSString stringWithFormat:@"%@", [[[paymentDict valueForKey:@"data"] valueForKey:@"moto"] valueForKey:@"Zipcode"]];
        
        customParams = @{
                         @"USERDATA2":@"MOB_RC|9988776655",
                         @"USERDATA10":@"test",
                         @"USERDATA4":@"MOB_RC|test@gmail.com",
                         @"USERDATA3":@"MOB_RC|4111XXXXXXXX1111",
                         };
    }
    NSLog(@"contactInfo %@", contactInfo);
    NSLog(@"addressInfo %@", addressInfo);
}

@end
