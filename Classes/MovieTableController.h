//
//  MovieTableController.h
//  avTouch
//
//  Created by zhu on 10/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer/MediaPlayer.h"
@class avTouchViewController;
#import "avTouchController.h"
@interface MovieTableController : UITableViewController {
    NSArray         *listdata;
    MPMoviePlayerViewController    *movieplayer;
    avTouchViewController *mainviewcontroller;
    avTouchController *controller;
}
@property (nonatomic,retain) NSArray    *listdata;
@property (nonatomic,retain) MPMoviePlayerViewController *movieplayer;
@property (nonatomic,retain) avTouchViewController *mainviewcontroller;
@property (nonatomic,retain) avTouchController *controller;
@end
