//
//  LandingPage.m
//  Spencer
//
//  Created by Binary Semantics on 7/5/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "LandingPage.h"
#import "FirstLaunchScreen.h"
@interface LandingPage ()

@end

@implementation LandingPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
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

- (IBAction)GetStarted_Act:(UIButton *)sender
{
    FirstLaunchScreen * firstlaunch=[[FirstLaunchScreen alloc]initWithNibName:@"FirstLaunchScreen" bundle:nil];
    [self.navigationController pushViewController:firstlaunch animated:YES];
}
@end
