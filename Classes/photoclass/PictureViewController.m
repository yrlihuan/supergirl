//
//  TestViewController.m
//  11_17_test01
//
//  Created by xiaojia liu on 11-11-17.
//  Copyright 2011年 looa. All rights reserved.
//

#import "PictureViewController.h"


@implementation CellImageView

@synthesize picNames;
@synthesize coreView;
- (int)getIndex
{
    return (self.frame.origin.x/VIEWWIDTH) + 1;
}
- (void)basicInit
{
    [self init];
    [self setFrame:CGRectMake(-VIEWWIDTH, 0, VIEWWIDTH, VIEWHEIGHT)];
    [self setContentSize:CGSizeMake(VIEWWIDTH, VIEWHEIGHT)];
    [self setContentOffset:CGPointMake(0, 0)];
    [self setBackgroundColor:[UIColor blackColor]];
    
    [self setCanCancelContentTouches:NO];
    self.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    self.clipsToBounds = NO;
    self.scrollEnabled = NO;
	self.pagingEnabled = NO;    
    self.maximumZoomScale = 4.0;
    self.minimumZoomScale = 1.0; 
    
    coreView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEWWIDTH, VIEWHEIGHT)];
    [self addSubview:coreView];
    
    picNames = [[NSArray alloc] initWithObjects:@"01dlx-1.jpg",@"01dlx-2.jpg",@"02hc-1.jpg",@"02hc-2.jpg",@"03lx-1.jpg",@"03lx-2.jpg",@"04sml-1.jpg",@"04sml-2.jpg",@"05yy-1.jpg",@"05yy-2.jpg", nil];
}
- (void)drawSelf:(int)index
{
    [self setFrame:CGRectMake(VIEWWIDTH * (index-1), 0, VIEWWIDTH, VIEWHEIGHT)];
    NSString *temp = [picNames objectAtIndex:(index-1)];
    [coreView setImage:[UIImage imageNamed:temp]];
}
- (void)dealloc
{
    [coreView release];
    [picNames release];
    [super dealloc];
}
@end



@implementation PictureViewController

@synthesize thisScrollView;

@synthesize viewArray;
@synthesize toolbar;
@synthesize profileButton;
@synthesize loadButton,lastButton,nextButton;
@synthesize buttonGetBack;
@synthesize topToolBar;
@synthesize showIndex;
@synthesize infoViewController;

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
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == thisScrollView && beHidden == false)
    {
        [self chooseThisImage:nil];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"the offset:%f",thisScrollView.contentOffset.x);
    int offsetX = thisScrollView.contentOffset.x/VIEWWIDTH + 1;
    
    if (offsetX == pictureIndex)
        return;
    else if (offsetX == pictureIndex + 1)
    {
        currentView = (currentView + 1)%3;
    }
    else if (offsetX >= pictureIndex + 2)
    {
        currentView = (currentView + 1)%3;
        [thisScrollView setContentOffset:CGPointMake((pictureIndex+1) * VIEWWIDTH - 1, 0)];
        NSLog(@"I go back to left");
    }
    else if (offsetX == pictureIndex - 1)
    {
        currentView = (currentView + 2)%3;     
    }
    else if (offsetX <= pictureIndex - 2)
    {
        currentView = (currentView + 2)%3;
        [thisScrollView setContentOffset:CGPointMake((pictureIndex-3) * VIEWWIDTH + 1, 0)];
        NSLog(@"I go back to right");
    }
    else
        NSLog(@"worng");
    //NSLog(@"pictureIndex :%d",offsetX);
    [self launchFor:offsetX];
}
- (void)zoomThisImage:(UITapGestureRecognizer *)sender
{
    if (sender != nil && !beHidden)
    {
        double temp = [sender locationInView:thisScrollView].y;
        if ( temp < 64.0f || temp > 436.0f)
            return;
    }
    if (!beHidden)
        [self chooseThisImage:nil];
    CellImageView *temp = [viewArray objectAtIndex:currentView];
    if (temp.zoomScale > 1.0f)
        [temp setZoomScale:1.0f animated:YES];
    else
        [temp setZoomScale:2.0f animated:YES];
}
- (void)chooseThisImage:(UITapGestureRecognizer *)sender
{
    if (inZooming)
        return;
    if (sender != nil && !beHidden)
    {
        double temp = [sender locationInView:thisScrollView].y;
        if ( temp < 64.0f || temp > 436.0f)
            return;
    }
    beHidden = !beHidden;
    
    [topToolBar setHidden:beHidden];
    [buttonGetBack setHidden:beHidden];
    [profileButton setHidden:beHidden];
    [showIndex setHidden:beHidden];
    [lastButton setHidden:beHidden];
    [nextButton setHidden:beHidden];
    [loadButton setHidden:beHidden];
    [toolbar setHidden:beHidden];
    [[UIApplication sharedApplication] setStatusBarHidden:beHidden];    
}

#pragma mark - View lifecycle
- (void)initScrollViews
{
    // init thisScrollView : the main ScrollView
    //thisScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, VIEWWIDTH, VIEWHEIGHT)];
    [thisScrollView setFrame:CGRectMake(0, -20, VIEWWIDTH, VIEWHEIGHT)];
    [thisScrollView setContentSize:CGSizeMake(VIEWWIDTH * PICTURESNUMBER, VIEWHEIGHT)];
    [thisScrollView setContentOffset:CGPointMake(0, 0)];
    [thisScrollView setBackgroundColor:[UIColor blackColor]];
    
    [thisScrollView setCanCancelContentTouches:NO];
    thisScrollView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    thisScrollView.clipsToBounds = NO;
    thisScrollView.scrollEnabled = YES;    
	thisScrollView.pagingEnabled = YES;    
    // init viewArray : the small ScrollViews
    NSMutableArray *mutableViews = [[NSMutableArray alloc] init];
    CellImageView *cell;
    for (int i = 0;i < 3;i ++) {
        cell = [CellImageView alloc];
        [cell basicInit];
        [mutableViews addObject:cell];
        [thisScrollView addSubview:cell];
        cell.delegate = self;
        
        
         cell.userInteractionEnabled = YES;
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomThisImage:)];
        doubleTap.numberOfTapsRequired = 2;
        [cell addGestureRecognizer:doubleTap];
        [doubleTap release];        
        
        [cell release];
        
    }    
    
    thisScrollView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseThisImage:)];
    singleTap.numberOfTapsRequired = 1;
    [thisScrollView addGestureRecognizer:singleTap];
    [singleTap release];
    
    viewArray = [[NSArray alloc] initWithArray:mutableViews];
    [mutableViews release];   
    
    thisScrollView.delegate = self;
}
- (void)startFor:(int)index
{
    [self launchFor:index];
    [thisScrollView setContentOffset:CGPointMake(VIEWWIDTH*(index-1), 0)];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
}
- (void)launchFor:(int)index
{
    if (index >= 1)
        [showIndex setText:[NSString stringWithFormat:@"%d/%d",index,PICTURESNUMBER]];
    pictureIndex = index;
    
    if (currentView == -1)
        currentView = 1;
    
    CellImageView *temp = [viewArray objectAtIndex:currentView];
    if ([temp getIndex] != pictureIndex)
    {
        if (pictureIndex >= 1 && pictureIndex <= PICTURESNUMBER)
            [[viewArray objectAtIndex:currentView] drawSelf:pictureIndex];
    }
    
    temp = [viewArray objectAtIndex:((currentView + 2)%3)];
    if (pictureIndex-1 >= 1 && [temp getIndex] != pictureIndex-1)
        [temp drawSelf:(pictureIndex-1)];
    temp = [viewArray objectAtIndex:((currentView + 1)%3)];    
    if (pictureIndex+1 <= PICTURESNUMBER && [temp getIndex] != pictureIndex + 1)
        [temp drawSelf:(pictureIndex+1)];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    inZooming = false;
    beHidden = false;
    for (int i = 0;i < PICTURESNUMBER;i ++)
        whetherSaved[i] = false;
    currentView = -1;
    [self initScrollViews];
    [self.view sendSubviewToBack:thisScrollView];
    
    infoViewController = [[InfoViewController alloc] init];
    [infoViewController firstInit];
    // Do any additional setup after loading the view from its nib.
}
- (void)setViewsAlpha:(bool)alpha
{
    int other = (currentView + 1)%3;
    CellImageView *temp = [viewArray objectAtIndex:other];
    [temp setHidden:alpha];
    other = (currentView + 2)%3;
    temp = [viewArray objectAtIndex:other];
    [temp setHidden:alpha];
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView*)scrollView
{
    [self setViewsAlpha:YES];
    if (!beHidden)
        [self chooseThisImage:nil];
    return ((CellImageView *)[viewArray objectAtIndex:currentView]).coreView;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    CellImageView *temp = [viewArray objectAtIndex:currentView];
    if (scale > 1)
    {
        inZooming = true;
        thisScrollView.scrollEnabled = NO;
        temp.scrollEnabled = YES;
    }
    else
    {
        inZooming = false;
        if (beHidden)
            [self chooseThisImage:nil];
        thisScrollView.scrollEnabled = YES;
        temp.scrollEnabled = NO;
        [self setViewsAlpha:NO];
        return;
    }
    [temp setContentSize:CGSizeMake(VIEWWIDTH *scale, SCROLLHEIGHT * scale)];
}
- (void)viewDidUnload
{
    [thisScrollView release];
    [viewArray release];
    [toolbar release];
    [profileButton release];
    [loadButton release];
    [lastButton release];
    [nextButton release];
    [buttonGetBack release];
    [topToolBar release];
    [showIndex release];
    [infoViewController release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)savePhoto
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    CellImageView *temp = [viewArray objectAtIndex:currentView];    
    UIImageWriteToSavedPhotosAlbum(temp.coreView.image, nil,nil,nil);
    [pool release];
}

- (void) dimissAlert:(UIAlertView *)alert
{
    if (alert)
    {
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
        //[alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
        [alert release];
    }
}
- (void)showAlert
{            
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示\n" message:@"图片已保存到手机相册中" delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1];
}

- (IBAction)lastPicture:(id)sender
{
    if (pictureIndex - 1 < 1)
        return;
    [thisScrollView setContentOffset:CGPointMake(thisScrollView.contentOffset.x - VIEWWIDTH, thisScrollView.contentOffset.y)];
}
- (IBAction)nextPicture:(id)sender
{
    if (pictureIndex + 1 > PICTURESNUMBER)
        return;
    [thisScrollView setContentOffset:CGPointMake(thisScrollView.contentOffset.x + VIEWWIDTH, thisScrollView.contentOffset.y)];
}
- (IBAction)showProfile:(id)sender
{    
    infoViewController.currentIndex = pictureIndex;    
    [infoViewController setContent];
    
    [self.navigationController pushViewController:infoViewController animated:YES];
}
- (IBAction)toGetBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
}
- (IBAction)downLoad:(UIButton *)sender
{
    if (whetherSaved[pictureIndex - 1] == true)
    {
        [self showAlert];
    }
    else
    {
        whetherSaved[pictureIndex-1] = true;
        [NSThread detachNewThreadSelector:@selector(savePhoto) toTarget:self withObject:nil];
        [self showAlert];    
    }
}


@end
