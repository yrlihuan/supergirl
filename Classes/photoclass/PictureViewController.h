//
//  PictureViewController.h
//  SuperGirl_11_01
//
//  Created by xiaojia liu on 11-11-7.
//  Copyright 2011年 looa. All rights reserved.
//

#import <UIKit/UIKit.h>

#define pictureWidth 320
#define pictureGap 0
#define pictureHeightInside 480
#define pictureWidthInterval (pictureWidth + pictureGap)
#define pictureSum 10
#define showAlpha 0.8
@interface InfoViewController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UITextView *textView;
    IBOutlet UIImageView *profileView;
    
    int currentIndex;
    
}

@property (nonatomic,retain) IBOutlet UITextView *textView;
@property (nonatomic,retain) IBOutlet UIImageView *profileView;

@end
@interface PictureViewController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIToolbar *toolbar;
    IBOutlet UIScrollView *thisScrollView;
    IBOutlet UIBarButtonItem *profileButton;
    IBOutlet UIBarButtonItem *lastButton;
    IBOutlet UIBarButtonItem *nextButton;
    
    InfoViewController *infoViewController;
    
    NSArray *viewArray;
    int currentIndex;
    int lastIndex;
    int nextIndex;
    
    int pictureIndex; 
    int contentOffetX;
    
    bool beHidden;
    
    bool whetherSaved[pictureSum];    
}

@property (nonatomic,retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic,retain) IBOutlet UIScrollView *thisScrollView;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *profileButton;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *lastButton,*nextButton;
@property (nonatomic,retain) NSArray *viewArray;
@property (nonatomic,retain) InfoViewController *infoViewController;
@property (assign) int pictureIndex;
@property (nonatomic,retain) NSArray *picNames;



- (void)setViews:(int)where sourceWith:(int)source;
- (IBAction)showProfile:(id)sender;
- (IBAction)lastPicture:(id)sender;
- (IBAction)nextPicture:(id)sender;
- (void)startView:(int)source;
- (void)moveForLast;
- (void)moveForNext;
- (void)chooseThisImage:(id)sender;
- (void)initAllViews;
- (void)initSuperViews;
- (void)initScrollView;
- (IBAction)downLoad;
- (void)savePhoto;
- (void)setIndex;

@end
