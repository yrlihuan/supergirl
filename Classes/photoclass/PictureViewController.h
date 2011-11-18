//
//  PictureViewController.h
//  11_17_test01
//
//  Created by xiaojia liu on 11-11-17.
//  Copyright 2011年 looa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"

#define VIEWWIDTH 320
#define VIEWHEIGHT 480
#define STATUSBARHEIGHT 20
#define PICTURESNUMBER 10
#define SCROLLWIDTH (VIEWWIDTH * PICTURESNUMBER)
#define SCROLLHEIGHT VIEWHEIGHT


@interface CellImageView : UIScrollView
@property (retain) UIImageView *coreView;
@property (retain) NSArray *picNames;
- (int)getIndex;
- (void)basicInit;
- (void)drawSelf:(int)index;
@end


@interface PictureViewController : UIViewController <UIScrollViewDelegate>
{
    int pictureIndex;
    int currentView;
    bool beHidden;
    bool whetherSaved[PICTURESNUMBER];
    bool inZooming;
}

@property (nonatomic,retain) IBOutlet UIScrollView *thisScrollView;

@property (retain) NSArray *viewArray;
@property (nonatomic,retain) IBOutlet UIImageView *toolbar;
@property (nonatomic,retain) IBOutlet UIButton *profileButton;
@property (nonatomic,retain) IBOutlet UIButton *loadButton,*lastButton,*nextButton;
@property (nonatomic,retain) IBOutlet UIButton *buttonGetBack;
@property (nonatomic,retain) IBOutlet UIImageView *topToolBar;
@property (nonatomic,retain) IBOutlet UILabel *showIndex;
@property (nonatomic,retain) InfoViewController *infoViewController;

- (IBAction)showProfile:(UIButton *)sender;
- (IBAction)lastPicture:(UIButton *)sender;
- (IBAction)nextPicture:(UIButton *)sender;
- (IBAction)downLoad:(UIButton *)sender;
- (IBAction)toGetBack:(UIButton *)sender;


- (void)startFor:(int)index;
- (void)launchFor:(int)index;
- (void)setViewsAlpha:(bool)alpha;
- (void)chooseThisImage:(UITapGestureRecognizer *)sender;
- (void)savePhoto;
- (void)showAlert;
@end
