//
//  ScreenViewController.m
//  SuperGirl_11_01
//
//  Created by xiaojia liu on 11-11-7.
//  Copyright 2011年 looa. All rights reserved.
//

#import "ScreenViewController.h"

@implementation ScreenViewController


@synthesize  timeReveal,dateReveal,departureButton,lockButton,pictureView;
@synthesize  thisFather;

const int timerInterval = 1;                    //this is the time interval
const int pictureAmount = 19;

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
}
- (void)startAnimate
{
    departureFlag = true;
    lockedFlag = false;
    pictureIndex = 1;
    [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(changePicture) userInfo:nil repeats:NO];
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
    NSString *dateString = [NSString stringWithFormat:@"%@ / %@ \n /%d",dayString,monthString,year];
    
    NSString *minuteString = [NSString stringWithFormat:  @"%02d",minute];
    NSString *hourString = [NSString stringWithFormat:  @"%02d",hour];
    NSString *timeString = [NSString stringWithFormat:@"%@ : %@",hourString,minuteString];
    
    [dateReveal setText:dateString];
    [timeReveal setText:timeString];
}

- (void)changePicture
{
    if (departureFlag == true)
        [NSTimer scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(changePicture) userInfo:nil repeats:NO];
    else
        return;
    if (lockedFlag == false)
    {
        NSString *tmpName = [NSString stringWithFormat:@"%02d.jpg",pictureIndex];
        UIImage *thisImage = [UIImage imageNamed:tmpName];
        [pictureView setImage:thisImage];
        pictureIndex ++;
    }
    int temp = [[NSDate date] timeIntervalSince1970];
    int countForTimer = 60 / timerInterval;
    if (temp % countForTimer == 0)
        [self setCalendar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setCalendar];
    [self.view setFrame:CGRectMake(0, 0, 320, 480)];
    [pictureView setFrame:CGRectMake(0, 0, 320, 480)];
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
