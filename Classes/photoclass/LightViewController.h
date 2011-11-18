//
//  LightViewController.h
//  SuperGirl_11_01
//
//  Created by xiaojia liu on 11-11-12.
//  Copyright 2011年 looa. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LightViewController : UIViewController <UIScrollViewDelegate> {
    bool beHidden;
}
//used to get back to the mainview
@property (nonatomic, retain) UIViewController *thisFather;

//used to show in the view
@property (nonatomic, retain) IBOutlet UIScrollView *thisScrollView;
@property (nonatomic, retain) IBOutlet UIImageView *topToolBar;
@property (nonatomic, retain) IBOutlet UIButton *buttonGetBack;
@property (nonatomic, retain) IBOutlet UILabel *thisTittle;


- (void)chooseThisImage:(id)sender;

- (IBAction)toGetBack:(UIButton*)sender;

- (void)initScrollView;
@end