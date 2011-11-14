//
//  VoiceMailStar.m
//  avTouch
//
//  Created by zhu on 11-11-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "VoiceMailStar.h"

@implementation VoiceMailStar
@synthesize listData;
@synthesize starname;
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
-(IBAction)backmain:(UIButton*)sender{
    [self dismissModalViewControllerAnimated:YES ];
    [player.moviePlayer stop];
    [self autorelease];
    
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    voiceplaying=0;
        // [player.moviePlayer play];
    //if (player) {
       // player.moviePlayer.view.frame = CGRectMake(0, 100, 320,400 );
        //[player.moviePlayer.view setBackgroundColor:[UIColor clearColor]];
       // [self.view addSubview:player.view];
        NSLog(@"net music working");
    //}
    
    
    listData=[[NSMutableArray alloc] init];
    starlabel.text=[starname stringByAppendingString:@"的语音留言"];
    // listData = [[NSArray alloc] initWithObjects:@"刘忻", @"杨洋",@"段林希",@"洪辰",@"苏妙玲", nil];
     NSString* urlString=[NSString stringWithFormat:@"http://xingxinghui.com/happygirl/get_star_audio?star_id=%d",star_id];
    [self postdata:urlString];
    // Do any additional setup after loading the view from its nib.
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
-(void)getstarid:(int)starid{
    star_id=starid;
}
-(void)postdata:(NSString*)urlString
{
    
    
    // NSString* liststring=[[dic objectForKey:@"data"] objectForKey:@"id"];
    NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    /*
     NSString *post = @"";  
     NSData   *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];  
     NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];  
     NSMutableDictionary* headers = [[NSMutableDictionary alloc] init];
     [headers setValue:@"text/html；charset=utf-8" forKey:@"Content-Type"];
     [headers setValue:[NSString stringWithFormat:@"%d",postLength] forKey:@"Content-Length"];
     [headers setValue:@"MIMEType" forKey:@"Accept"];
     [headers setValue:@"no-cache" forKey:@"Cache-Control"];*/
    // [headers setValue:email forKey:@"email"];
    //[headers setValue:name forKey:@"username"];
    //[headers setValue: password forKey:@"password"]    
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
    NSMutableArray *dic = (NSMutableArray *)[parser objectWithString:result2] ;   
    for (int i=0; i<[dic count]; i++) {
        NSString*  voicename=[[dic objectAtIndex:i] objectForKey:@"url"];
        NSLog(@"name2:%@",voicename);
        [listData addObject:voicename];
        NSString* post_time=[[dic objectAtIndex:i] objectForKey:@"post_time"];
        [listData addObject:post_time];
        NSString* reply_int=[NSString stringWithFormat:@"%@",[[dic objectAtIndex:i] objectForKey:@"reply_cnt"]];
        [listData addObject:reply_int];
         //NSLog(@"reply_int   :%@",reply_int);
        NSString* audio_id=[NSString stringWithFormat:@"%d",[[dic objectAtIndex:i] objectForKey:@"audio_id"]];
        [listData addObject:audio_id];

        
    }
  //  NSLog(@"name:%@",[listData objectAtIndex:0]);
}
-(void)voiceplay:(id)sender{
     UIImage *imageselected = [UIImage imageNamed:@"voicemail_on.png"];
    //UIImageView *headimage=[[UIImageView alloc] init];
    //headimage.frame=CGRectMake(25, 40, 20 , 20);
    //headimage.image=image;
    //cell.imageView.image = image;
    //[cell.contentView addSubview:headimage];
    UIButton * voiceplaybt=(UIButton*)sender;
   [voiceplaybt setImage:imageselected forState:UIControlStateNormal];
    //[player play];
    NSUInteger songplaying;
    songplaying=voiceplaying;
    voiceplaying=voiceplaybt.tag;
    NSLog(@"1:%d",voiceplaying);
    NSString* voicename=[listData objectAtIndex:(voiceplaying*4)];

    NSString* header=@"http://xingxinghui.com/happygirl";
    voicename=[header stringByAppendingString:voicename];
    NSLog(@"all:%@",voicename);
    NSString* xx=@"http://mp3.baidu.com/j?j=2&url=http%3A%2F%2Fzhangmenshiting2.baidu.com%2Fdata2%2Fmusic%2F283676%2F283676.mp3%3Fxcode%3Dc8c4e8233024ad113a905004ccbf3834";
    NSURL *movieURL =[[NSURL alloc] initWithString:voicename];
   // [self.view addSubview:player.view];
   // player = [[MPMoviePlayerViewController alloc] 
    //          initWithContentURL:movieURL];
    //[player.moviePlayer  pause];
    
    if (player.moviePlayer.playbackState==MPMoviePlaybackStatePlaying) {
        if (songplaying==voiceplaying) {
            //player = [[MPMoviePlayerViewController alloc] 
              //        initWithContentURL:movieURL];
            [player.moviePlayer pause];
        }
        else
        {
        player = [[MPMoviePlayerViewController alloc] 
                  initWithContentURL:movieURL];
        [player.moviePlayer play];
        }
    }
    else if(player.moviePlayer.playbackState==MPMoviePlaybackStatePaused){
        if (songplaying==voiceplaying) {
            //player = [[MPMoviePlayerViewController alloc] 
            //        initWithContentURL:movieURL];
            [player.moviePlayer play];
        }
        else
        {
            player = [[MPMoviePlayerViewController alloc] 
                      initWithContentURL:movieURL];
            [player.moviePlayer play];
        }
    }
    else{
        player = [[MPMoviePlayerViewController alloc] 
                  initWithContentURL:movieURL];
        [player.moviePlayer play];
    }
   // [self.view addSubview:player.view];
    
    /*
    player=[[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
   // [player.moviePlayer play];
    player.moviePlayer.view.frame = CGRectMake(0, 340, 320, 5);
    [player.moviePlayer.view setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:player.view];*/
    
    //[self.view addSubview:musicPlayer.view];

    NSLog(@"successful");
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.listData count]/4;
}

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
    
    UIImage *image = [UIImage imageNamed:@"voicemail_off.png"];
    UIImage *imageselected = [UIImage imageNamed:@"voicemail_on.png"];
    //UIImageView *headimage=[[UIImageView alloc] init];
    //headimage.frame=CGRectMake(25, 40, 20 , 20);
    //headimage.image=image;
    //cell.imageView.image = image;
    //[cell.contentView addSubview:headimage];
    UIButton * voiceplaybt=[[UIButton alloc] initWithFrame:CGRectMake(25, 40, 20 , 20)];
    [voiceplaybt setImage:image forState:UIControlStateNormal];
    //[voiceplaybt setImage:imageselected forState:UIControlEventTouchDown];
    voiceplaybt.tag=row;
    [voiceplaybt addTarget:self action:@selector(voiceplay:) forControlEvents:UIControlEventTouchDown];
    //[self performSelector:@selector(voiceplay) withObject:voiceplaybt];
   // voiceplaybt
   // voiceplaybt.frame=CGRectMake(25, 40, 20 , 20);
    [cell.contentView addSubview:voiceplaybt];
    UIImageView*  cellback=[[UIImageView alloc] init];
    UIView * cellview=[[UIView alloc] init];
    cellback.frame=CGRectMake(10, 15, 220, 60);
    
    cellback.image=[UIImage imageNamed:@"voicemail_back_2.png"];
    [cellview addSubview:cellback];
    cell.backgroundView=cellview;
    //cell.detailTextLabel.text=@"            %@";
    NSString *blank2=@"                                                    ";
    cell.detailTextLabel.text=[blank2 stringByAppendingFormat:@"%@条留言",[listData objectAtIndex:(4*row+2)]];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:15];
    
    cell.textLabel.text = [blank stringByAppendingString:[listData objectAtIndex:(4*row+1)]];
    //cell.textLabel.center=CGPointMake(300, 40);
	cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    return cell;
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
    voiceplaying = [indexPath row];
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
    
        return 80;
   
}
@end
