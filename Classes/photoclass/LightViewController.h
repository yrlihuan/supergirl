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
    double thisAlpha;
}
@property (nonatomic,retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic,retain) IBOutlet UIScrollView *thisScrollView;
@property (nonatomic,retain) UIViewController *thisFather;


- (void)chooseThisImage:(id)sender;

- (IBAction)toGetBack:(UIButton*)sender;
@end