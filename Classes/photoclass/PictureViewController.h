//
//  PictureViewController.h
//  SuperGirl_11_01
//
//  Created by xiaojia liu on 11-11-7.
//  Copyright 2011年 looa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"

#define pictureWidth 320
#define pictureGap 0
#define pictureHeightInside 480
#define pictureWidthInterval (pictureWidth + pictureGap)
#define pictureSum 10
#define showAlpha 0.8

#define VIEWWIDTH 320
#define VIEWHEIGHT 480
#define STATUSBARHEIGHT 20
#define SCROLLWIDTH (VIEWWIDTH * PICTURESNUMBER)
#define SCROLLHEIGHT VIEWHEIGHT
// below is the PictureViewController : UIViewController <UIScrollViewDelegate>
@interface PictureViewController : UIViewController <UIScrollViewDelegate>
{    
    NSArray *viewArray;
    int currentIndex;
    int lastIndex;
    int nextIndex;
    
    int pictureIndex; 
    int contentOffetX;
    
    bool beHidden;
    
    bool whetherSaved[pictureSum];
    bool ableZoom;
    CGSize normalSize;

}
// this is for displaying
@property (nonatomic,retain) IBOutlet UIImageView *toolbar;
@property (nonatomic,retain) IBOutlet UIScrollView *thisScrollView;
@property (nonatomic,retain) IBOutlet UIButton *profileButton;
@property (nonatomic,retain) IBOutlet UIButton *loadButton,*lastButton,*nextButton;
@property (nonatomic,retain) IBOutlet UIButton *buttonGetBack;
@property (nonatomic,retain) IBOutlet UIImageView *topToolBar;
@property (nonatomic,retain) IBOutlet UILabel *showIndex;

// below is for data controlling
@property (nonatomic,retain) NSArray *viewArray;
@property (nonatomic,retain) InfoViewController *infoViewController;
@property (assign) int pictureIndex;
@property (nonatomic,retain) NSArray *picNames;



- (void)setViews:(int)where sourceWith:(int)source;
- (IBAction)showProfile:(UIButton *)sender;
- (IBAction)lastPicture:(UIButton *)sender;
- (IBAction)nextPicture:(UIButton *)sender;
- (void)startView:(int)source;
//- (void)moveForLast;
//- (void)moveForNext;
- (void)chooseThisImage:(id)sender;
- (void)initAllViews;
//- (void)initSuperViews;
- (void)initScrollView;
- (IBAction)downLoad:(UIButton *)sender;
- (void)savePhoto;
- (void)setIndex;
- (IBAction)toGetBack:(UIButton *)sender;

@end
