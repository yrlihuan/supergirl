#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "MediaPlayer/MediaPlayer.h"
#import "cnvUILabel.h"
@class CALevelMeter;

@interface avTouchController : NSObject <UIPickerViewDelegate, AVAudioPlayerDelegate,UITableViewDelegate, UITableViewDataSource> {

	IBOutlet UILabel					*fileName;
	IBOutlet UIButton					*playButton;
	IBOutlet UIButton					*ffwButton;
	IBOutlet UIButton					*rewButton;
    IBOutlet UIButton                   *musicButton;
	IBOutlet UISlider					*volumeSlider;
	IBOutlet UISlider					*progressBar;
    IBOutlet UIProgressView             *progresstime;
	IBOutlet UILabel					*currentTime;
	IBOutlet UILabel					*duration;
    IBOutlet UITableView                *musictable;
	IBOutlet CALevelMeter				*lvlMeter_in;
    IBOutlet UIView                     *movieview;
	NSArray *listData;
	AVAudioPlayer						*player;
    NSInteger                           songplaying;
    MPMoviePlayerViewController         *movieplayer;
    NSArray                             *array;
    
	UIImage								*playBtnBG;
	UIImage								*pauseBtnBG;
    UIImage								*musicplayBtnBG;
    UIImage								*musicpauseBtnBG;
    IBOutlet  UIImageView                         *cdimage;
    IBOutlet UIView                              *cdview;
    IBOutlet UIView *Textview;
    //cnvUILabel                 *lycview;
    UITextView *  lycview;
    UITextView *  lycshowing;
    IBOutlet  UIButton                  *lycclose;
    
   // DrawString * xx;
    
    CGFloat                             cdangle;
    NSTimer                             *cdtimer;
    NSTimer                             *cdmovetimer;
	NSTimer								*updateTimer;
    NSTimer                             *myTimer;
    NSInteger                           listplaying;
	float                               timetemp;
	BOOL								inBackground;
}

- (IBAction)playButtonPressed:(UIButton*)sender;
- (IBAction)rewButtonPressed:(UIButton*)sender;
- (IBAction)rewButtonReleased:(UIButton*)sender;
- (IBAction)ffwButtonPressed:(UIButton*)sender;
- (IBAction)ffwButtonReleased:(UIButton*)sender;
- (IBAction)volumeSliderMoved:(UISlider*)sender;
- (IBAction)progressSliderMoved:(UISlider*)sender;
- (IBAction)musiclist:(UIButton*)sender;
- (IBAction)lyclist:(UIButton*)sender;
//- (IBAction)recorderlist:(UIButton*)sender;


- (void)registerForBackgroundNotifications;
- (void)updateViewForPlayerInfo:(AVAudioPlayer*)p;
- (void)startPlaybackForPlayer:(AVAudioPlayer*)p;
- (void)updateViewForPlayerState:(AVAudioPlayer *)p;
- (void)lycshow;


@property (nonatomic, retain)	UILabel			*fileName;
@property (nonatomic, retain)	UIButton		*playButton;
@property (nonatomic, retain)	UIButton		*ffwButton;
@property (nonatomic, retain)	UIButton		*rewButton;
@property (nonatomic, retain)   UIButton        *musicButton;
@property (nonatomic, retain)	UISlider		*volumeSlider;
@property (nonatomic, retain)	UISlider		*progressBar;
@property (nonatomic, retain)	UIProgressView	*progresstime;
@property (nonatomic, retain)	UILabel			*currentTime;
@property (nonatomic, retain)	UILabel			*duration;
@property (nonatomic, retain)   UITableView     *musictable;
@property (nonatomic, retain)   UIView          *movieview;
@property (retain)				CALevelMeter	*lvlMeter_in;

@property (nonatomic ,retain) NSArray *listData;
@property (nonatomic ,retain) NSArray *array;

@property (nonatomic, retain)	NSTimer			*updateTimer,*myTimer;
@property (nonatomic, assign)	AVAudioPlayer	*player;
@property (nonatomic, assign)	MPMoviePlayerViewController	*movieplayer;

@property (nonatomic, assign)	BOOL			inBackground;
@end