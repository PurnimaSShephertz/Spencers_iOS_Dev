//
//  ToastAlert.m
//  IOTEX
//
//  Created by binary on 10/17/13.
//
//

#import "ToastAlert.h"
#import <QuartzCore/QuartzCore.h>

@implementation ToastAlert

#define POPUP_DELAY  1.5   //original

#define POPUP_DELAY_MESSAGE_LENGTH  4.0

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithText: (NSString*) msg
{
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        self.textColor = [UIColor colorWithWhite:1 alpha: 0.95];
        self.font = [UIFont fontWithName: @"Helvetica-Bold" size: 11];
        self.text = msg;
        
        messLength=[msg length];
        self.numberOfLines = 0;
        self.textAlignment = NSTextAlignmentCenter;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        
        self.layer.cornerRadius=12.0;
        self.layer.borderWidth=1.0;
        self.clipsToBounds = YES;
        
    }
    return self;
}

//-(void)didMoveToSuperview
- (void)didMoveToSuperview
{
    
    UIView* parent = self.superview;

    if(parent)
    {
        int i = [[[NSUserDefaults standardUserDefaults] valueForKey:@"toast"] intValue];
        
        CGSize maximumLabelSize = CGSizeMake(300, 200);
        CGSize expectedLabelSize = [self.text sizeWithFont: self.font  constrainedToSize:maximumLabelSize lineBreakMode: NSLineBreakByTruncatingTail];
        
        expectedLabelSize = CGSizeMake(expectedLabelSize.width + 20, expectedLabelSize.height + 10);
        if (i == 1)
        {
            if (expectedLabelSize.width > 20)
            {
                
           
                if (expectedLabelSize.width <= 50)
                {
//                    self.frame = CGRectMake(200,224,50,26);
                    self.frame = CGRectMake((parent.bounds.size.width/2) - 25,parent.bounds.size.height - (25 * 3),50,26);
                }
                else
                {
               
                    self.frame = CGRectMake((parent.bounds.size.width/2) - (expectedLabelSize.width/2),
                                        parent.bounds.size.height - (expectedLabelSize.height * 4),
                                        expectedLabelSize.width,
                                        expectedLabelSize.height);
                }
            }
            else
            {
                self.frame = CGRectMake(0,0,0,0);
            }
        }
        else
        {
            self.frame = CGRectMake((parent.bounds.size.width/2) - (expectedLabelSize.width/2),
                                   (parent.bounds.size.height - (expectedLabelSize.height * 4)),
                                    expectedLabelSize.width,
                                    expectedLabelSize.height);
        }
        
        
//        CALayer *layer = self.layer;
//        layer.cornerRadius = 10.0f;
//          self.clipsToBounds = YES;
        if(messLength>10)
            
            [self performSelector:@selector(dismiss:) withObject:nil afterDelay:POPUP_DELAY_MESSAGE_LENGTH];

        else
            
        [self performSelector:@selector(dismiss:) withObject:nil afterDelay:POPUP_DELAY];
    }
}

- (void)dismiss:(id)sender
{
    // Fade out the message and destroy self
    [UIView animateWithDuration:0.6  delay:0 options: UIViewAnimationOptionAllowUserInteraction
                     animations:^  { self.alpha = 0; }
                     completion:^ (BOOL finished)
    {
        [self removeFromSuperview]; }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
