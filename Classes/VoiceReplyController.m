//
//  VoiceReplyController.m
//  SupperGirl
//
//  Created by zhu on 11-11-15.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "VoiceReplyController.h"

@implementation VoiceReplyController
@synthesize listData;
@synthesize starname;
@synthesize tvCell;
@synthesize tvCell2;

#define replywith 200
#define defaultheight  60

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)backmain:(UIButton*)sender{
    [self dismissModalViewControllerAnimated:YES ];
    [self autorelease]; 
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)getmusicid:(int)musicid{
    music_id=musicid;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *familyNames = [UIFont familyNames];  
    for( NSString *familyName in familyNames ){  
        NSLog( @"Family: %s \n", [familyName UTF8String] );  
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];  
        for( NSString *fontName in fontNames ){  
            NSLog(@"\tFont: %s \n", [fontName UTF8String] );  
        }  
    }
    // Do any additional setup after loading the view from its nib.
   // [player.moviePlayer play];
    //if (player) {
    // player.moviePlayer.view.frame = CGRectMake(0, 100, 320,400 );
    //[player.moviePlayer.view setBackgroundColor:[UIColor clearColor]];
    // [self.view addSubview:player.view];
    NSLog(@"net music working");
    //}
   // music_id=1;
    
    listData=[[NSMutableArray alloc] init];
    starlabel.text=[starname stringByAppendingString:@"的语音留言"];
    // listData = [[NSArray alloc] initWithObjects:@"刘忻", @"杨洋",@"段林希",@"洪辰",@"苏妙玲", nil];
    NSString* urlString=[NSString stringWithFormat:@"http://xingxinghui.com/happygirl/get_reply?audio_id=%d&begin=0&count=50",music_id];
    [self postdata:urlString];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)postdata:(NSString*)urlString
{ 
    // NSString* liststring=[[dic objectForKey:@"data"] objectForKey:@"id"];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    NSString *contentType = [NSString stringWithFormat:@"plain/text"]; 
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
        
        NSLog(@"response:%@",result2);
        NSLog(@"response:%@",pageSource);
    }
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *nsdic=(NSDictionary*)[parser objectWithString:result2] ;
    //NSMutableArray *dic = (NSMutableArray *)[parser objectWithString:result2] ;   
    NSMutableArray *dic = (NSMutableArray*)[nsdic objectForKey:@"reply"]; 
    for (int i=0; i<[dic count]; i++) {
        NSString*  content=[[dic objectAtIndex:i] objectForKey:@"content"];
       // NSLog(@"name2:%@",content);
        [listData addObject:content];
        NSString* author=[[dic objectAtIndex:i] objectForKey:@"author"];
        [listData addObject:author];
        NSString* reply_time=[[dic objectAtIndex:i] objectForKey:@"reply_time"];
        [listData addObject:reply_time];
    }
     // NSLog(@"name:%@",[listData objectAtIndex:0]);
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.listData count]/3;
   // return 4;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"table vie cellfor");
    
	
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
							 SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleSubtitle
				 reuseIdentifier:SimpleTableIdentifier] autorelease];
    }
	
    
    NSUInteger row = [indexPath row];
    NSString *blank=@"            ";
    for (UIView* subviews in [cell.contentView subviews]) {
        [subviews removeFromSuperview];
    } 
    
    UITextView * replyuser=[[UITextView alloc] initWithFrame:CGRectMake(20, 0, 300, 40)];
    replyuser.text=[listData objectAtIndex:(3*row+1)];
    replyuser.editable=YES;
    replyuser.font=[UIFont boldSystemFontOfSize:20];
    replyuser.textColor=[UIColor redColor];
    replyuser.backgroundColor=[UIColor clearColor];
    [cell.contentView addSubview:replyuser];
    
    NSString*   teststring=[listData objectAtIndex:(3*row)];
    UITextView* replytext=[[UITextView alloc] initWithFrame:CGRectMake(10, 20, 0, 0)];
    NSLog(@"string length:%@",teststring);
    replytext.editable=NO;
    replytext.font=[UIFont boldSystemFontOfSize:15];
    replytext.backgroundColor=[UIColor clearColor];
    replytext.text=teststring;
    CGSize     labelsize = [teststring sizeWithFont:replytext.font];
    replytext.frame=CGRectMake(20, labelsize.height*2, 300, (labelsize.width/replywith+2)*(labelsize.height)+20);
    [cell.contentView addSubview:replytext];
    

    UIImageView*  cellback=[[UIImageView alloc] init];
    UIView * cellview=[[UIView alloc] init];
    cellback.frame=CGRectMake(10, labelsize.height, 300, (labelsize.width/replywith+2)*(labelsize.height)+20);
    UIImage * bacgroundimage=[UIImage imageNamed:@"voicemail_back_2.png"];
    cellback.image=[bacgroundimage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    
    
    [cellview addSubview:cellback];
    
    cell.backgroundView=cellview;
   // teststring=@"test test test test test test test test test test test test test test test test test test test test test test\n test test test test test test test test test test test test test test test test test test ";
   // cell.detailTextLabel.text=teststring;
   // cell.detailTextLabel.font=[UIFont boldSystemFontOfSize:15];
    
   // cell.textLabel.text = [blank stringByAppendingString:[listData objectAtIndex:(3*row+1)]];
    //cell.textLabel.center=CGPointMake(300, 40);
	//cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
    [cellback release];
    [replytext release];
    [replyuser release];
    return cell;
}*/
- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
     NSUInteger row=[indexPath row];
   // NSLog(@"rou :%d",row);
    if (cell==nil) {
       // NSLog(@"row 2:%d",row%2);
    //   if ((row%2)==1) {
           
           NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"ReplyCell" owner:self options:nil];
           if ([nib count]>0) 
           {
             cell=self.tvCell;
           }else{
               NSLog(@"failed to load cell nib file!!");
           }
     /*  }else{
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"ReplyCell_right" owner:self options:nil];
        if ([nib count]>0) 
        {
            cell=self.tvCell2;
        }else{
            NSLog(@"failed to load cell nib file!!");
        }
       }*/
    }
    int  spacenum;
    spacenum=0;
    
   
    NSString* teststring=[listData objectAtIndex:(3*row)];
    UIFont* font=[UIFont fontWithName:@"MicrosoftYaHei" size:14];
    CGSize labelsize = [teststring sizeWithFont:font];
    
    NSArray * teststringbyspacing=[teststring componentsSeparatedByString:@"\n"];
    for (int i=0; i<[teststringbyspacing count]; i++) {
        CGSize size=[[teststringbyspacing objectAtIndex:i] sizeWithFont:font];
        spacenum=spacenum+size.width/replywith+1;
    }
    int  cellheight=(((spacenum)*(labelsize.height)+40)>defaultheight?((spacenum)*(labelsize.height)+40): defaultheight);
    cell.frame=CGRectMake(0, 0, 310, cellheight);

    UIImageView* userphoto=(UIImageView*)[cell viewWithTag:kUserphoto];
    userphoto.image=[UIImage imageNamed:@"fans_42.png"];
    UIImageView* background=(UIImageView*)[cell viewWithTag:kBackgroundphoto];
    //if ((row%2)==1) {
    background.image=[[UIImage imageNamed:@"voicemail_back_2.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:30];
   // }
    /*else{
    background.image=[[UIImage imageNamed:@"voicemail_back_1.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:30];
    }*/
    background.frame=CGRectMake(0, 5, 240, cellheight-5);
    
    UILabel* username=(UILabel*)[cell viewWithTag:kUsername];
    username.text=[[listData objectAtIndex:(3*row+1)] stringByAppendingString:@":"];
    username.font=[UIFont fontWithName:@"MicrosoftYaHei" size:16];
    UITextView *replytext=(UITextView*)[cell viewWithTag:kReplytext];
    replytext.text=[listData objectAtIndex:(3*row)];
    replytext.editable=NO;
    replytext.font=[UIFont fontWithName:@"MicrosoftYaHei" size:14];
    replytext.frame=CGRectMake(13, 20, 200, cellheight-35);
    replytext.scrollEnabled=NO;
    
    
    return cell;
}
-(IBAction)inputbt:(id)sender{
    VoiceInputController* voiceinput=[[VoiceInputController alloc]init];
    [voiceinput getmusicid:music_id];
    [self presentModalViewController:voiceinput animated:YES];
}
#pragma mark -
#pragma mark Table Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView
indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
	//NSUInteger row = [indexPath row];
    
    NSUInteger row =2;
    return row;
}

-(NSIndexPath *)tableView:(UITableView *)tableView
 willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    // if (row == 0)
    //   return nil;
	
    return nil;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    // songplaying=row;
	//[self updateSong];
    //  musictable.hidden=((int)(1+musictable.hidden))%2;
    // VoiceMailStar* voicestar=[[VoiceMailStar alloc] init];
    //[voicestar getstarid:(int)(row+1)];
    //  [self presentModalViewController:voicestar animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    NSString* teststring=[listData objectAtIndex:(3*row)];
     // CGFloat fontsize=replytext.font.;
    UIFont* font=[UIFont fontWithName:@"MicrosoftYaHei" size:14];
    CGSize labelsize = [teststring sizeWithFont:font];
    int  spacenum;
    spacenum=0;
    
    NSArray * teststringbyspacing=[teststring componentsSeparatedByString:@"\n"];
    for (int i=0; i<[teststringbyspacing count]; i++) {
        CGSize size=[[teststringbyspacing objectAtIndex:i] sizeWithFont:font];
        spacenum=spacenum+size.width/replywith+1;
    }
   
    
    return (((spacenum)*(labelsize.height)+40)>defaultheight?((spacenum)*(labelsize.height)+40): defaultheight);
    
}
@end
