//
//  writeReviewViewController.m
//  Spencer
//
//  Created by Binary Semantics on 9/2/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "writeReviewView.h"
#import "IQKeyboardManager.h"
#import "Webmethods.h"
#import "AppDelegate.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "Webmethods.h"
#import "SVProgressHUD.h"
@interface writeReviewView ()

@end

@implementation writeReviewView
@synthesize rateView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.rateView.notSelectedImage = [UIImage imageNamed:@"kermit_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"kermit_full.png"];
    self.rateView.rating = 0;
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
    [topimage setBackgroundColor:kColor_Orange];
    [[IQKeyboardManager sharedManager] setEnable:TRUE];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:TRUE];
    
    CommenttextView.text = @"Review";
    CommenttextView.textColor = [UIColor lightGrayColor];
    CommenttextView.delegate = self;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField== title_txt) {
        
    }
    if(CommenttextView.text.length == 0){
        CommenttextView.textColor = [UIColor lightGrayColor];
        CommenttextView.text = @"Review (Optional)";
        [CommenttextView resignFirstResponder];
    }
   
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (CommenttextView.textColor == [UIColor lightGrayColor])
    {
        CommenttextView.text = @"";
        CommenttextView.textColor = [UIColor blackColor];
    }
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(CommenttextView.text.length == 0){
        CommenttextView.textColor = [UIColor lightGrayColor];
        CommenttextView.text = @"Review (Optional)";
        [CommenttextView resignFirstResponder];
    }
    else{
        CGFloat fixedWidth = CommenttextView.frame.size.width;
        CGSize newSize = [CommenttextView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
        CGRect newFrame = CommenttextView.frame;
        newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
        CommenttextView.frame = newFrame;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(CommenttextView.text.length == 0){
            CommenttextView.textColor = [UIColor lightGrayColor];
            CommenttextView.text = @"Review (Optional)";
            [CommenttextView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}

-(IBAction)cancle_act:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated: YES completion: nil];
}
-(IBAction)Send_act:(id)sender
{
//    sendBtnObj.userInteractionEnabled = NO;
    NSUserDefaults *temp=[NSUserDefaults standardUserDefaults];
    NSString * oauth_token =[temp objectForKey:@"oauth_token"];
//    
//    if(oauth_token==NULL || [oauth_token isEqual:@""])
//    {
    
        BOOL reach = [Webmethods checkNetwork];
        if (reach == NO)
        {
            return ;
        }
        
        
        if ([title_txt.text isEqualToString:@""])
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter title."]];
            sendBtnObj.userInteractionEnabled = YES;
            return ;
        }
        if ([CommenttextView.text isEqualToString:@""])
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please enter comment."]];
            sendBtnObj.userInteractionEnabled = YES;
            return ;
        }
        if (result == 0)
        {
            [self.view addSubview:[[ToastAlert alloc] initWithText:@"Please select star rating"]];
            sendBtnObj.userInteractionEnabled = YES;
        return ;
        }
    
        NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"];
        [SVProgressHUD show];
    
    
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:baseBannerUrl1]];
        [httpClient setParameterEncoding:AFFormURLParameterEncoding];
        NSMutableURLRequest *request;
    
       if(oauth_token==NULL || [oauth_token isEqual:@""])
       {
           NSString *pathStr = [NSString stringWithFormat:@"%@/review/update?sku=%@&title=%@&nickname=%@&detail=%@&rating=%d",baseUrl1,_sku_Str,title_txt.text,@"Guest",CommenttextView.text, result];
           NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                        NULL,
                                                                                                        (CFStringRef)pathStr,
                                                                                                        NULL,
                                                                                                        (CFStringRef)@"<>",
                                                                                                        kCFStringEncodingUTF8));
           request = [httpClient requestWithMethod:@"GET" path:urlEncoded  parameters:nil];
       }
       else
       {
           NSString *pathStr = [NSString stringWithFormat:@"%@/review/update?sku=%@&title=%@&nickname=%@&detail=%@&rating=%d",baseUrl1,_sku_Str,title_txt.text,[[userDict valueForKey:@"data"] valueForKey:@"firstname"],CommenttextView.text, result ];
           NSString *urlEncoded = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                        NULL,
                                                                                                        (CFStringRef)pathStr,
                                                                                                        NULL,
                                                                                                        (CFStringRef)@"<>",
                                                                                                        kCFStringEncodingUTF8));
           request = [httpClient requestWithMethod:@"GET"
                                              path:urlEncoded
                                        parameters:nil];
       }
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSError *jsonError = nil;
             id result = [NSJSONSerialization JSONObjectWithData:responseObject options:2 error:&jsonError];
             
//             sendBtnObj.userInteractionEnabled = YES;
             if ([result isKindOfClass:[NSDictionary class]])
             {
                 if([[result valueForKey:@"status"] integerValue] == 1)
                 {
                     [self.view addSubview:[[ToastAlert alloc] initWithText:[result valueForKey:@"message"]]];
                     
                     [self performSelector:@selector(getDataSelector) withObject:nil afterDelay:2];
                     
                 }
                 else
                 {
                     [self.view addSubview:[[ToastAlert alloc] initWithText:[result valueForKey:@"message"]]];
                 }
             }
             else{
                 [self.view addSubview:[[ToastAlert alloc] initWithText:[result valueForKey:@"message"]]];
             }
             
             
             [SVProgressHUD dismiss];
         }
         
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
//             NSLog(@"Error: %@", error);
             [SVProgressHUD dismiss];
         }];
        
        [operation start];
//    }
//    else{
//         NSDictionary *userDict = [[NSUserDefaults standardUserDefaults] valueForKey:@"CustomerDict"];
//        
//        NSMutableDictionary * result=[[NSMutableDictionary alloc]init];
//       result= [Webmethods WriteReview:[NSString stringWithFormat:@"%@/review/update?sku=%@&title=%@&nickname=%@&detail=%@",baseUrl1,_sku_Str,title_txt.text,[[userDict valueForKey:@"data"] valueForKey:@"firstname"],CommenttextView.text]];
//        if ([result isKindOfClass:[NSDictionary class]])
//        {
//            if([[result valueForKey:@"status"] integerValue] == 1)
//            {
//                [self.view addSubview:[[ToastAlert alloc] initWithText:[result valueForKey:@"message"]]];
//                
//                [self performSelector:@selector(getDataSelector) withObject:nil afterDelay:2];
//                
//            }
//            else
//            {
//                [self.view addSubview:[[ToastAlert alloc] initWithText:[result valueForKey:@"message"]]];
//            }
//        }
//        else{
//            [self.view addSubview:[[ToastAlert alloc] initWithText:[result valueForKey:@"message"]]];
//        }
//
//    }
//    
    
    
    
    

}

-(void)getDataSelector
{
    sendBtnObj.userInteractionEnabled = YES;
    [self.presentingViewController dismissViewControllerAnimated:YES completion: nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[IQKeyboardManager sharedManager] setEnable:FALSE];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:FALSE];
}

- (void)viewDidUnload
{
    [self setRateView:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating
{
    result = (int)rating;
    ratecount.text = [NSString stringWithFormat:@"Rating: %i", result];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
