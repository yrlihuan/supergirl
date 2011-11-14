//
//  ScreenViewController.h
//  SuperGirl_11_01
//
//  Created by xiaojia liu on 11-11-7.
//  Copyright 2011年 looa. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScreenViewController : UIViewController
{
    IBOutlet UILabel *timeReveal;
    IBOutlet UILabel *dateReveal;
    IBOutlet UIButton *departureButton;
    IBOutlet UIButton *lockButton;
    IBOutlet UIImageView *pictureView;
    bool departureFlag;
    bool lockedFlag;
    int pictureIndex;
    UIViewController *thisFather;
}
@property (nonatomic,retain) IBOutlet UILabel *timeReveal;
@property (nonatomic,retain) IBOutlet UILabel *dateReveal;
@property (nonatomic,retain) IBOutlet UIButton * departureButton;
@property (nonatomic,retain) IBOutlet UIButton * lockButton;
@property (nonatomic,retain) IBOutlet UIImageView *pictureView;
@property (nonatomic,retain) UIViewController *thisFather;

- (void)setCalendar;
- (void)changePicture;
- (IBAction)viewDeparture:(UIButton *)sender;
- (void)startAnimate;
- (IBAction)viewLocked:(UIButton *)sender;
@end