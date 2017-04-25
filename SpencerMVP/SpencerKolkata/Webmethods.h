//
//  Webmethods.h
//  CustomMenu
//
//  Created by Binary Semantics on 6/10/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import <Foundation/Foundation.h>
@class AppDelegate;
#import "ToastAlert.h"
#import "Reachability.h"
#import "AFOAuth1Client.h"
#import "AFNetworking.h"

#import "Const.h"

@interface Webmethods : UIView
{
    NSString *data;
    NSString *storeIdStr;
}
@property (strong, nonatomic) AFOAuth1Client *oAuth1Client;

+(NSDictionary *)RegistrationMethod:(NSString *)firstname andlastname:(NSString *)lastname andemail:(NSString *)email andpassword:(NSString *)password crmid:(NSString *)crmid mobile:(NSString *)mobile;
+(NSDictionary *)OtpVerify:(NSString *)otp andemail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName mobileNumber:(NSString *)mobileNumber password:(NSString *)password crmid:(NSString *)crmid;
+(NSDictionary *)ResendOTP:(NSString *)email mobile:(NSString *)mobile;

+(NSDictionary *)LoginMethod:(NSString *)email andpassword:(NSString *)password andconsumerkey:(NSString *)consumerkey andconsumersecret:(NSString *)consumersecret and:(NSString *)deviceid;
+(NSDictionary *)Getcustmer;
+(NSDictionary *)UpdateCustomer:(NSString *)URL andDict:(NSString * )firstname andLastName:(NSString *)lastname andEmail:(NSString * )email crmid:(NSString *)crmid mobile:(NSString *)mobileNumber;

+(NSDictionary *)UpdateCustomer:(NSString *)URL andDict:(NSString * )firstname andLastName:(NSString *)lastname andEmail:(NSString * )email crmid:(NSString *)crmid mobile:(NSString *)mobileNumber otp:(NSString *)otp;
+(NSMutableDictionary * )myorders;



+(NSDictionary *)DeletewishlistRecord:(NSString *)itemid;
+(NSMutableDictionary *)GetcartData_Login;
+(NSMutableDictionary *)AddtoCart_Login:(NSString *)url;

+(NSMutableDictionary *)AddCoupon:(NSString *)url;
+(NSMutableArray *)GetAll_Address:(NSString *)URL;
+(NSDictionary *)Addaddress:(NSString *)URL andDict:(NSString * )firstname andLastName:(NSString *)lastname andcity:(NSString * )city andregion:(NSString *)region andpostcode:(NSString *)postcode andcountry_id:(NSString *)country_id andtelephone:(NSString *)telephone andstreet:(NSMutableArray *)street;
+(NSDictionary *)UpdateAddress:(NSString *)URL andDict:(NSString * )firstname andLastName:(NSString *)lastname andcity:(NSString * )city andregion:(NSString *)region andpostcode:(NSString *)postcode andcountry_id:(NSString *)country_id andtelephone:(NSString *)telephone andstreet:(NSMutableArray *)street;
+(NSMutableDictionary *)RemoveCoupon_Login;
+(NSDictionary *)moveToCart:(NSString *)itemid;
+(NSDictionary *)removeFromCart:(NSString *)URL;
+(NSDictionary *)moveAllToCart;
+(NSDictionary *)DeleteItemFromCart:(NSString *)URL;
+(NSDictionary *)updateItemFromCart:(NSString *)URL;
+(NSMutableDictionary *)DeleteAddress:(NSString *)URL;
//+(NSDictionary *)createorder:(NSString *)billtoid andshiptoid:(NSString *)shiptoid andpayby:(NSString *)payby anddate:(NSString *)date andslotid:(NSString *)slotid andcredits:(NSString *)credits andCrmCredit:(NSString *)crmCredit;
+(NSDictionary *)createorder:(NSString *)billtoid andshiptoid:(NSString *)shiptoid andpayby:(NSString *)payby anddate:(NSString *)date andslotid:(NSString *)slotid andcredits:(NSString *)credits andCrmCredit:(NSString *)crmCredit is_card:(NSString *)is_card;
+(NSDictionary *)GetSlots;
+(NSDictionary *)Updatepassword:(NSString *)password;
+(NSMutableDictionary *)getwallet;
+(NSDictionary *)recahrge:(NSString *)code;

+(NSDictionary *)sorting:(NSString *)URL;

+(NSDictionary *)forgotpassword:(NSString *)Email;
+(NSDictionary *)Newsletter:(NSString *)is_subscribe;

+(NSDictionary *) reorderOrder: (NSString *)entityId;
+(NSDictionary *) editOrder: (NSString *)entityId;

+(NSDictionary *)getCartWishlist;

+(NSDictionary *)getCartWishlist:(NSString *)URL;

+(NSDictionary * )product:(NSString *)URL;
+(NSDictionary *)GetstoreID:(NSString *)code;

+(NSMutableDictionary *)applyWallet:(NSString *)credit;

+(NSMutableDictionary *)applySRC:(NSString *)credit;

+(NSMutableDictionary *)GetcartData_LoginAfterLogin: (NSString *)cartId;

+(NSDictionary *)search:(NSString *)URL;

+(NSMutableDictionary *)pin:(NSString *)url;

+(BOOL)checkNetwork;

+(NSMutableDictionary *)searchResult:(NSString *)q storeid:(NSString *)storeid customergroupid:(NSString *)customergroupid storetimestamp:(NSString *)storetimestamp currencycode:(NSString *)currencycode timestamp:(NSString *)timestamp;

+(NSDictionary *)searchArea;

+(NSMutableDictionary *)AllReviews:(NSString *)url;
+(NSMutableDictionary *)WriteReview:(NSString *)url;

+(NSMutableDictionary *)crmEnroll;

@end
