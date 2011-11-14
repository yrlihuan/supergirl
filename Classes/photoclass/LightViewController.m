//
//  LightViewController.m
//  SuperGirl_11_01
//
//  Created by xiaojia liu on 11-11-12.
//  Copyright 2011年 looa. All rights reserved.
//

#import "LightViewController.h"


@implementation LightViewController
@synthesize navigationBar;
@synthesize thisScrollView;
@synthesize thisFather;

- (void)viewDidLoad
{
    thisAlpha = 0.5;
    navigationBar.alpha = thisAlpha;
    [self.view setFrame:CGRectMake(0, 0, 320, 480)];
    [thisScrollView setBackgroundColor:[UIColor blackColor]];
    [thisScrollView setCanCancelContentTouches:NO];
    thisScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    thisScrollView.clipsToBounds = NO;
    thisScrollView.scrollEnabled = YES;    
	thisScrollView.pagingEnabled = YES;
    
    int LightSum = 17;
    [thisScrollView setContentSize:CGSizeMake(320 * LightSum, 460)];
    [thisScrollView setContentOffset:CGPointMake(0, 0)];
    NSArray *names = [[NSArray alloc] initWithObjects:@"名字--妙.jpg", @"名字--希.jpg", @"名字--希紫色.jpg",@"名字--忻.jpg",@"名字--洋.jpg",@"名字--洪.jpg",@"名字--辰.jpg",@"妙恋.jpg",@"小红帽.jpg",@"星星--紫红色.jpg",@"星星--紫色.jpg",@"星星--红色.jpg",@"星星--绿色.jpg",@"星星--蓝色.jpg",@"紫红.jpg",@"紫色.jpg",@"芯片.jpg",nil];
    for (int i = 0;i < LightSum;i ++)
    {
        UIImage * image = [UIImage imageNamed:[names objectAtIndex:i]];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
        [thisScrollView addSubview:imageView];
        [imageView setFrame:CGRectMake(i * 320, -20, 320, 480)];
        [imageView release];
    }
    [names release];
    [self.view sendSubviewToBack:thisScrollView];
    
    thisScrollView.userInteractionEnabled = YES;
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseThisImage:)];
    doubleTap.numberOfTapsRequired = 1;
    //doubleTap.delegate = self;
    [thisScrollView addGestureRecognizer:doubleTap];
    [doubleTap release];
    
}
- (void)viewDidUnload
{
    [navigationBar release];
    [thisScrollView release];
    [thisFather release];
    
}
- (void)chooseThisImage:(id)sender
{
    NSLog(@"You double click");
    beHidden = !beHidden;
    if (beHidden)
    {
        navigationBar.alpha = 0.0;
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    else
    {
        navigationBar.alpha = thisAlpha;
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
}

- (IBAction)toGetBack:(UIButton *)sender
{
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
    [thisFather dismissModalViewControllerAnimated:YES];
    [NSTimer timerWithTimeInterval:0.5 target:thisFather selector:@selector(clearPhoto) userInfo:nil repeats:NO];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
