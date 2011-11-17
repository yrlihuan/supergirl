//
//  VoiceMailStar.h
//  avTouch
//
//  Created by zhu on 11-11-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoiceMailController.h"
#import "MediaPlayer/MediaPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "VoiceReplyController.h"
@interface VoiceMailStar : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    int  star_id;
    NSString* starname;
    NSMutableArray * listData;
    IBOutlet UILabel* starlabel;
    MPMoviePlayerViewController* player;
    AVAudioPlayer* player2;
    NSUInteger voiceplaying;
}
-(IBAction)backmain:(UIButton*)sender;
-(void)getstarid:(int)starid;
@property (nonatomic,retain) NSMutableArray*  listData;
@property (nonatomic,retain) NSString* starname;

@end
