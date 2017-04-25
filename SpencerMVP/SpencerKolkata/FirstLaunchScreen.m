//
//  FirstLaunchScreen.m
//  Spencer
//
//  Created by Binary Semantics on 7/4/16.
//  Copyright © 2016 Binary. All rights reserved.
//

#import "FirstLaunchScreen.h"
#import "Const.h"
#import "LoginVC.h"
@interface FirstLaunchScreen ()
{
    int lastPage;
}
@end

@implementation FirstLaunchScreen

- (void)viewDidLoad
{
    [super viewDidLoad];

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    
    NSMutableArray * colorArray =[NSMutableArray arrayWithObjects:
                                [UIColor colorWithRed: 229/255.0 green:148/255.0 blue:60/255.0 alpha:1.0],
                                [UIColor colorWithRed: 215/255.0 green:190/255.0 blue: 72/255.0 alpha:1.0],
                                [UIColor colorWithRed: 130/255.0 green: 189/255.0 blue: 83/255.0 alpha:1.0],
                                [UIColor colorWithRed: 219/255.0 green:102/255.0 blue: 93/255.0 alpha:1.0],nil];
    
    NSArray * ScrollHeaderArr=[NSArray arrayWithObjects:@"OVER 21000 \r PRODUCTS",@"HAND-PICKED \r SPECIALLY\rFOR YOU", @"ON TIME DELIVERY,\rGUARANTEED",@"QUALITY\rSINCE 1853",nil];
    NSArray * ScrollHeaderArr2=[NSArray arrayWithObjects:@"secondback_img.png", @"firstBack_img.png",@"thirdback_img.png",@"fourthback_img.png",nil];
    
     NSArray * SubtitleArr=[NSArray arrayWithObjects:@"A wide variety of products\r to match your needs.",@"The best fresh and grocery products chosen from around the world.",@"Your grocery. At your time. Always.",@"To us, quality is not just a \rspecial promise, but a habit.",nil];
     NSArray * ImagesArr=[NSArray arrayWithObjects:@"ic_wt2.png",@"ic_wt1.png",@"ic_wt3.png",@"ic_wt4.png",nil];
    
    ScreenWidth= [UIScreen mainScreen].bounds.size.width;
    Height= [UIScreen mainScreen].bounds.size.height;
    
    scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, ScreenWidth, Height+20)];
    NSInteger viewcount= 4;
    scrollview.pagingEnabled = YES;
    scrollview.bounces = YES;
    scrollview.showsHorizontalScrollIndicator = NO;
    
    for(int i = 0; i < viewcount; i++)
    {
        CGFloat x = i * ScreenWidth;
        view = [[UIView alloc] initWithFrame:CGRectMake(x, 0,ScreenWidth, Height+20)];
        
        UIGraphicsBeginImageContext(view.frame.size);
        [[UIImage imageNamed:[ScrollHeaderArr2 objectAtIndex:i]] drawInRect:view.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        view.backgroundColor = [UIColor colorWithPatternImage:image];
        [scrollview addSubview:view];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 250, 100)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 3;
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0];
        label.center = CGPointMake(view.center.x, self.view.frame.origin.y+150);
        label.lineBreakMode = UILineBreakModeWordWrap;
        label.text =[ScrollHeaderArr objectAtIndex:i];
        [scrollview addSubview:label];
        
        
        UILabel *Line = [[UILabel alloc] initWithFrame:CGRectMake(40, label.frame.origin.y+label.frame.size.height, 260, 1)];
        Line.backgroundColor = [UIColor whiteColor];
        Line.textAlignment = NSTextAlignmentCenter;
        Line.textColor = [UIColor whiteColor];
        //Line.numberOfLines = 3;
        Line.font = [UIFont fontWithName:@"HelveticaNeue" size:20.0];
        Line.center = CGPointMake(label.center.x, label.frame.origin.y+105);
        Line.lineBreakMode = UILineBreakModeWordWrap;
//        label.text =[ScrollHeaderArr objectAtIndex:i];
        [scrollview addSubview:Line];
        
        
        UILabel *Subtitle = [[UILabel alloc] initWithFrame:CGRectMake(40, Line.frame.origin.y+Line.frame.size.height, 260, 100)];
        Subtitle.backgroundColor = [UIColor clearColor];
        Subtitle.textAlignment = NSTextAlignmentCenter;
        Subtitle.textColor = [UIColor whiteColor];
        Subtitle.numberOfLines = 3;
        Subtitle.font = [UIFont fontWithName:@"HelveticaNeue" size:14.0];
        if (Height==480)
        {
        Subtitle.center = CGPointMake(label.center.x, label.frame.origin.y+130);
        }
        else
        {
          Subtitle.center = CGPointMake(label.center.x, label.frame.origin.y+140);
        }
        
        Subtitle.lineBreakMode = UILineBreakModeWordWrap;
        Subtitle.text =[SubtitleArr objectAtIndex:i];
        [scrollview addSubview:Subtitle];
        
        UIImageView *dot;
        if (Height==480)
        {
          dot =[[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-100,50,80,80)];
        dot.center = CGPointMake(view.center.x, Subtitle.frame.origin.y);
        }
        else
        {
            dot =[[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-100,50,150,150)];
            dot.center = CGPointMake(view.center.x, Subtitle.frame.origin.y+180);
        }
        
        
        dot.center = CGPointMake(view.center.x, Subtitle.frame.origin.y+180);
        dot.image=[UIImage imageNamed:[ImagesArr objectAtIndex:i]];
        dot.contentMode = UIViewContentModeScaleToFill;
        [scrollview addSubview:dot];
        
        
        
        UIButton* Skip_obj = [[UIButton alloc] initWithFrame:CGRectMake(5,30,100,40)];
        Skip_obj.center = CGPointMake(view.center.x, Height-Height/7);
        Skip_obj.backgroundColor = [UIColor clearColor];
        [Skip_obj setTitle:@"Skip" forState:UIControlStateNormal];

        Skip_obj.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16.0];
        [Skip_obj setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [Skip_obj addTarget:self action:@selector(SkipAct:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:Skip_obj];
        
    }
    
    scrollview.contentSize = CGSizeMake(ScreenWidth*viewcount, Height);
    scrollview.delegate=self;
    [self.view addSubview:scrollview];
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0, Height-70, ScreenWidth, 20);
    
    if (IS_IPHONE_6)
    {
       pageControl.center = CGPointMake(view.frame.size.width/2+20,Height-50);
    }
    else if (IS_IPHONE_6_PLUS)
    {
        pageControl.center = CGPointMake(view.frame.size.width/2,Height-50);
    }
    else if (IS_IPHONE)
    {
       pageControl.center = CGPointMake(view.frame.size.width/2+50,Height-50);
    }
    else if (ITS_IPHONE5)
    {
       pageControl.center = CGPointMake(view.frame.size.width/2+50,Height-50);
    }
    else
    {
        pageControl.frame = CGRectMake(0, Height-70, 100, 20);
        pageControl.center = CGPointMake(self.view.frame.size.width/2,Height-50);
        
    }
    
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed: 206/255.0 green:111/255.0 blue:45/255.0 alpha:1.0];
    pageControl.currentPageIndicatorTintColor=[UIColor whiteColor];
    //pageControl.transform = CGAffineTransformMakeScale(0.7, 0.7);
    pageControl.numberOfPages = colorArray.count;
    pageControl.currentPage = 0;
    [self.view bringSubviewToFront:pageControl];
    [self.view addSubview:pageControl];
    
    // Do any additional setup after loading the view from its nib.
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollview.frame.size.width; // you need to have a **iVar** with getter for scrollView
    float fractionalPage = scrollview.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page;
//    NSLog(@"page %ld", (long)page);
    
    if ( (lastPage == page) && lastPage == 3)
    {
        LoginVC *loginVC = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
    lastPage = (int)page;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat pageWidth = scrollview.frame.size.width; // you need to have a **iVar** with getter for scrollView
//    float fractionalPage = scrollview.contentOffset.x / pageWidth;
//    NSInteger page = lround(fractionalPage);
//    pageControl.currentPage = page;
    
    
    if (scrollView.contentSize.width>scrollView.frame.size.width)
    {
//        NSLog(@"Yes");
        scrollView.scrollEnabled = YES;
    }
    else {
//        NSLog(@"No");
        scrollView.scrollEnabled = NO;
    }
    
    
    // you need to have a **iVar** with getter for pageControl
}
-(void)SkipAct:(id)sender
{
    LoginVC *loginVC = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];
    [self.navigationController pushViewController:loginVC animated:YES];
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

@end
