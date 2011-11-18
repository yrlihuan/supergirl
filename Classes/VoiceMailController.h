//
//  VoiceMailController.h
//  avTouch
//
//  Created by zhu on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON.h"
#import "VoiceMailStar.h"
#import "avTouchController.h"
@interface VoiceMailController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *listData;
    avTouchController *controller;
}
@property (nonatomic,retain) NSArray *listData;

-(IBAction)backmain:(UIButton*)sender;
@property (nonatomic,retain) avTouchController *controller;
@end
