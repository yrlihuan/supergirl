//
//  MovieTableController.m
//  avTouch
//
//  Created by zhu on 10/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MovieTableController.h"


@implementation MovieTableController
@synthesize movieplayer;
@synthesize listdata;
@synthesize mainviewcontroller;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
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
    NSLog(@"view didload");
    listdata = [[NSArray alloc] initWithObjects:@"MovieList", @"test",@"test2", nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return YES;
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification 
{    //设置状态栏 
    [[UIApplication sharedApplication] setStatusBarHidden:NO]; 
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO]; 
    
    //移除观察者 
    [[NSNotificationCenter     defaultCenter] removeObserver:self 
                                                        name:MPMoviePlayerPlaybackDidFinishNotification 
                                                      object:nil]; 
    //播放器消失 
    [movieplayer dismissMoviePlayerViewControllerAnimated]; 
    self.tableView.hidden=YES;
    NSLog(@"jdjhd");//控制台可以看见打印的字母，该函数已执行 
} 

-(void)movieplay:(NSUInteger)movieplaying
{ 
    //[[UIApplication sharedApplication] setStatusBarHidden:YES]; 
    //[[UIApplication sharedApplication] setStatusBarOrientation:[[UIDevice currentDevice] orientation] animated:NO];
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"Movie-1" ofType:@"mp4" inDirectory:nil]; 
    //NSString *path = [[NSString alloc] initWithString:@"http://*************"]; 
    NSString  *rowValue=[listdata objectAtIndex:movieplaying];
    NSURL *movieURL = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:rowValue ofType:@"mp4"]];
   // NSURL *movieURL =[[NSURL alloc] initFileURLWithPath: [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"test.mp4"]];
    //[movieURL retain]; 
    [movieplayer.moviePlayer setControlStyle:MPMovieControlStyleFullscreen]; 
    [movieplayer.moviePlayer setFullscreen:YES];  
    
    //创建播放器，moviePlayerView是MPMoviePlayerViewController类型的全局变量 
    movieplayer = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL]; 
    
    //弹出播放器窗口 
    if (mainviewcontroller) {
        [mainviewcontroller  presentMoviePlayerViewControllerAnimated:movieplayer ];
    }
    else{
    [super  presentMoviePlayerViewControllerAnimated:movieplayer ]; 
    }
   
    
    
    [movieplayer.moviePlayer setMovieSourceType:MPMovieSourceTypeFile]; 
    [movieplayer.moviePlayer prepareToPlay]; 
    //播放 
    [movieplayer.moviePlayer play];   
    //增加一个观察者 
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(moviePlayBackDidFinish:) 
                                                 name:MPMoviePlayerPlaybackDidFinishNotification 
                                               object:nil]; 
   
    
} 

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [self.listdata count];
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"number of row in sec");
    return [self.listdata count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell for row at indexpath");
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
							 SimpleTableIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:SimpleTableIdentifier] autorelease];
    }
	
    
    NSUInteger row = [indexPath row];
    if (row>0) {
        
        UIImage *image = [UIImage imageNamed:@"music_photo.png"];
        cell.imageView.image = image;
    }
    cell.textLabel.text = [listdata objectAtIndex:row];
	cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
	
	if (row < 7)
        cell.detailTextLabel.text = @"Mr. Disney";
    else
        cell.detailTextLabel.text = @"Mr. Tolkien";
	
    return cell;
}
#pragma mark -
#pragma mark Table Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView
indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
	//NSUInteger row = [indexPath row];
    NSLog(@"indentationlevelforrowatindexpath");
    NSUInteger row =1;
    return row;
}

-(NSIndexPath *)tableView:(UITableView *)tableView
 willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"will select");
    NSUInteger row = [indexPath row];
    if (row == 0)
        return nil;
	
    return indexPath;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did select");
    NSUInteger row = [indexPath row];
   // songplaying=row;
    
   // NSString *rowValue = [listdata objectAtIndex:row];
    //if (row>0) {
        [self movieplay:row];
    //}
	
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     DetailViewController *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     //
}
*/

@end
