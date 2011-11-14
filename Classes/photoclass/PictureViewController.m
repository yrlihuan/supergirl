//
//  PictureViewController.m
//  SuperGirl_11_01
//
//  Created by xiaojia liu on 11-11-7.
//  Copyright 2011年 looa. All rights reserved.
//

#import "PictureViewController.h"

@implementation PictureViewController

@synthesize toolbar;
@synthesize thisScrollView;
@synthesize profileButton;
@synthesize lastButton,nextButton;
@synthesize pictureIndex;
@synthesize viewArray;
@synthesize infoViewController;
@synthesize picNames;

- (void)toFinish:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    return;
}
- (void)savePhoto
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    UIImage *pic = [UIImage imageNamed:[NSString stringWithFormat:@"%02d.jpg",pictureIndex]];
    NSLog(@"%02d.jpg",pictureIndex);
    
    UIImageWriteToSavedPhotosAlbum(pic, nil,nil,nil);//self, @selector(toFinish), @"abc");
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"SavePhoto" message:@"This photo has been save to photo album" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    [pool release];
}
- (void)setIndex
{
    pictureIndex = (thisScrollView.contentOffset.x/pictureWidthInterval + 1);
    
}
- (IBAction)downLoad
{
    [self setIndex];
    if (whetherSaved[pictureIndex - 1] == true)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"SavePhoto" message:@"This photo has been save to photo album" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else
        [NSThread detachNewThreadSelector:@selector(savePhoto) toTarget:self withObject:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (IBAction)showProfile:(id)sender
{
    NSLog(@"click profile");
    [self.navigationController pushViewController:infoViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /*
    int tmpX = thisScrollView.contentOffset.x;
    int conX = (pictureIndex - 1) * pictureWidthInterval;
    if (tmpX == contentOffetX - pictureWidthInterval) 
    {
        thisScrollView.scrollEnabled = NO;
        [self moveForLast];
        contentOffetX = thisScrollView.contentOffset.x;
        [thisScrollView setContentOffset:CGPointMake(tmpX, 0)];
        thisScrollView.scrollEnabled = YES;
        
    }
    else if (tmpX == contentOffetX + pictureWidthInterval)
    {
        thisScrollView.scrollEnabled = NO;
        [self moveForNext];
        contentOffetX = thisScrollView.contentOffset.x;
        [thisScrollView setContentOffset:CGPointMake(tmpX, 0)];
        thisScrollView.scrollEnabled = YES;
    }
    if (tmpX < conX - pictureWidthInterval || tmpX > conX + pictureWidthInterval )
    {
        thisScrollView.scrollEnabled = NO;
        [self setViews:currentIndex sourceWith:pictureIndex];
        thisScrollView.scrollEnabled = YES;
    }*/
    //NSLog(@"click profile:%d",tmpX);
    /*
    //user slids the screen to right,so all the views move left
    if ( tmpX == contentOffetX - pictureWidthInterval )
    {
                        
    }
    else if ( tmpX == contentOffetX + pictureWidthInterval )
    {
        
    }*/
}

- (void)chooseThisImage:(id)sender
{
    NSLog(@"You double click");
    beHidden = !beHidden;
    if (beHidden)
    {
        toolbar.alpha = 0.0;
        self.navigationController.navigationBar.alpha = 0.0;
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    else
    {
        toolbar.alpha = showAlpha;
        self.navigationController.navigationBar.alpha = showAlpha;
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }
    
}

#pragma mark - View lifecycle
- (void) viewWillDisappear:(BOOL)animated
{
    NSLog(@"I have ideas");
}
- (void)initAllViews
{
    for (int i = 1;i <= pictureSum;i ++)
    {
        NSString *tmpName = [picNames objectAtIndex:(i-1)];
        UIImageView *tmpView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tmpName]];
        //NSLog(@"I am here:%@:%d",tmpName,where);
        [tmpView setFrame:CGRectMake( (i - 1) * pictureWidthInterval, 0, pictureWidth, pictureHeightInside)];
        [thisScrollView addSubview:tmpView];
        [tmpView release];
    }
}
- (void)initSuperViews
{    
    lastIndex = 0;
    currentIndex = 1;
    nextIndex = 2;
    
    UIImageView *lastView = [[UIImageView alloc] init];
    //initWithFrame:CGRectMake(0, 0, pictureWidth, pictureHeightInside)];
    
    UIImageView *currentView = [[UIImageView alloc] init];   
    
    UIImageView *nextView = [[UIImageView alloc] init];
    
    viewArray = [[NSArray alloc] initWithObjects:lastView,currentView,nextView,nil];
    
    [thisScrollView addSubview:lastView];
    [thisScrollView addSubview:currentView];
    [thisScrollView addSubview:nextView];
    
    [lastView release];
    [nextView release];
    [currentView release];    
}
- (void)initScrollView
{
    
    [thisScrollView setFrame:CGRectMake(0, -64, pictureWidth, 524)];
    
    [thisScrollView setBackgroundColor:[UIColor blackColor]];
    [thisScrollView setCanCancelContentTouches:NO];
    thisScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    thisScrollView.clipsToBounds = NO;
    thisScrollView.scrollEnabled = YES;    
	thisScrollView.pagingEnabled = YES;
    
    thisScrollView.userInteractionEnabled = YES;
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseThisImage:)];
    doubleTap.numberOfTapsRequired = 1;
    //doubleTap.delegate = self;
    [thisScrollView addGestureRecognizer:doubleTap];
    [doubleTap release];
    
    [self.view addSubview:thisScrollView];
    [self.view sendSubviewToBack:thisScrollView];
    
    
    beHidden = false;
    self.navigationController.navigationBar.alpha = showAlpha;
    toolbar.alpha = showAlpha;
    
    
    thisScrollView.delegate = self;
    [thisScrollView setContentSize:CGSizeMake(pictureWidth + pictureWidthInterval * (pictureSum - 1),  pictureHeightInside)];
    
    //NSLog(@"%d views",[viewArray count]);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    picNames = [[NSArray alloc] initWithObjects:@"01dlx-1.jpg",@"01dlx-2.jpg",@"02hc-1.jpg",@"02hc-2.jpg",@"03lx-1.jpg",@"03lx-2.jpg",@"04sml-1.jpg",@"04sml-2.jpg",@"05yy-1.jpg",@"05yy-2.jpg", nil];
    [self initScrollView];
    [self initAllViews];
    self.navigationItem.rightBarButtonItem = self.profileButton;
    infoViewController = [InfoViewController alloc];
    for (int i = 0;i < pictureSum;i ++)
        whetherSaved[i] = false;
     // Do any additional setup after loading the view from its nib.
}
- (void)startView:(int)source
{
    [thisScrollView setContentOffset:CGPointMake( (source - 1) * pictureWidthInterval, 0)];
    contentOffetX = thisScrollView.contentOffset.x;
    pictureIndex = source;
    [self setViews:currentIndex sourceWith:source];
    if (source - 1 >= 1)
        [self setViews:lastIndex sourceWith:(source - 1)];
    if (source + 1 <= pictureSum)
        [self setViews:nextIndex sourceWith:(source + 1)];
    
}

- (void)setViews:(int)where sourceWith:(int)source;
{
    NSString *tmpName = [picNames objectAtIndex:source-1];
    UIImageView *tmpView = [viewArray objectAtIndex:where];
    //NSLog(@"I am here:%@:%d",tmpName,where);
    [tmpView setImage:[UIImage imageNamed:tmpName]];
    [tmpView setFrame:CGRectMake( (source - 1) * pictureWidthInterval, 0, pictureWidth, pictureHeightInside)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [toolbar release];
    [thisScrollView release];
    [profileButton release];
    [lastButton release];
    [nextButton release];
    [infoViewController release];
    [picNames release];
    
    [viewArray release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)moveForLast
{
    pictureIndex --;
    lastIndex = (lastIndex + 2)%3;
    currentIndex = (currentIndex + 2)%3;
    nextIndex = (nextIndex + 2)%3;
    if (pictureIndex - 1 >= 1)
        [self setViews:lastIndex sourceWith:(pictureIndex - 1)];
    if (pictureIndex + 1 <= pictureSum)
        [self setViews:nextIndex sourceWith:(pictureIndex + 1)];  
}
- (void)moveForNext
{
    pictureIndex ++;
    lastIndex = (lastIndex + 1)%3;
    currentIndex = (currentIndex + 1)%3;
    nextIndex = (nextIndex + 1)%3;
    if (pictureIndex - 1 >= 1)
        [self setViews:lastIndex sourceWith:(pictureIndex - 1)];
    if (pictureIndex + 1 <= pictureSum)
        [self setViews:nextIndex sourceWith:(pictureIndex + 1)];    
}
- (void)lastPicture:(id)sender
{
    if (pictureIndex - 1 < 1)
        return;
    [thisScrollView setContentOffset:CGPointMake(thisScrollView.contentOffset.x - pictureWidthInterval, thisScrollView.contentOffset.y)];
    if (pictureIndex == 1)
    {
        //set the left button
    }
    if (pictureIndex == pictureSum - 1)
    {
        
    }
}
- (void)nextPicture:(id)sender
{
    if (pictureIndex + 1 > pictureSum)
        return;
    [thisScrollView setContentOffset:CGPointMake(thisScrollView.contentOffset.x + pictureWidthInterval, thisScrollView.contentOffset.y)];
    //[self moveForNext];
    //contentOffetX = thisScrollView.contentOffset.x;
    if (pictureIndex == pictureSum)
    {
        //set the rightbutton
    }
    if (pictureIndex == 2)
    {
        
    }
}

@end

#define topBound 10
#define leftBound 50
#define profileTopBound 8
#define profileLeftBound 4


@implementation InfoViewController
@synthesize textView;
@synthesize profileView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *bgImage = [UIImage imageNamed:@"profile_back.png"];
    UIColor *bgColor = [[UIColor alloc] initWithPatternImage:bgImage];
    [self.view setBackgroundColor:bgColor];
    
    
    //UIImageView *profileBoundView = [[UIImageView alloc] initWithFrame:CGRectMake(topBound, leftBound, 213, 149)];
    profileView = [[UIImageView alloc] initWithFrame:CGRectMake(leftBound + profileLeftBound, topBound + profileTopBound, 196, 134.5)];
    
    [profileView setImage:[UIImage imageNamed:@"段林希.jpg"]];
    
    //[profileBoundView setImage:[UIImage imageNamed:@""]];
    
    [self.view addSubview:profileView];
    //[self.view addSubview:profileBoundView];
    //[profileBoundView release];
    [profileView release];
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
    [topImageView setImage:[UIImage imageNamed:@""]];
    [self.view sendSubviewToBack:topImageView];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(40, 150, 240, 330)];
    [textView setEditable:false];
    //NSStringEncoding;
    //NSString *textContent;// = [NSString stringWithContentsOfFile:@"testFileReadLines.txt"];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"段林希" ofType:@"txt"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    if (path == nil)
        NSLog(@"It is nil");
    NSString *textContent = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:nil];
    [url release];

    UILabel *temp = [[UILabel alloc] initWithFrame:CGRectMake(40, 150, 240, 330)] ;
    [temp setText:textContent];
    [self.view addSubview:temp];
    textView.alpha = 0.0;
    //[textView setText:textContent];
    [temp setBackgroundColor:bgColor];
    [temp release];
    [textView setBackgroundColor:bgColor];
    [self.view addSubview:textView];
    
    
    [bgColor release];
    [topImageView release];
    
    //textView = [UITextView alloc] initWithFrame:CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    [textView release];
    [profileView release];
}
@end
















