
 
 

#import "avTouchViewController.h"
#import "avTouchController.h"

@implementation avTouchViewController
@synthesize movieplayer;
@synthesize array;
@synthesize player;

// Test Comments 2

/*
// Override initWithNibName:bundle:	 to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement loadView to create a view hierarchy programmatically.
/*- (void)loadView {

	[[avTouchController alloc] init];
}*/



// Implement viewDidLoad to do additional setup after loading the view.

- (void)viewDidLoad {
    movietable=[[MovieTableController alloc] init];
    movietable.mainviewcontroller=self;
    movietable.controller=controller;
    movietable.tableView.frame=CGRectMake(0, 0, 320, 360);
    movietable.tableView.hidden=YES;
    [self.view addSubview:movietable.tableView];
   // test.frame=CGRectMake(0, 0, 100, 100);
    //test.tag=10;
    photosNavController=nil;
    movietable.tableView.separatorColor=[UIColor redColor];
    // [self.view addSubview:test];
	//[[avTouchController alloc] init];
  
    // }
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification 
{    //设置状态栏 
    [[UIApplication sharedApplication] setStatusBarHidden:NO]; 
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO]; 
    
    //移除观察者 
    [[NSNotificationCenter     defaultCenter] removeObserver:self 
                                                        name:MPMoviePlayerPlaybackDidFinishNotification 
                                                      object:nil]; 
    //播放器消失 
    [movieplayer dismissMoviePlayerViewControllerAnimated]; 
    NSLog(@"jdjhd");//控制台可以看见打印的字母，该函数已执行 
} 

-(void)movieplay
{ 
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"Movie-1" ofType:@"mp4" inDirectory:nil]; 
    //NSString *path = [[NSString alloc] initWithString:@"http://*************"]; 
    
    NSURL *movieURL =[[NSURL alloc] initFileURLWithPath: [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"test.mp4"]];
    //[movieURL retain]; 
    [movieplayer.moviePlayer setControlStyle:MPMovieControlStyleFullscreen]; 
    [movieplayer.moviePlayer setFullscreen:YES];  
    
    //创建播放器，moviePlayerView是MPMoviePlayerViewController类型的全局变量 
    movieplayer = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL]; 
    //弹出播放器窗口 
    [self  presentMoviePlayerViewControllerAnimated:movieplayer ];  
    
    
    [movieplayer.moviePlayer setMovieSourceType:MPMovieSourceTypeFile]; 
    [movieplayer.moviePlayer prepareToPlay]; 
    //播放 
    //[movieplayer.moviePlayer play];   
    //增加一个观察者 
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(moviePlayBackDidFinish:) 
                                                 name:MPMoviePlayerPlaybackDidFinishNotification 
                                               object:nil]; 
    
} 
- (void)clearPhoto
{
    if (photosNavController != nil)
        [photosNavController release];
    if (lightViewController != nil)
        [lightViewController release];
}
-(IBAction)musiclist:(UIButton*)sender{
    [self buttonimagechange];
    [sender setImage:[UIImage imageNamed:@"music_on.png"] forState:UIControlStateNormal];
}
-(IBAction)photolist:(UIButton*)sender
{
    [self buttonimagechange];
    [sender setImage:[UIImage imageNamed:@"photo_on.png"] forState:UIControlStateNormal];
    /*
    if ([sender.titleLabel.text isEqual:@"light"])
    {
        
    }*/
    if (photosNavController != nil)
        [photosNavController release];
    PicturesWallController *firstViewController = [[PicturesWallController alloc] init];
    photosNavController = [[UINavigationController alloc] initWithRootViewController:firstViewController];
    [photosNavController.view setFrame:CGRectMake(0, -20, 320, 480)];
    firstViewController.thisFather = self;
    [photosNavController setNavigationBarHidden:YES];
    //here we must set 460 to size.height since application will add the status bar when the doading view has size of (320 480).
    //it is very strange that this won't happen if loading view's size.height is just not 480.
    
    [self presentModalViewController:photosNavController animated:YES];      
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackOpaque];
    
    NSLog(@"play succesfull");
}
-(void)movielistmove{
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
    if (movietable.tableView.hidden==YES) {
        movietable.tableView.hidden=NO;
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype: kCATransitionFromBottom];
    [movietable.view.layer addAnimation:animation forKey:@"Reveal"];
    }else{
        movietable.tableView.hidden=YES;
    }
}
-(IBAction)movielisthiden:(UIButton*)sender{
    movietable.tableView.hidden=YES;
}

-(IBAction)movielist:(UIButton*)sender
{
    [self buttonimagechange];
    [sender setImage:[UIImage imageNamed:@"video_on.png"] forState:UIControlStateNormal];
    movietable.tableView.layer.shadowOffset = CGSizeMake(0   , 4);
    movietable.tableView.backgroundColor=[UIColor colorWithWhite:1 alpha:1];
   // movietable.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    movietable.tableView.layer.shadowOpacity = 0.8;
    movietable.tableView.layer.shadowColor = [UIColor blackColor].CGColor;
    movietable.tableView.frame=CGRectMake(0, 0, 320, 360);
    movietable.tableView.center=CGPointMake(160   , 180);
   // movietable.tableView.hidden=((int)movietable.tableView.hidden+1)%2;
    //if (movietable.tableView.hidden==NO) {
        [self movielistmove];
   // }
    
    // musictable.separatorColor=[UIColor blackColor];
   // myTimer =  [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(viewMove) userInfo:nil repeats:YES];
    
     
    
}
-(IBAction)voicelist:(UIButton*)sender{
    [self buttonimagechange];
    [sender setImage:[UIImage imageNamed:@"voice_on.png"] forState:UIControlStateNormal];
    VoiceMailController* voicemenu=[[VoiceMailController alloc] init];
    voicemenu.controller=controller;
    [self presentModalViewController:voicemenu animated:YES];
}
-(IBAction)cheerlist:(UIButton*)sender{
    [self buttonimagechange];
    [sender setImage:[UIImage imageNamed:@"cheer_on.png"] forState:UIControlStateNormal];
    if (lightViewController != nil)
        [lightViewController release];
    lightViewController = [[LightViewController alloc] init];// initWithNibName:@"LightViewController" bundle:nil];
    lightViewController.thisFather = self;
    [self presentModalViewController:lightViewController animated:YES]; 
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackTranslucent];
}
-(void)buttonimagechange{
    
    [musicbt setImage:[UIImage imageNamed:@"music_off.png"] forState:UIControlStateNormal];
    [moviebt setImage:[UIImage imageNamed:@"video_off.png"] forState:UIControlStateNormal];
    [photobt setImage:[UIImage imageNamed:@"photo_off.png"] forState:UIControlStateNormal];
    [voicebt setImage:[UIImage imageNamed:@"voice_off.png"] forState:UIControlStateNormal];
    [cheerbt setImage:[UIImage imageNamed:@"cheer_off.png"] forState:UIControlStateNormal];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
     /*
    UIInterfaceOrientation noworientation =[[UIDevice currentDevice] orientation ];
    if(noworientation==UIDeviceOrientationLandscapeLeft||noworientation==UIDeviceOrientationLandscapeRight){
        moviecontroller.view.frame=CGRectMake(0, 0, 480, 320);
       // moviecontroller.view.center=CGPointMake(240 , 160);
        
    }
    else {
        moviecontroller.view.frame=CGRectMake(0, 0, 320, 480);
       // moviecontroller.view.center=CGPointMake(160 , 240);
    }*/
    
    //return YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
    [photosNavController release];
    [controller release];
     [movieplayer release];
    [array release];
    [movietable release];
   [myTimer release];
   [player release];
    
    [lightViewController release];
    
    [moviebt release];
    [musicbt release];
    [photobt release];
    [cheerbt release];
    [voicebt release];
}

@end
