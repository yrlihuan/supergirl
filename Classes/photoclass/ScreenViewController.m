//
//  ScreenViewController.m
//  SuperGirl_11_01
//
//  Created by xiaojia liu on 11-11-7.
//  Copyright 2011年 looa. All rights reserved.
//

#import "ScreenViewController.h"
#define duration 0.5

@implementation ScreenViewController


@synthesize timeReveal,dateReveal,departureButton,lockButton,pictureView;
@synthesize thisFather;
@synthesize picNames;

const int timerInterval = 4;                    //this is the time interval
const int pictureAmount = 10;

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
- (IBAction)viewDeparture:(UIButton *)sender
{
    departureFlag = false;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [thisFather dismissModalViewControllerAnimated:YES];    
}
- (IBAction)viewLocked:(UIButton *)sender
{
    lockedFlag = !lockedFlag;
    if (lockedFlag)
    {
        [lockButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"lock.png"]] forState:UIControlStateNormal];
    }
    else
        [lockButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"unlock.png"]] forState:UIControlStateNormal];        
}
- (void)startAnimate
{
    [self setCalendar];
    departureFlag = true;
    lockedFlag = false;
    pictureIndex = arc4random()%pictureAmount + 1;
    //pictureIndex = 1;
    secondCount = timerInterval;
    [self tickTick];
    return;
}

#pragma mark - View lifecycle


- (void)setCalendar
{    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit| NSWeekCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;    
    NSDate *thisDate = [NSDate date];
    
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:thisDate];
    
    NSInteger year = dateComponents.year;
    NSInteger month = dateComponents.month;
    NSInteger day = dateComponents.day;
    NSInteger hour = dateComponents.hour;
    NSInteger minute = dateComponents.minute;
    NSString *dayString = [NSString stringWithFormat: @"%02d",day];
    NSString *monthString = [NSString stringWithFormat: @"%02d",month];
    NSString *dateString = [NSString stringWithFormat:@"%@/%@/%d",dayString,monthString,year];
    
    NSString *minuteString = [NSString stringWithFormat:  @"%02d",minute];
    NSString *hourString = [NSString stringWithFormat:  @"%02d",hour];
    NSString *timeString = [NSString stringWithFormat:@"%@:%@",hourString,minuteString];
    
    [dateReveal setText:dateString];
    [timeReveal setText:timeString];
}
- (void)changePicture
{
    /*
    kCATransitionFade淡出
    kCATransitionMoveIn覆盖原图
    kCATransitionPush推出
    kCATransitionReveal底部显出来
    setSubtype:也可以有四种类型：
    kCATransitionFromRight；
    kCATransitionFromLeft(默认值)
    kCATransitionFromTop；
    kCATransitionFromBottom
     */
    CATransition *animation = [CATransition animation];
    [animation setDuration:duration];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setType:kCATransitionFade];
    //[animation setSubtype: kCATransitionFromBottom];
    [self.pictureView.layer addAnimation:animation forKey:@"Reveal"];
    
    
    NSString *tmpName = [picNames objectAtIndex:pictureIndex-1];
    UIImage *thisImage = [UIImage imageNamed:tmpName];
    [pictureView setImage:thisImage];
    pictureIndex ++;
    if (pictureIndex > pictureAmount)
        pictureIndex = 1;
}
- (void)tickTick
{
    if (departureFlag == false)
        return;
    
    if (lockedFlag == false)
    {
        if (secondCount == timerInterval)
        {            
            [self changePicture];
            secondCount = 0;
        }
        else
            secondCount ++;
    }
    int temp = [[NSDate date] timeIntervalSince1970];
    if (temp % 60 == 0)
        [self setCalendar];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(tickTick) userInfo:nil repeats:NO];
}
- (void)firstInit
{
    picNames = [[NSArray alloc] initWithObjects:@"01dlx-1.jpg",@"01dlx-2.jpg",@"02hc-1.jpg",@"02hc-2.jpg",@"03lx-1.jpg",@"03lx-2.jpg",@"04sml-1.jpg",@"04sml-2.jpg",@"05yy-1.jpg",@"05yy-2.jpg", nil];
    [self.view setFrame:CGRectMake(0, 0, 320, 480)];
    [pictureView setFrame:CGRectMake(0, 0, 320, 480)];
    pictureIndex = 1;
    [self changePicture];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [timeReveal release];
    [dateReveal release];
    [departureButton release];
    [lockButton release];
    [pictureView release];
    [thisFather release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
