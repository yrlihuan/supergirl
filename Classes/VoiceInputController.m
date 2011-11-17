//
//  VoiceInputController.m
//  SupperGirl
//
//  Created by xiaojia liu on 11-11-15.
//  Copyright 2011年 looa. All rights reserved.
//

#import "VoiceInputController.h"

@implementation VoiceInputController

@synthesize starName;
@synthesize userID;
@synthesize inputField;

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

- (IBAction)toGetBack:(UIButton *)sender
{
    // here , we return to last view
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)toPublish:(UIButton *)sender
{
    // here , we send message to the server
    //http://xingxinghui.com/happygirl/post_reply?audio_id=1&author=roba&content=great
    NSString* url=[NSString stringWithFormat:@"http://xingxinghui.com/happygirl/post_reply?audio_id=%d&author=%@&content=%@",music_id,userID.text,inputField.text];
    [url UTF8String];
    NSLog(@"url   :%@",url);
    url=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url   :%@",url);
    [self postdata:url];
}

- (IBAction)backgroundTap:(id)sender
{
    [userID resignFirstResponder];
    [inputField resignFirstResponder];
}

#pragma mark - View lifecycle

-(void)postdata:(NSString*)urlString
{ 
    // NSString* liststring=[[dic objectForKey:@"data"] objectForKey:@"id"];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSString *contentType = [NSString stringWithFormat:@"text/html"]; 
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    //[request setAllHTTPHeaderFields:headers]; 
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    //NSLog(@"REQUEST%@",request);
    //同步返回请求，并获得返回数据
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString *pageSource = [[NSString alloc] initWithData:responseData encoding:gbkEncoding];
    
    NSString* result2 = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    // [mytoast showWithText:pageSource];
    
    //请求返回状态，如有中文无法发送请求，并且stausCode 值为 0
    
    NSLog(@"response code:%d",[urlResponse statusCode]);
    
    if([urlResponse statusCode] >= 200 && [urlResponse statusCode] <300){
        
        NSLog(@"response result2:%@",result2);
        NSLog(@"response  pagesoure:%@",pageSource);
        UIAlertView* aler=[[UIAlertView alloc]initWithTitle:@"状态" message:@"发布成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //[self.view addSubview:aler];
        [aler show];
    }else{
        UIAlertView* aler=[[UIAlertView alloc]initWithTitle:@"状态" message:@"发布失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        //[self.view addSubview:aler];
        [aler show];
    }
    
   // NSLog(@"name:%@",[listData objectAtIndex:0]);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    starName=[[UILabel alloc]init];
    starName.text=@"ssss";
    // Do any additional setup after loading the view from its nib.
}
-(void)getmusicid:(int)musicid{
    music_id=musicid;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    [starName release];
    [userID release];
    [inputField release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
