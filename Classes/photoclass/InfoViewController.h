//
//  InfoViewController.h
//  SupperGirl
//
//  Created by xiaojia liu on 11-11-14.
//  Copyright 2011年 looa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController <UIScrollViewDelegate>
{
    UITextView *textView;
    IBOutlet UIImageView *profileView;
    
    IBOutlet UILabel *girlName;    
    int currentIndex;
    
}

@property (nonatomic,retain) UITextView *textView;
@property (nonatomic,retain) IBOutlet UIImageView *profileView;
@property (nonatomic,retain) IBOutlet UILabel *girlName;
@property (assign) int currentIndex;
@property (nonatomic,retain) IBOutlet UIImageView *profileBack;

- (void)firstInit;
- (void)setContent;
@end

