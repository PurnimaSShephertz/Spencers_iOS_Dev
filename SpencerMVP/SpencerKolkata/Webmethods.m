//
//  Webmethods.m
//  CustomMenu
//
//  Created by Binary Semantics on 6/10/15.
//  Copyright (c) 2015 Binarysemantics . All rights reserved.
//

#import "Webmethods.h"
#import  "SBJson.h"
#import "AppDelegate.h"
#import "AFOAuth1Client.h"
#import "TWMessageBarManager.h"
#import "Const.h"
@implementation Webmethods

//pthakur@rp-sg.in
//123456


+(BOOL)checkNetwork
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
  
    
    if (networkStatus == ReachableViaWWAN)
    {
        
        return YES;
        
    }
    else if (networkStatus == ReachableViaWiFi)
    {
        return YES;
        
    }
    else if (networkStatus == NotReachable)
    {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error"
                                                       description:@"Please check your internet connection"
                                                              type:TWMessageBarMessageTypeInfo];
        
        return NO;
    }
    return YES;
}

+(NSDictionary *)RegistrationMethod:(NSString *)firstname andlastname:(NSString *)lastname andemail:(NSString *)email andpassword:(NSString *)password crmid:(NSString *)crmid mobile:(NSString *)mobile
{
    
    //    http://192.168.2.132/spencer/index.php/api/rest/register?store=14
    
    //    {"firstname":"Nipun","lastname":"Gogia","email":"er.nipungogia@gmail.com","password":"qwerty",
    //        "crmid":"", "mobile":"9953920555"}
    
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"firstname\":\"%@\",\"lastname\":\"%@\",\"email\":\"%@\",\"password\":\"%@\",\"crmid\":\"%@\",\"mobile\":\"%@\"}",firstname,lastname,email,password, crmid, mobile];
    //NSLog(@"Request: %@", jsonRequest);
    
    //    NSURL *url = [NSURL URLWithString:@"http://apis.spencers.in/api/rest/register"];
    
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", baseUrl, regist]];
    
    NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/register?store=%@", baseUrl1, storeIdStr]];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    if(data==NULL || [data isEqual:@""])
    {
        UIAlertView * alertViewnew = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"Please Retry" delegate:self
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        [alertViewnew show];
        
    }
    return (NSDictionary*)[data JSONValue];
    
    
    
    
}


+(NSDictionary *)OtpVerify:(NSString *)otp andemail:(NSString *)email firstName:(NSString *)firstName lastName:(NSString *)lastName mobileNumber:(NSString *)mobileNumber password:(NSString *)password crmid:(NSString *)crmid
{
    
    //    http://192.168.2.132/spencer/index.php/api/rest/register?store=14
    
    //    {"firstname":"Nipun","lastname":"Gogia","email":"er.nipungogia@gmail.com","password":"qwerty",
    //        "crmid":"", "mobile":"9953920555"}
    
    
//    NSString *jsonRequest = [NSString stringWithFormat:@"{\"mobile\":\"%@\",\"otp\":\"%@\"}",email,otp];
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"firstname\":\"%@\",\"lastname\":\"%@\",\"email\":\"%@\",\"password\":\"%@\",\"crmid\":\"%@\",\"mobile\":\"%@\",\"otp\":\"%@\"}",firstName,lastName,email, password, crmid, mobileNumber, otp];
    
    //NSLog(@"Request: %@", jsonRequest);
    
    //    NSURL *url = [NSURL URLWithString:@"http://apis.spencers.in/api/rest/register"];
    
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", baseUrl, regist]];
    
    
    NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/otpverify?store=%@", baseUrl1, storeIdStr]];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:requestData];
    
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    if(data==NULL || [data isEqual:@""])
    {
        UIAlertView * alertViewnew = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"Please Retry" delegate:self
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        [alertViewnew show];
        
    }
    return (NSDictionary*)[data JSONValue];
    
    
    
    
}
+(NSDictionary *)ResendOTP:(NSString *)email mobile:(NSString *)mobile
{
    
    //    http://192.168.2.132/spencer/index.php/api/rest/register?store=14
    
    //    {"firstname":"Nipun","lastname":"Gogia","email":"er.nipungogia@gmail.com","password":"qwerty",
    //        "crmid":"", "mobile":"9953920555"}
    
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"email\":\"%@\",\"mobile\":\"%@\"}",email,mobile];
    //NSLog(@"Request: %@", jsonRequest);
    
    //    NSURL *url = [NSURL URLWithString:@"http://apis.spencers.in/api/rest/register"];
    
    //    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", baseUrl, regist]];
    
    NSString * storeIdStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/otpresend?store=%@", baseUrl1, storeIdStr]];
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    if(data==NULL || [data isEqual:@""])
    {
        UIAlertView * alertViewnew = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"Please Retry" delegate:self
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        [alertViewnew show];
        
    }
    return (NSDictionary*)[data JSONValue];
    
    
    
    
}

+(NSDictionary *)LoginMethod:(NSString *)email andpassword:(NSString *)password andconsumerkey:(NSString *)consumerkey andconsumersecret:(NSString *)consumersecret and:(NSString *)deviceid
{
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"email\":\"%@\",\"password\":\"%@\",\"consumerkey\":\"%@\",\"consumersecret\":\"%@\",\"deviceid\":\"%@\"}",email,password,consumerkey,consumersecret,deviceid];
   
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", baseUrl1, login]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
        
    if(data==NULL || [data isEqual:@""])
    {
        UIAlertView * alertViewnew = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"Please Retry" delegate:self
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        [alertViewnew show];
        
    }
    return (NSDictionary*)[data JSONValue];
  
}

+(NSDictionary *)Getcustmer
{
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
      oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSMutableURLRequest * request = [oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@/profile", baseUrl1] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSDictionary*)[data JSONValue];
}

+(NSDictionary *)UpdateCustomer:(NSString *)URL andDict:(NSString * )firstname andLastName:(NSString *)lastname andEmail:(NSString * )email crmid:(NSString *)crmid mobile:(NSString *)mobileNumber otp:(NSString *)otp
{
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/customers/4", baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"firstname\":\"%@\",\"lastname\":\"%@\",\"email\":\"%@\",\"crmid\":\"%@\",\"mobile\":\"%@\",\"otp\":\"%@\"}",firstname,lastname,email, crmid, mobileNumber, otp];
    
    NSMutableURLRequest * request = [oAuth1Client requestWithMethod:@"PUT" path:[NSString stringWithFormat:@"%@",URL] parameters:nil];
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSDictionary*)[data JSONValue];
}


+(NSDictionary *)UpdateCustomer:(NSString *)URL andDict:(NSString * )firstname andLastName:(NSString *)lastname andEmail:(NSString * )email crmid:(NSString *)crmid mobile:(NSString *)mobileNumber
{
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/customers/4", baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"firstname\":\"%@\",\"lastname\":\"%@\",\"email\":\"%@\",\"crmid\":\"%@\",\"mobile\":\"%@\"}",firstname,lastname,email, crmid, mobileNumber];
    
    NSMutableURLRequest * request = [oAuth1Client requestWithMethod:@"PUT" path:[NSString stringWithFormat:@"%@",URL] parameters:nil];
    
     NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSDictionary*)[data JSONValue];
}

+(NSMutableDictionary * )myorders
{
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
//    store=%@",
//    [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]
    
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@/orders?store=%@", baseUrl1, [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    if(data==NULL || [data isEqual:@""])
    {
        UIAlertView * alertViewnew = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"Please Retry" delegate:self
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        [alertViewnew show];
        
    }
    return (NSMutableDictionary *)[data JSONValue];
}

+(NSDictionary *)DeletewishlistRecord:(NSString *)itemid
{
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"itemid\":\"%@\"}",itemid];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@/wishlist/remove", baseUrl1] parameters:nil];
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSDictionary*)[data JSONValue];
}

+(NSMutableDictionary *)GetcartData_Login
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSMutableURLRequest * request = [oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@/cart?store=%@&cartid=%@", baseUrl1,[[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"], [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSMutableDictionary*)[data JSONValue];
}

+(NSMutableDictionary *)GetcartData_LoginAfterLogin: (NSString *)cartId
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret = [temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@/cart?store=%@&cartid=%@", baseUrl1, [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"], cartId ] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSMutableDictionary*)[data JSONValue];
}


+(NSMutableDictionary *)AddtoCart_Login:(NSString *)url
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];

    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", url] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSMutableDictionary*)[data JSONValue];
}
+(NSMutableDictionary *)AddCoupon:(NSString *)url
{
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", url] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSMutableDictionary*)[data JSONValue];
}

+(NSMutableDictionary *)RemoveCoupon_Login
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@/cart/coupon?task=remove&store=%@", baseUrl1, [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSMutableDictionary*)[data JSONValue];
}

+(NSMutableArray *)GetAll_Address:(NSString *)URL
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", URL] parameters:nil];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    NSMutableArray * array = (NSMutableArray*)[data JSONValue];
    //[[NSUserDefaults standardUserDefaults] setObject:(NSMutableDictionary*)[data JSONValue] forKey:@"dictionaryKey"];
    
    return array;
    
    
}

+(NSDictionary *)Addaddress:(NSString *)URL andDict:(NSString * )firstname andLastName:(NSString *)lastname andcity:(NSString * )city andregion:(NSString *)region andpostcode:(NSString *)postcode andcountry_id:(NSString *)country_id andtelephone:(NSString *)telephone andstreet:(NSMutableArray *)street
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"http://meragrocer.com/uat/"] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    NSString * datastr=[street JSONRepresentation];
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"firstname\":\"%@\",\"lastname\":\"%@\",\"city\":\"%@\",\"region\":\"%@\",\"postcode\":\"%@\",\"country_id\":\"%@\",\"telephone\":\"%@\",\"street\":%@}",firstname,lastname,city,region,postcode,country_id,telephone,datastr];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"POST" path:[NSString stringWithFormat:@"%@",URL] parameters:nil];
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSDictionary*)[data JSONValue];
}
+(NSDictionary *)UpdateAddress:(NSString *)URL andDict:(NSString * )firstname andLastName:(NSString *)lastname andcity:(NSString * )city andregion:(NSString *)region andpostcode:(NSString *)postcode andcountry_id:(NSString *)country_id andtelephone:(NSString *)telephone andstreet:(NSMutableArray *)street
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"http://meragrocer.com/uat/"] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    NSString * datastr=[street JSONRepresentation];
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"firstname\":\"%@\",\"lastname\":\"%@\",\"city\":\"%@\",\"region\":\"%@\",\"postcode\":\"%@\",\"country_id\":\"%@\",\"telephone\":\"%@\",\"street\":%@}",firstname,lastname,city,region,postcode,country_id,telephone,datastr];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"PUT" path:[NSString stringWithFormat:@"%@",URL] parameters:nil];
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSDictionary*)[data JSONValue];
}

+(NSMutableDictionary *)DeleteAddress:(NSString *)URL
{
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"DELETE" path:[NSString stringWithFormat:@"%@", URL] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSMutableDictionary*)[data JSONValue];
}


+(NSDictionary *)moveToCart:(NSString *)URL
{
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", URL] parameters:nil];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    return (NSDictionary*)[data JSONValue];
}
+(NSDictionary *)removeFromCart:(NSString *)URL
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", URL] parameters:nil];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    return (NSDictionary*)[data JSONValue];
}

+(NSDictionary *)moveAllToCart
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@/wishlist/addalltocart", baseUrl1] parameters:nil];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    return (NSDictionary*)[data JSONValue];
}

+(NSDictionary *)DeleteItemFromCart:(NSString *)URL
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", URL] parameters:nil];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    return (NSDictionary*)[data JSONValue];
}

+(NSDictionary *)updateItemFromCart:(NSString *)URL
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", URL] parameters:nil];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    return (NSDictionary*)[data JSONValue];
}

/*
+(NSDictionary *)createorder:(NSString *)billtoid andshiptoid:(NSString *)shiptoid andpayby:(NSString *)payby anddate:(NSString *)date andslotid:(NSString *)slotid andcredits:(NSString *)credits andCrmCredit:(NSString *)crmCredit
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"http://meragrocer.com/uat/"] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"billtoid\":\"%@\",\"shiptoid\":\"%@\",\"payby\":\"%@\",\"date\":\"%@\",\"slotid\":\"%@\",\"credits\":\"%@\",\"crmcredits\":\"%@\"}",billtoid,shiptoid,payby,date,slotid,credits, crmCredit];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"POST" path:[NSString stringWithFormat:@"%@/createorder?store=%@", baseUrl1,[[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]] parameters:nil];
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSDictionary*)[data JSONValue];
}
*/

+(NSDictionary *)createorder:(NSString *)billtoid andshiptoid:(NSString *)shiptoid andpayby:(NSString *)payby anddate:(NSString *)date andslotid:(NSString *)slotid andcredits:(NSString *)credits andCrmCredit:(NSString *)crmCredit is_card:(NSString *)is_card
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"http://meragrocer.com/uat/"] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"billtoid\":\"%@\",\"shiptoid\":\"%@\",\"payby\":\"%@\",\"date\":\"%@\",\"slotid\":\"%@\",\"credits\":\"%@\",\"crmcredits\":\"%@\",\"iscard\":\"%@\"}",billtoid, shiptoid, payby, date, slotid, credits, crmCredit, is_card];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"POST" path:[NSString stringWithFormat:@"%@/createorder?store=%@", baseUrl1,[[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]] parameters:nil];
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSDictionary*)[data JSONValue];
}

+(NSDictionary *) editOrder: (NSString *)entityId
{
    
    
    
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@/editorder/%@?store=%@", baseUrl1, entityId, [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]];
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", urlString] parameters:nil];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    return (NSDictionary*)[data JSONValue];
    
    
}

+(NSDictionary *) reorderOrder: (NSString *)entityId
{
    
    
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@/reorder/%@?store=%@", baseUrl1, entityId,[[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]];
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", urlString] parameters:nil];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
    return (NSDictionary*)[data JSONValue];
    

}

+(NSDictionary *)GetSlots
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@/getslots?store=%@", baseUrl1, [[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]] parameters:nil];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    return (NSDictionary*)[data JSONValue];
}
+(NSDictionary *)Updatepassword:(NSString *)password
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/customers/4", baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"password\":\"%@\"}",password];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"PUT" path:[NSString stringWithFormat:@"%@/changepassword", baseUrl1] parameters:nil];
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSDictionary*)[data JSONValue];
}

+(NSMutableDictionary *)getwallet
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSMutableURLRequest * request = [oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@/wallet", baseUrl1] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSMutableDictionary*)[data JSONValue];
}

+(NSDictionary *)recahrge:(NSString *)code
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:@"http://meragrocer.com/uat/"] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"code\":\"%@\"}",code];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"POST" path:[NSString stringWithFormat:@"%@/wallet", baseUrl1] parameters:nil];
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSDictionary*)[data JSONValue];
}


+(NSDictionary *)sorting:(NSString *)URL
{
    

    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", URL] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSMutableDictionary*)[data JSONValue];
}


+(NSDictionary *)forgotpassword:(NSString *)Email
{
    
    

    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"email\":\"%@\"}",Email];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/forgotpassword", baseUrl1]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    if(data==NULL || [data isEqual:@""])
    {
        UIAlertView * alertViewnew = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"Please Retry" delegate:self
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        [alertViewnew show];
        
    }
    return (NSMutableDictionary*)[data JSONValue];
}


+(NSDictionary *)Newsletter:(NSString *)is_subscribe
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/customers/4", baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"is_subscribe\":\"%@\"}",is_subscribe];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"PUT" path:[NSString stringWithFormat:@"%@/subscribe", baseUrl1] parameters:nil];
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSDictionary*)[data JSONValue];
    
}


+(NSDictionary *)getCartWishlist
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@/startups?store=%@&cartid=%@", baseUrl1,[[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"], [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"]] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSDictionary*)[data JSONValue];
}



+(NSDictionary *)getCartWishlist:(NSString *)URL
{
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@",URL] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSDictionary*)[data JSONValue];
}




+(NSDictionary *)product:(NSString *)URL
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", URL] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
//    BOOL reach = [Webmethods checkNetwork];
//    if (reach == NO) {
//        return NO;
//    }
//    
//    if (reach == YES && (data == NULL || [data isEqual:@""]) )
//    {
//        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error"
//                                                       description:@"Please check your internet connection"
//                                                              type:TWMessageBarMessageTypeInfo];
//        
//        return NO;
//    }
    
    if(data==NULL || [data isEqual:@""])
    {
        UIAlertView * alertViewnew = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"Please Retry" delegate:self
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertViewnew show];
        
    }
    return (NSDictionary*)[data JSONValue];
}


+(NSDictionary *)search:(NSString *)URL
{

    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", URL] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
//    BOOL reach = [Webmethods checkNetwork];
//    if (reach == NO) {
//        return NO;
//    }
    
    if( data==NULL || [data isEqual:@""])
    {
        UIAlertView * alertViewnew = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"Please Retry" delegate:self
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertViewnew show];
    }
    return (NSDictionary*)[data JSONValue];
}




+(NSMutableDictionary *)applyWallet:(NSString *)credit
{
    
    
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@/wallet/apply?credits=%@&cartid=%@&store=%@", baseUrl1,credit, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"],[[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]];
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    NSMutableURLRequest * request = [oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", urlString] parameters:nil];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    return (NSMutableDictionary*)[data JSONValue];

}


+(NSMutableDictionary *)applySRC:(NSString *)credit
{
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@/wallet/crmapply?crmcredits=%@&cartid=%@&store=%@", baseUrl1,credit, [[NSUserDefaults standardUserDefaults] valueForKey:@"globalcartid"],[[NSUserDefaults standardUserDefaults] valueForKey:@"store_id_token"]];
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", urlString] parameters:nil];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    return (NSMutableDictionary*)[data JSONValue];
    
}



+(NSMutableDictionary *)pin:(NSString *)url
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", url] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSMutableDictionary*)[data JSONValue];
}


+(NSMutableDictionary *)searchResult:(NSString *)q storeid:(NSString *)storeid customergroupid:(NSString *)customergroupid storetimestamp:(NSString *)storetimestamp currencycode:(NSString *)currencycode timestamp:(NSString *)timestamp
{
    NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                 NULL,
                                                                                                 (CFStringRef)q,
                                                                                                 NULL,
                                                                                                 (CFStringRef)@"<>",
                                                                                                 kCFStringEncodingUTF8));
    NSString *jsonRequest = [NSString stringWithFormat:@"{\"q\":\"%@\",\"storeid\":\"%@\",\"customergroupid\":\"%@\",\"storetimestamp\":\"%@\",\"currencycode\":\"%@\",\"timestamp\":\"%@\"}", urlEncoded, storeid, @"0", @"1466176750", @"INR", @"1466156966987"];
    //NSLog(@"Request: %@", jsonRequest);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@sb.php",baseUrl1]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    
    
    if(data==NULL || [data isEqual:@""])
    {
        UIAlertView * alertViewnew = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"Please Retry" delegate:self
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
        [alertViewnew show];
        
    }
    return (NSDictionary*)[data JSONValue];
}

+(NSDictionary *)searchArea
{
    if ([self checkNetwork])
    {
//        NSDictionary *countryDataDict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:area]] options:NSJSONReadingMutableContainers error:nil];
//        return  (NSDictionary *)countryDataDict;
    
        NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:area]];
        NSURLResponse * response = nil;
        NSError * error = nil;
        NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                              returningResponse:&response
                                                          error:&error];
        
        if (error == nil)
        {
            NSError *jsonError = nil;
            NSDictionary * countryDataDict= [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            return  (NSDictionary *)countryDataDict;
        }
        
        
    }
    return nil;
}


+(NSMutableDictionary *)AllReviews:(NSString *)url
{
    
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseBannerUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", url] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSMutableDictionary*)[data JSONValue];
}
+(NSMutableDictionary *)WriteReview:(NSString *)url
{
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    
    AFOAuth1Client *oAuth1Client;
    
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",baseBannerUrl1]] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", url] parameters:nil];
    
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    
    return (NSMutableDictionary*)[data JSONValue];
}



+(NSMutableDictionary *)crmEnroll
{
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@/wallet/crmenroll", baseUrl1];
    
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
    NSString * oauth_token_secret =[temp objectForKey:@"oauth_token_secret"];
    if(oauth_token==NULL || [oauth_token isEqual:@""])
    {
        return nil;
    }
    AFOAuth1Client *oAuth1Client;
    oAuth1Client = [[AFOAuth1Client alloc] initWithBaseURL:[NSURL URLWithString:baseUrl1] key:@"5af68ccf03ca66408af33172f12f2368" secret:@"4ed930e6f69eb3d8bcfd78dbd1f2f329"];
    [oAuth1Client setDefaultHeader:@"Accept" value:@"application/json"];
    [oAuth1Client setSignatureMethod:AFPlainTextSignatureMethod];
    [oAuth1Client setAccessToken:[[AFOAuth1Token alloc] initWithKey:oauth_token secret:oauth_token_secret session:nil expiration:nil renewable:FALSE]];
    [oAuth1Client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    NSMutableURLRequest * request =[oAuth1Client requestWithMethod:@"GET" path:[NSString stringWithFormat:@"%@", urlString] parameters:nil];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *data=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    return (NSMutableDictionary*)[data JSONValue];
    
}



@end
