//
//  PicturesWallController.h
//  SuperGirl_11_01
//
//  Created by xiaojia liu on 11-11-3.
//  Copyright 2011年 looa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureViewController.h"
#import "ScreenViewController.h"

@interface PicturesWallController : UIViewController <UIScrollViewDelegate>
{
    UIScrollView *picturesWall;
    UIViewController *thisFather;
}

// UIObjects for displaying
@property (nonatomic,retain) IBOutlet UIButton *showScreen,*buttonGetBack;
@property (nonatomic,retain) IBOutlet UIImageView *topToolBar;
// Data for controlling
@property (nonatomic,retain) UIScrollView *picturesWall;
@property (nonatomic,retain) NSArray *thumbnailNames;
// Other controllers
@property (nonatomic,retain) IBOutlet PictureViewController *pictureViewController;
@property (nonatomic,retain) IBOutlet ScreenViewController *screenViewController;
// for getting back
@property (nonatomic,retain) UIViewController *thisFather;

- (IBAction)clickSreenButton:(id)sender;
- (IBAction)toGetBack:(id)sender;

- (void)initSubview;
- (void)clickThisImage:(id)sender;
- (void)viewWillAppear:(BOOL)animated;
- (void)initPicturesWall;

@end

@interface TapGestureRecognizer : UITapGestureRecognizer
@property (nonatomic,assign) int imageIndex;

@end
