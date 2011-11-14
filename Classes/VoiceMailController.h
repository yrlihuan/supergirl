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
@interface VoiceMailController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *listData;

}
@property (nonatomic,retain) NSArray *listData;
-(IBAction)backmain:(UIButton*)sender;
@end
