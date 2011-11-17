//
//  VoiceInputController.h
//  SupperGirl
//
//  Created by xiaojia liu on 11-11-15.
//  Copyright 2011年 looa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VoiceInputController : UIViewController
{
    int  music_id;
}
@property (nonatomic,retain) IBOutlet UILabel *starName;
@property (nonatomic,retain) IBOutlet UITextField *userID;
@property (nonatomic,retain) IBOutlet UITextView *inputField;
-(void)getmusicid:(int)musicid;
- (IBAction)backgroundTap:(id)sender;

- (IBAction) toGetBack:(UIButton *)sender;
- (IBAction) toPublish:(UIButton *)sender;
@end
