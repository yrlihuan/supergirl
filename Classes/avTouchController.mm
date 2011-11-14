#import "avTouchController.h"
#include "CALevelMeter.h"
#import <CoreText/CoreText.h>
// amount to skip on rewind or fast forward
#define SKIP_TIME 1.0			
// amount to play between skips
#define SKIP_INTERVAL .2

@implementation avTouchController

@synthesize fileName;
@synthesize playButton;
@synthesize ffwButton;
@synthesize rewButton;
@synthesize musicButton;
@synthesize volumeSlider;
@synthesize progressBar;
@synthesize currentTime;
@synthesize duration;
@synthesize lvlMeter_in;
@synthesize progresstime;
@synthesize musictable;


@synthesize listData;
@synthesize array;

@synthesize updateTimer;
@synthesize player;
@synthesize movieplayer;
@synthesize myTimer;

@synthesize inBackground;


void RouteChangeListener(	void *                  inClientData,
							AudioSessionPropertyID	inID,
							UInt32                  inDataSize,
							const void *            inData);
															
-(void)updateCurrentTimeForPlayer:(AVAudioPlayer *)p
{
	currentTime.text = [NSString stringWithFormat:@"%d:%02d", (int)p.currentTime / 60, (int)p.currentTime % 60, nil];
	progressBar.value = p.currentTime;
   // NSLog(@"currtime: %2f",p.currentTime);
    progresstime.progress=(float)p.currentTime/(float)p.duration;
    timetemp=p.currentTime;
    [self lycshow];
   // NSLog(@"currtime: %2f",timetemp);
}

- (void)updateCurrentTime
{
	[self updateCurrentTimeForPlayer:self.player];
}
void audioRouteChangeListenerCallback (
                                       void                      *inUserData,
                                       AudioSessionPropertyID    inPropertyID,
                                       UInt32                    inPropertyValueSize,
                                       const void                *inPropertyValue
                                       ) {/*do what you want to do!*/};
-(void) updateSong
{
    if( (songplaying>=0)&&(songplaying<[listData count])) {
        NSString *rowValue = [listData objectAtIndex:songplaying];
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:rowValue ofType:@"mp3"]];
        [player stop];
        self.player=nil;
        if (cdtimer) {
            [cdtimer invalidate];
        }
        if (cdmovetimer) {
            [cdmovetimer invalidate];
            cdmovetimer=nil;
        }
        [[AVAudioSession sharedInstance] setDelegate:self];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        AudioSessionAddPropertyListener (
                                         kAudioSessionProperty_AudioRouteChange,
                                         audioRouteChangeListenerCallback,
                                         self
                                         );
          NSError *activationError = nil;
        [[AVAudioSession sharedInstance] setActive: YES error: &activationError];
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];	
       
        if (self.player)
        {
            fileName.text = [NSString stringWithFormat: @"%@ (%d ch.)", [[player.url relativePath] lastPathComponent], player.numberOfChannels, nil];
            [self updateViewForPlayerInfo:player];
            [self updateViewForPlayerState:player];
            player.numberOfLoops = 1;
            player.delegate = self;
        }
        
        [player play];
        [self startPlaybackForPlayer: player];
        //[player setDelegate:self];
         
    }
    
}
- (void)updateViewForPlayerState:(AVAudioPlayer *)p
{
	[self updateCurrentTimeForPlayer:p];
  	if (updateTimer) 
		[updateTimer invalidate];
		
	if (p.playing)
	{
		[playButton setImage:((p.playing == YES) ? pauseBtnBG : playBtnBG) forState:UIControlStateNormal];
        [musicButton setImage:((p.playing == YES) ? musicpauseBtnBG : musicplayBtnBG) forState:UIControlStateNormal];
		[lvlMeter_in setPlayer:p];
		updateTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateCurrentTime) userInfo:p repeats:YES];
       
	}
	else
	{
		[playButton setImage:((p.playing == YES) ? pauseBtnBG : playBtnBG) forState:UIControlStateNormal];
        [musicButton setImage:((p.playing == YES) ? musicpauseBtnBG : musicplayBtnBG) forState:UIControlStateNormal];
		[lvlMeter_in setPlayer:nil];
		updateTimer = nil;
	}
	
}

- (void)updateViewForPlayerStateInBackground:(AVAudioPlayer *)p
{
	[self updateCurrentTimeForPlayer:p];
	
	if (p.playing)
	{
		[playButton setImage:((p.playing == YES) ? pauseBtnBG : playBtnBG) forState:UIControlStateNormal];
	}
	else
	{
		[playButton setImage:((p.playing == YES) ? pauseBtnBG : playBtnBG) forState:UIControlStateNormal];
	}	
}

-(void)updateViewForPlayerInfo:(AVAudioPlayer*)p
{
	duration.text = [NSString stringWithFormat:@"%d:%02d", (int)p.currentTime / 60, (int)p.currentTime % 60, nil];
    //currentTime.text = [NSString stringWithFormat:@"%d:%02d", (int)p.currentTime / 60, (int)p.currentTime % 60, nil];
	progressBar.maximumValue = p.duration;
	volumeSlider.value = p.volume;
}

- (void)rewind
{
	AVAudioPlayer *p = rewTimer.userInfo;
	p.currentTime-= SKIP_TIME;
	[self updateCurrentTimeForPlayer:p];
}

- (void)ffwd
{
	AVAudioPlayer *p = ffwTimer.userInfo;
	p.currentTime+= SKIP_TIME;	
	[self updateCurrentTimeForPlayer:p];
}
- (IBAction)musiclist:(UIButton *)sender
{
    /*
    [UIView beginAnimations:@"animation" context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationRepeatAutoreverses:NO];
    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:[musictable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]] cache:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:musictable cache:NO];
    [UIView commitAnimations];*/
    //UIView* music;
   // music.frame=CGRectMake(20, 20, 200, 200);
   // [self.view addsubview
    musictable.layer.shadowOffset = CGSizeMake(0   , 4);
    musictable.layer.shadowOpacity = 0.8;
    musictable.layer.shadowColor = [UIColor blackColor].CGColor;
    musictable.center=CGPointMake(160   , -180);
    musictable.hidden=((int)(1+musictable.hidden))%2;
   // musictable.separatorColor=[UIColor blackColor];
    myTimer =  [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(viewMove) userInfo:nil repeats:YES];
   
}
- (void)viewMove{
    CGPoint mm=musictable.center;
    if (mm.y<180) {
        mm.y=mm.y+90;
      musictable.center=CGPointMake(mm.x, mm.y);
    NSLog(@"move");
        //myView.center = viewCenterPoint;
    }
    
    else 
    {
        [myTimer invalidate];
     }
}
- (IBAction)lyclist:(UIButton*)sender
{
    Textview.hidden=(Textview.hidden+1)%2;
}
    

-(void)setlist:(NSInteger) list
{
    if (list==1) {
        array = [[NSArray alloc] initWithObjects:@"MusicList", @"刘忻_如果有一天", @"杨洋_等爱",@"段林希_追梦的孩子",@"洪辰_爱多少",@"苏妙玲_背影里的沉默", nil];
    }
    else if(list==3)
    {
        //array = [[NSArray alloc] initWithObjects:@"musiclist", @"test.mp4", nil];
        array = [[NSArray alloc] initWithObjects:@"musiclist", @"For Your Entertainment", nil];
    }
    
    self.listData = array;
    [array release];

}
-(void)cdrotation
{
    CGFloat M = 3.1415/180.0;
    cdangle=cdangle+M;
    CGAffineTransform transform = CGAffineTransformMakeRotation(cdangle);
    cdimage.transform = transform;
    if (!player.playing) {
        [cdtimer invalidate];
        cdtimer=nil;
    }
}
-(void)cdmove
{
    CGPoint cdcenter=cdview.center;
    if (player.playing) {
        if (cdcenter.x<200) {
            cdcenter.x=cdcenter.x+1;
        }
        else 
        {
            [cdmovetimer invalidate];
            cdmovetimer=nil;
        }
        cdview.center=cdcenter;
    }
    else 
    {
        if (cdcenter.x>150) {
            cdcenter.x=cdcenter.x-1;
        }
        else {
            [cdmovetimer invalidate];
            cdmovetimer=nil;
        }
        cdview.center=cdcenter;
    }
}

- (void)awakeFromNib
{
    Textview.hidden=YES;
    listplaying=1;
    cdangle=0;
    [self setlist:listplaying];
    
            NSLog(@"view did load");
    
    songplaying=2;
      
	playBtnBG = [[UIImage imageNamed:@"play.png"] retain];
	pauseBtnBG = [[UIImage imageNamed:@"pause3.png"] retain];
    musicplayBtnBG=[[UIImage imageNamed:@"music_play_off.png"] retain];
    musicpauseBtnBG=[[UIImage imageNamed:@"music_play_on.png"] retain];
    
   
	[playButton setImage:playBtnBG forState:UIControlStateNormal];
      
	[musicButton setImage:musicplayBtnBG forState:UIControlStateNormal];
    
	[self registerForBackgroundNotifications];
			
	updateTimer = nil;
	rewTimer = nil;
	ffwTimer = nil;
    cdtimer=nil;
    cdmovetimer=nil;
	
	duration.adjustsFontSizeToFitWidth = YES;
	currentTime.adjustsFontSizeToFitWidth = YES;
	progressBar.minimumValue = 0.0;	
    /*
    if( (songplaying>=0)&&(songplaying<[listData count])) {
        NSString *rowValue = [listData objectAtIndex:songplaying];
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:rowValue ofType:@"mp3"]];
        [player stop];
        self.player=nil;
        if (cdtimer) {
            [cdtimer invalidate];
        }
        if (cdmovetimer) {
            [cdmovetimer invalidate];
            cdmovetimer=nil;
        }
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];	
        if (self.player)
        {
            fileName.text = [NSString stringWithFormat: @"%@ (%d ch.)", [[player.url relativePath] lastPathComponent], player.numberOfChannels, nil];
            [self updateViewForPlayerInfo:player];
            [self updateViewForPlayerState:player];
            player.numberOfLoops = 1;
            player.delegate = self;
        }
       // [player play];
      //®  [self startPlaybackForPlayer: player];
        
    }*/
    
    
}
//歌词
-(void)lycshow
{
    //NSLog(@"currtime222: %2f",timetemp);
    for (UITextView* subviews in [Textview subviews]) {
        [subviews removeFromSuperview];
    } 
    [Textview addSubview:lycclose];
    NSMutableArray * lycarray;
    NSMutableArray * lycstring;
    //NSMutableArray * lyctime;
    lycstring=[[NSMutableArray alloc] init];
   // lyctime=[[NSMutableArray alloc]init];
    NSString* lycall;
     NSString *lycvalue = [listData objectAtIndex:songplaying];
    NSURL *lycURL = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:lycvalue ofType:@"lrc"]];
    lycall=[NSString  stringWithContentsOfURL:lycURL];
    lycarray=[lycall componentsSeparatedByString:@"\n"];
    float  lyctime[[lycarray count]-2];
    //NSLog(@"1 count:%@",[lycarray count]);
    for (int i=0; i<[lycarray count]; i++) {
        if (i<2) {
            NSString * lycword=[lycarray objectAtIndex:i] ;
            lycword=[lycword substringFromIndex:4];
            lycword=[lycword stringByReplacingOccurrencesOfString:@"]" withString:@""];
            [lycstring addObject:lycword];
        }
        else if(i>1){
        NSString * lycword=[lycarray objectAtIndex:i] ;
        lycword=[lycword substringFromIndex:10];
        [lycstring addObject:lycword];
            
        float lyctime1=[[[lycarray objectAtIndex:i] substringWithRange:NSMakeRange(1, 2)] floatValue];
        float lyctime2=[[[lycarray objectAtIndex:i] substringWithRange:NSMakeRange(4, 5)] floatValue];
            lyctime[i-2]=lyctime1*60+lyctime2;
          //  NSLog(@"time:%f time: %f",time,lyctime[i-2]);
        }
        
    }
    int j;
    for (j=0; j<[lycarray count]-2; j++) {
        if ((timetemp>=0)&&(timetemp<lyctime[0])) {
           // NSLog(@"%f %f %d",timetemp,lyctime[j],j);
            j=-1;
            break;
        }
        if ((timetemp>=lyctime[j])&&(timetemp<lyctime[j+1])) {
            NSLog(@"%f %f %d",timetemp,lyctime[j],j);
            j++;
            break;
        } 
    }
    j=j+1;
  //  NSLog(@"%2f  %2f  %2d",time,lyctime[j],j);
    //NSLog(@"1 count:%@",[lycstring count]);
   lycall=[lycstring   componentsJoinedByString:@"\n"];
    NSString* keyword=[lycstring objectAtIndex:j];
    if (j==0) {
        keyword=[lycstring objectAtIndex:0];
        keyword=[keyword stringByAppendingString:@"\n"];
        keyword=[keyword stringByAppendingString:[lycstring objectAtIndex:1]];
    }
   // keyword=[keyword substringFromIndex:10];
   
    //改变字符串 从1位 长度为1 这一段的前景色，即字的颜色。
    /*    [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName) 
     value:(id)[UIColor darkGrayColor].CGColor 
     range:NSMakeRange(1, 1)]; */
 
    lycview= [[UITextView alloc] initWithFrame:CGRectMake(0  , 30, 320, 300)];
       lycview.editable=NO;
    lycview.textAlignment=UITextAlignmentCenter;
    
    lycview.font = [UIFont systemFontOfSize:15];
    UIFont*  fontx=lycview.font;
    if (j==0) {
        lycview.text=[lycall stringByReplacingOccurrencesOfString:keyword withString:@"\n"];
    }
    else{
    lycview.text=[lycall stringByReplacingOccurrencesOfString:keyword withString:@""];
    }
    CGFloat fontsize=fontx.lineHeight;
    lycshowing=[[UITextView alloc] initWithFrame:CGRectMake(0, fontsize*j, 320, 3*fontsize)];
    lycview.contentOffset=CGPointMake(0, fontsize*(j-8));
    //[lycview setContentOffset:CGPointMake(0, fontsize*(j-8)) animated:YES];
    lycshowing.text=keyword;
    lycshowing.backgroundColor=[UIColor clearColor];
    lycshowing.editable=NO;
    lycshowing.textColor=[UIColor redColor];
    lycshowing.font=fontx;
    lycshowing.scrollEnabled=NO;
    lycshowing.textAlignment=UITextAlignmentCenter;
    [lycview addSubview:lycshowing];
    
  //  [lycview cnv_setUILabelText:lycall  andKeyWord:keyword];



 
// 设置关键字为蓝色，其他字为红色
 //[lycview cnv_setUIlabelTextColor:[UIColor redColor]  andKeyWordColor:[UIColor blueColor] ];
    lycview.backgroundColor = [UIColor clearColor];
//  [lab sizeToFit];
  //  lycview.text=nil;
   // Textview.backgroundColor=[UIColor clearColor];
    [Textview addSubview:lycview];
    [lycview release];
    [lycshowing release];
    
}
-(void)pausePlaybackForPlayer:(AVAudioPlayer*)p
{
    
	[p pause];
	[self updateViewForPlayerState:p];
    if (cdmovetimer) {
        [cdmovetimer invalidate];
    }
    cdmovetimer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(cdmove) userInfo:nil repeats:YES];
}

-(void)startPlaybackForPlayer:(AVAudioPlayer*)p
{
	if ([p play])
	{
		[self updateViewForPlayerState:p];
        
        
        NSLog(@"i here");
        cdtimer =  [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(cdrotation) userInfo:nil repeats:YES];
        if (cdmovetimer) {
            [cdmovetimer invalidate];
        }
        cdmovetimer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(cdmove) userInfo:nil repeats:YES];
	}
	else
		NSLog(@"Could not play %@\n", p.url);
}

- (IBAction)playButtonPressed:(UIButton *)sender
{
	if (player.playing == YES)
		[self pausePlaybackForPlayer: player];
	else
    {
       // player.pause==YES;
        if (player.currentTime>0) {
            [self startPlaybackForPlayer: player];
        }
        else{
        [self updateSong];
		[self startPlaybackForPlayer: player];
        }
    }
        // musicButton.hidden=YES;
}

- (IBAction)rewButtonPressed:(UIButton *)sender
{
    /*
	if (rewTimer) [rewTimer invalidate];
	rewTimer = [NSTimer scheduledTimerWithTimeInterval:SKIP_INTERVAL target:self selector:@selector(rewind) userInfo:player repeats:YES];
     */
    if (songplaying>1) {
        songplaying=songplaying-1;
        [self updateSong];
    }
}

- (IBAction)rewButtonReleased:(UIButton *)sender
{
	if (rewTimer) [rewTimer invalidate];
	rewTimer = nil;
}

- (IBAction)ffwButtonPressed:(UIButton *)sender
{
	/*if (ffwTimer) [ffwTimer invalidate];
	ffwTimer = [NSTimer scheduledTimerWithTimeInterval:SKIP_INTERVAL target:self selector:@selector(ffwd) userInfo:player repeats:YES];
     */
    if (songplaying<[listData count]-1) {
        songplaying=songplaying+1;
        [self updateSong];
    }
}

- (IBAction)ffwButtonReleased:(UIButton *)sender
{
	if (ffwTimer) [ffwTimer invalidate];
	ffwTimer = nil;
}

- (IBAction)volumeSliderMoved:(UISlider *)sender
{
	player.volume = [sender value];
}

- (IBAction)progressSliderMoved:(UISlider *)sender
{
	player.currentTime = sender.value;
	[self updateCurrentTimeForPlayer:player];
}

- (void)dealloc
{
	[super dealloc];
	
	[fileName release];
	[playButton release];
	[ffwButton release];
	[rewButton release];
	[volumeSlider release];
	[progressBar release];
    [progresstime release];
	[currentTime release];
	[duration release];
	[lvlMeter_in release];
	
	[updateTimer release];
    [cdtimer release];
	[player release];
	[Textview release];
    [lycclose release];
	[playBtnBG release];
	[pauseBtnBG release];
	[musicplayBtnBG release];
    [musicpauseBtnBG release];
}

#pragma mark AudioSession handlers

void RouteChangeListener(	void *                  inClientData,
							AudioSessionPropertyID	inID,
							UInt32                  inDataSize,
							const void *            inData)
{
	avTouchController* This = (avTouchController*)inClientData;
	
	if (inID == kAudioSessionProperty_AudioRouteChange) {
		
		CFDictionaryRef routeDict = (CFDictionaryRef)inData;
		NSNumber* reasonValue = (NSNumber*)CFDictionaryGetValue(routeDict, CFSTR(kAudioSession_AudioRouteChangeKey_Reason));
		
		int reason = [reasonValue intValue];

		if (reason == kAudioSessionRouteChangeReason_OldDeviceUnavailable) {

			[This pausePlaybackForPlayer:This.player];
		}
	}
}

#pragma mark AVAudioPlayer delegate methods

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)p successfully:(BOOL)flag
{
	if (flag == NO)
		NSLog(@"Playback finished unsuccessfully");
		
	[p setCurrentTime:0.];
	if (inBackground)
	{
		[self updateViewForPlayerStateInBackground:p];
	}
	else
	{
		[self updateViewForPlayerState:p];
	}
}

- (void)playerDecodeErrorDidOccur:(AVAudioPlayer *)p error:(NSError *)error
{
	NSLog(@"ERROR IN DECODE: %@\n", error); 
}

// we will only get these notifications if playback was interrupted
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)p
{
	NSLog(@"Interruption begin. Updating UI for new state");
	// the object has already been paused,	we just need to update UI
	if (inBackground)
	{
		[self updateViewForPlayerStateInBackground:p];
	}
	else
	{
		[self updateViewForPlayerState:p];
	}
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)p
{
	NSLog(@"Interruption ended. Resuming playback");
	[self startPlaybackForPlayer:p];
}

#pragma mark background notifications
- (void)registerForBackgroundNotifications
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(setInBackgroundFlag)
												 name:UIApplicationWillResignActiveNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(clearInBackgroundFlag)
												 name:UIApplicationWillEnterForegroundNotification
											   object:nil];
}

- (void)setInBackgroundFlag
{
	inBackground = true;
}

- (void)clearInBackgroundFlag
{
	inBackground = false;
}


#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"table vie cellfor");
    
	
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
							 SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:SimpleTableIdentifier] autorelease];
    }
	
    
    NSUInteger row = [indexPath row];
    if (row>0) {
        
        UIImage *image = [UIImage imageNamed:@"music_photo.png"];
        cell.imageView.image = image;
    }
    cell.textLabel.text = [listData objectAtIndex:row];
	cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	
	if (row < 7)
        cell.detailTextLabel.text = @"Mr. Disney";
    else
        cell.detailTextLabel.text = @"Mr. Tolkien";
	
    return cell;
}

#pragma mark -
#pragma mark Table Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView
indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
	//NSUInteger row = [indexPath row];
    
    NSUInteger row =1;
    return row;
}

-(NSIndexPath *)tableView:(UITableView *)tableView
 willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    if (row == 0)
        return nil;
	
    return indexPath;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    songplaying=row;
	[self updateSong];
    musictable.hidden=((int)(1+musictable.hidden))%2;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
@end

