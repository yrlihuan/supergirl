//
//  PicturesWallController.m
//  SuperGirl_11_01
//
//  Created by xiaojia liu on 11-11-3.
//  Copyright 2011年 looa. All rights reserved.
//

#import "PicturesWallController.h"

@implementation PicturesWallController

@synthesize showScreen,picturesWall,buttonGetBack;
@synthesize pictureViewController;
@synthesize screenViewController;
@synthesize thisFather;
@synthesize thumbnailNames;
@synthesize topToolBar;

#define viewWidth 320
#define totalNumber 10
#define thumbnailWidth 71
#define thumbnailHeight 71//(71.0f*3.0f/2.0f)
#define disappear 0.0
#define beTransparent 0.5

#define interGap 7.0
#define boundGap 7.5
double picturesWallSize;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"I am scrolling");
    return;
}


- (IBAction)clickSreenButton:(id)sender
{
    if (screenViewController == nil)
        NSLog(@"Good bye");
    [screenViewController startAnimate];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self presentModalViewController:screenViewController animated:YES];
}
- (IBAction)toGetBack:(id)sender
{
    [thisFather dismissModalViewControllerAnimated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault]; 
    [NSTimer timerWithTimeInterval:0.1 target:thisFather selector:@selector(clearPhoto) userInfo:nil repeats:NO];
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
- (void)initPicturesWall
{
    thumbnailNames = [[NSArray alloc] initWithObjects:@"01段林希-1.jpg",@"01段林希-2.jpg",@"02洪辰-1.jpg",@"02洪辰-2.jpg",@"03刘忻-1.jpg",@"03刘忻-2.jpg",@"04苏妙玲-1.jpg",@"04苏妙玲-2.jpg",@"05杨洋-1.jpg",@"05杨洋-2.jpg", nil];
    
    picturesWall = [[UIScrollView alloc] init];
    [picturesWall setBackgroundColor:[UIColor viewFlipsideBackgroundColor]];
    [picturesWall setFrame:CGRectMake(0, -20, 320, 480)];
    [self initSubview];
    picturesWall.delegate = self;
    [self.view addSubview:picturesWall];
    [self.view sendSubviewToBack:picturesWall];
    
    self.navigationController.navigationBar.alpha = showAlpha;
    
    screenViewController.thisFather = self;
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view sendSubviewToBack:topToolBar];
    [self initPicturesWall];
    [screenViewController firstInit];
    // Do any additional setup after loading the view from its nib.
}
- (void)initSubview
{    
    [picturesWall setBackgroundColor:[UIColor blackColor]];
    [picturesWall setCanCancelContentTouches:NO];
    picturesWall.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    picturesWall.clipsToBounds = NO;
    picturesWall.scrollEnabled = YES;
    
	picturesWall.pagingEnabled = NO;
	
    int numberOfColumn = viewWidth / thumbnailWidth;
    if (viewWidth % thumbnailWidth == 0)
        numberOfColumn -= 1;
    
    int numberOfRows = ( totalNumber + numberOfColumn - 1) / numberOfColumn;
    
    //float columnGap = ( viewWidth - numberOfColumn * thumbnailSize ) / (numberOfColumn + 1);
    
    //float rowGap = columnGap;
    

    
    picturesWallSize = thumbnailHeight * numberOfRows + (interGap * numberOfRows - 1) + 2 * boundGap;
    
    //NSLog(@"rowGap = %f, columnGap = %f",rowGap,columnGap);
    
    CGPoint start = CGPointMake(boundGap, boundGap + 64);
    
	for (int i = 1; i <= totalNumber; i++)
	{
        //UIControl *imageControl = [[UIControl alloc] init];
        NSString *tmpName = [thumbnailNames objectAtIndex:(i-1)];
        //loading the 
		UIImage *image = [UIImage imageNamed:tmpName];
        
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
		// setup each frame to a default height and width, it will be properly placed when we call "updateScrollList"
		CGRect rect = CGRectMake(start.x, start.y, thumbnailWidth, thumbnailHeight);
		imageView.frame = rect;
		imageView.tag = i;	
        // tag our images for later use when we place them in serial fashion
        [picturesWall addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        TapGestureRecognizer *singleTap = [[TapGestureRecognizer alloc] initWithTarget:self action:@selector(clickThisImage:)];
        singleTap.imageIndex = i;
        [imageView addGestureRecognizer:singleTap];
        [singleTap release];
        
        
		[imageView release];
        
        if ( i % numberOfColumn == 0 )
        {
            start.x = boundGap;
            start.y += interGap + thumbnailHeight;
        }
        else
            start.x += interGap + thumbnailWidth;
        
	}    
    CGSize contentSize = CGSizeMake( viewWidth, picturesWallSize < 416 ? 480.5 : picturesWallSize + 64 );
	[picturesWall setContentSize:contentSize];
    [picturesWall setContentOffset:CGPointMake(0, 0)];
}

- (void)viewDidUnload
{
    [showScreen release];
    [buttonGetBack release];
    [picturesWall release];
    [thisFather release];
    [pictureViewController release];
    [screenViewController release];
    [thumbnailNames release];
    [topToolBar release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)clickThisImage:(id)sender
{
    /*
     if ( [sender isKindOfClass:[TapGestureRecognizer class]] )
     NSLog(@"I am a pivture");
     else
     NSLog(@"I am not");
     */
    //UIControl *control = sender;
    //ClickImageView *view = [control.subviews objectAtIndex:0];
    /*
    NSString *message = [NSString stringWithFormat:@"You click the %d's picture",((TapGestureRecognizer *)sender).imageIndex];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
     */
    [self.navigationController pushViewController:pictureViewController animated:YES];
    [pictureViewController startView:((TapGestureRecognizer *)sender).imageIndex];
}
-(void)viewWillAppear:(BOOL)animated
{
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end


@implementation TapGestureRecognizer
@synthesize imageIndex;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end



