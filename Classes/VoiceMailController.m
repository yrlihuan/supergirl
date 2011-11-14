//
//  VoiceMailController.m
//  avTouch
//
//  Created by zhu on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VoiceMailController.h"
@implementation VoiceMailController
@synthesize listData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
-(void)getvoicelist
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
   // NSString* result;
    NSDictionary *dic = (NSDictionary *)[parser objectWithString:result] ;
    
  // NSString* liststring=[[dic objectForKey:@"data"] objectForKey:@"id"];
    
    NSString* urlString=@"http://xingxinghui.com/happygirl/main_page";
    
    //NSLog(@"xxxx:%@ sdfsf%@",liststring,mywishtext.text) ;
   // NSLog(@"%@",urlString);
    [self postdata:urlString];
    
}*/
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
        
       // NSLog(@"response:%@",result2);
       // NSLog(@"response:%@",pageSource);
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSMutableArray *dic = (NSMutableArray *)[parser objectWithString:result2] ;   
        for (int i=0; i<[dic count]; i++) {
            NSString*  starname=[[dic objectAtIndex:i] objectForKey:@"name"];
            NSLog(@"name2:%@",starname);
            [listData addObject:starname];
            NSString* last_audio_time=[[dic objectAtIndex:i] objectForKey:@"last_update"];
            [listData addObject:last_audio_time];
            
        }
       
    }
    else
    {
        //[self dismissModalViewControllerAnimated:YES ];
        //[self autorelease];
        //NSAssert(<#condition#>, <#desc#>, <#...#>)
        UIAlertView* aler=[[UIAlertView alloc]initWithTitle:@"Warning" message:@"Network Failed!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        //[self.view addSubview:aler];
        [aler show];
        NSLog(@"failed network");
    }
    
   // NSLog(@"name:%@",[listData objectAtIndex:0]);
}
- (void)deallo
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    listData=[[NSMutableArray alloc] init];
   // listData = [[NSArray alloc] initWithObjects:@"刘忻", @"杨洋",@"段林希",@"洪辰",@"苏妙玲", nil];
    NSString* urlString=@"http://xingxinghui.com/happygirl/main_page";
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
-(IBAction)backmain:(UIButton*)sender{
    [self dismissModalViewControllerAnimated:YES ];
    
}
#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.listData count]/2;
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
        
        UIImage *image = [UIImage imageNamed:@"music_photo.png"];
        UIImageView *headimage=[[UIImageView alloc] init];
        headimage.frame=CGRectMake(15, 7, 65, 65);
        headimage.image=image;
        //cell.imageView.image = image;
        [cell.contentView addSubview:headimage];
        UIImageView*  cellback=[[UIImageView alloc] init];
        UIView * cellview=[[UIView alloc] init];
        cellback.frame=CGRectMake(10, 5, 300, 70);
        
        cellback.image=[UIImage imageNamed:@"voice_peoplelist_back.png"];
        [cellview addSubview:cellback];
        cell.backgroundView=cellview;
        //cell.detailTextLabel.text=@"            %@";
        cell.detailTextLabel.text=[blank stringByAppendingFormat:@"%@",[listData objectAtIndex:(2*row+1)]];
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:15];
    
    cell.textLabel.text = [blank stringByAppendingString:[listData objectAtIndex:(2*row)]];
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
    NSUInteger row = [indexPath row];
   // if (row == 0)
     //   return nil;
	
    return indexPath;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
   // songplaying=row;
	//[self updateSong];
  //  musictable.hidden=((int)(1+musictable.hidden))%2;
    VoiceMailStar* voicestar=[[VoiceMailStar alloc] init];
    [voicestar getstarid:(int)(row+1)];
    voicestar.starname=[listData objectAtIndex:(2*row)];
    [self presentModalViewController:voicestar animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
@end
