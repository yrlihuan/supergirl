//
//  VoiceReplyController.h
//  SupperGirl
//
//  Created by zhu on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJSON.h"
#import "VoiceInputController.h"
#define kUserphoto 1
#define kBackgroundphoto 2
#define kUsername 3
#define kReplytext 4
@interface VoiceReplyController : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    int  music_id;
    NSString* starname;
    NSMutableArray * listData;
    IBOutlet UILabel* starlabel;
    IBOutlet UITableViewCell* tvCell;
    IBOutlet UITableViewCell* tvCell2;
}
-(IBAction)backmain:(UIButton*)sender;
-(IBAction)inputbt:(id)sender;
-(void)getmusicid:(int)musicid;
@property (nonatomic,retain) NSMutableArray*  listData;
@property (nonatomic,retain) NSString* starname;
@property (nonatomic ,retain) UITableViewCell *tvCell;
@property (nonatomic ,retain) UITableViewCell *tvCell2;
@end
