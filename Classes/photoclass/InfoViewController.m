//
//  InfoViewController.m
//  SupperGirl
//
//  Created by xiaojia liu on 11-11-14.
//  Copyright 2011年 looa. All rights reserved.
//

#import "InfoViewController.h"

#define topBound 10
#define leftBound 50
#define profileTopBound 8
#define profileLeftBound 4


@implementation InfoViewController
@synthesize textView;
@synthesize profileView;
@synthesize girlName;
@synthesize currentIndex;
@synthesize profileBack;
- (NSString*)getName:(bool)Chinese
{
    if (currentIndex <= 2)
    {
        return Chinese?[NSString stringWithFormat:@"段林希"]:[NSString stringWithFormat:@"DuanLinXi"];
    }
    else if (currentIndex <= 4)
    {
        return Chinese?[NSString stringWithFormat:@"洪辰"]:[NSString stringWithFormat:@"HongChen"];
    }
    else if (currentIndex <= 6)
    {
        return Chinese?[NSString stringWithFormat:@"刘忻"]:[NSString stringWithFormat:@"LiuXin"];
    }
    else if (currentIndex <= 8)
    {
        return Chinese?[NSString stringWithFormat:@"苏妙玲"]:[NSString stringWithFormat:@"SuMiaoLing"];
    }
    else
    {
        return Chinese?[NSString stringWithFormat:@"杨洋"]:[NSString stringWithFormat:@"YangYang"];
    }
}
- (void)setContent
{
    [girlName setText:[self getName:true]];    
    UIImage *profileImage = [UIImage imageNamed:[NSString stringWithFormat:@"Profile%@.jpg",[self getName:false]]];
    if (profileImage == nil)
        NSLog(@"ByeBye");
    [profileView setImage:profileImage];
    NSString *txtName = [NSString stringWithFormat:@"Info_%@",[self getName:false]];
    NSString *path = [[NSBundle mainBundle] pathForResource:txtName ofType:@"txt"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:path];
    NSString *textContent = [NSString stringWithContentsOfURL:url encoding:NSUnicodeStringEncoding error:nil];
    [url release];
    
    [textView setText:textContent];
    //NSLog(@"%d :Set has commited",currentIndex);
}
- (void)firstInit
{
    textView = [[UITextView alloc] initWithFrame:CGRectMake(40, 240, 240, 220)];
    [textView setEditable:false];
    
    UIColor *tempColor = [[UIColor alloc] initWithWhite:0.0 alpha:0.0];    
    [textView setBackgroundColor:tempColor];
    [tempColor release];
    [self.view addSubview:textView];
    [self.view sendSubviewToBack:profileBack];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self firstInit];
    
    //textView = [UITextView alloc] initWithFrame:CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    [textView release];
    [profileView release];
    [girlName release];
    [profileBack release];
}
- (IBAction)toGetBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    return;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
