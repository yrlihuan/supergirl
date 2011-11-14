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
    IBOutlet UIBarButtonItem *showScreen;
    IBOutlet UIBarButtonItem *back;
    UIScrollView *picturesWall;
    UIViewController *thisFather;
}


@property (nonatomic,retain) IBOutlet UIBarButtonItem *showScreen,*back;
@property (nonatomic,retain) UIScrollView *picturesWall;
@property (nonatomic,retain) IBOutlet PictureViewController *pictureViewController;
@property (nonatomic,retain) IBOutlet ScreenViewController *screenViewController;
@property (nonatomic,retain) UIViewController *thisFather;
@property (nonatomic,retain) NSArray *thumbnailNames;

- (IBAction)clickSreenButton:(id)sender;
- (IBAction)goBack:(id)sender;
- (void)initSubview;
- (void)clickThisImage:(id)sender;
- (void)viewWillAppear:(BOOL)animated;

//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface TapGestureRecognizer : UITapGestureRecognizer
@property (nonatomic,assign) int imageIndex;

@end
