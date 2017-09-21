//
//  FreeBSD_CommunityViewController.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 26/04/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"
#import "Reachability.h"

@implementation FreeBSD_CommunityViewController

@synthesize scrollView;

- (void) doUpdateNewsflash:(FreeBSDCommunity_RefreshFlag *)flag
{
	refreshObject.loadingNewsflashData = YES;
	[refreshObject.progressViewNewsflash startAnimating];
	NSLog(@">1");
	[newsflashData loadDataFromSource:flag.forced];
	NSLog(@"<1");
	[newsflashData parseData];
	[refreshObject.progressViewNewsflash stopAnimating];
	refreshObject.loadingNewsflashData = NO;
	if (refreshObject.failedNewsflashData == YES)
		[self updateFailures];
}

- (void) doUpdateUpcomingEvents:(FreeBSDCommunity_RefreshFlag *)flag
{
	refreshObject.loadingUpcomingEventsData = YES;
	[refreshObject.progressViewUpcomingEvents startAnimating];
	NSLog(@">2");
	[upcomingEventsData loadDataFromSource:flag.forced];
	NSLog(@"<2");
	[upcomingEventsData parseData];
	[refreshObject.progressViewUpcomingEvents stopAnimating];
	refreshObject.loadingUpcomingEventsData = NO;
	if (refreshObject.failedUpcomingeventsData == YES)
		[self updateFailures];
}

- (void) doUpdateYoutubeVideos:(FreeBSDCommunity_RefreshFlag *)flag
{
	refreshObject.loadingYoutubeData = YES;
	[refreshObject.progressViewYoutubeVideos startAnimating];
	NSLog(@">3");
	[youtubeData loadDataFromSource:flag.forced];
	NSLog(@"<3");
	[youtubeData parseData];
	[refreshObject.progressViewYoutubeVideos stopAnimating];
	refreshObject.loadingYoutubeData = NO;
	if (refreshObject.failedYoutubeData == YES)
		[self updateFailures];
}

- (void) doUpdatePlanetFreeBSD:(FreeBSDCommunity_RefreshFlag *)flag
{
	refreshObject.loadingPlanetFreeBSDData = YES;
	[refreshObject.progressViewPlanetFreeBSD startAnimating];
	NSLog(@">4");
	[planetFreeBSDData loadDataFromSource:flag.forced];
	NSLog(@"<4");
	[planetFreeBSDData parseData];
	[refreshObject.progressViewPlanetFreeBSD stopAnimating];
	refreshObject.loadingPlanetFreeBSDData = NO;
	if (refreshObject.failedPlanetFreeBSDData == YES)
		[self updateFailures];
}

- (void) doUpdateCommittersMap:(FreeBSDCommunity_RefreshFlag *)flag
{
	refreshObject.loadingMapData = YES;
	[refreshObject.progressViewCommittersMap startAnimating];
	NSLog(@">5");
	[mapData loadDataFromSource:flag.forced];
	NSLog(@"<5");
	[mapData parseData];
	[refreshObject.progressViewCommittersMap stopAnimating];
	refreshObject.loadingMapData = NO;
	if (refreshObject.failedMapData == YES)
		[self updateFailures];
}

- (void) callUpdater
{	
	if ([refreshObject anythingBeingLoaded] == YES)
		return;

	[refreshObject startAnimations];
	
	if ([internetReach currentReachabilityStatus] == NotReachable) {
		UIAlertView *errorView = [[UIAlertView alloc]
					 initWithTitle: @"Network error"
					 message: @"This application has detected that there is no Internet access at this moment."
					 delegate: self
					 cancelButtonTitle: @"Ok" otherButtonTitles: nil];
		[errorView show];
		[refreshObject stopAnimations];
		return;
	}

	FreeBSDCommunity_RefreshFlag *flag = [[FreeBSDCommunity_RefreshFlag alloc] init];
	flag.forced = refreshObject.forced;
	[refreshObject labelUpdating];
	[NSThread detachNewThreadSelector:@selector(doUpdateNewsflash:) toTarget:self withObject:flag];
	[NSThread detachNewThreadSelector:@selector(doUpdateUpcomingEvents:) toTarget:self withObject:flag];
	[NSThread detachNewThreadSelector:@selector(doUpdatePlanetFreeBSD:) toTarget:self withObject:flag];
	[NSThread detachNewThreadSelector:@selector(doUpdateYoutubeVideos:) toTarget:self withObject:flag];
	[NSThread detachNewThreadSelector:@selector(doUpdateCommittersMap:) toTarget:self withObject:flag];
	refreshObject.forced = NO;
}

- (void) doUpdate:(id)sender
{
	refreshObject.forced = YES;
	[self callUpdater];
}

- (void) updateFailures
{
	if (refreshObject.failedNewsflashData == YES)
		refreshObject.labelNewsflash.text = @"Update failed";
	if (refreshObject.failedUpcomingeventsData == YES)
		refreshObject.labelUpcomingEvents.text = @"Update failed";
	if (refreshObject.failedPlanetFreeBSDData == YES)
		refreshObject.labelPlanetFreeBSD.text = @"Update failed";
	if (refreshObject.failedYoutubeData == YES)
		refreshObject.labelYoutubeVideos.text = @"Update failed";
	if (refreshObject.failedMapData == YES)
		refreshObject.labelCommittersMap.text = @"Update failed";
}


- (void) doPlanetFreeBSD:(id)sender
{
	self.title = @"⌫";
	PlanetFreeBSDViewController *pfvc = [[PlanetFreeBSDViewController alloc] init];
	pfvc.title = @"Planet FreeBSD";
	pfvc.data = planetFreeBSDData;
	[self.navigationController pushViewController:pfvc animated:YES];
}

- (void) doCommittersMap:(id)sender
{
	self.title = @"⌫";
	MapViewController *mvc = [[MapViewController alloc] init];
	mvc.title = @"Committers Map";
	mvc.data = mapData;
	[self.navigationController pushViewController:mvc animated:YES];
    mvc = nil;
}

- (void) doNewsFlash:(id)sender
{	
	self.title = @"⌫";
	NewsflashViewController *nfvc = [[NewsflashViewController alloc] init];
	nfvc.title = @"News Flash";
	nfvc.data = newsflashData;
	[self.navigationController pushViewController:nfvc animated:YES];
    nfvc = nil;
}

- (void) doUpcomingEvents:(id)sender
{
	self.title = @"⌫";
	UpcomingeventsViewController *uevc = [[UpcomingeventsViewController alloc] init];
	uevc.title = @"Upcoming events";
	uevc.data = upcomingEventsData;
	[self.navigationController pushViewController:uevc animated:YES];
}

- (void) doYoutubeVideos:(id)sender
{
	self.title = @"⌫";
	YoutubeViewController *yvc = [[YoutubeViewController alloc] init];
	yvc.title = @"YouTube Videos";
	yvc.data = youtubeData;
	[self.navigationController pushViewController:yvc animated:YES];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[sizes orientation:toInterfaceOrientation];
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return(YES);
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[sizes reorientation];
	[self viewDidLoad];
	[self viewWillAppear:NO];
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (FreeBSD_CommunityViewController *)init
{
	self = [super init];
	newsflashData = nil;
	upcomingEventsData = nil;
	youtubeData = nil;
	planetFreeBSDData = nil;
	mapData = nil;
	return(self);
}

- (void)viewDidLoad
{
	self.navigationItem.rightBarButtonItem =
	[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
												   target:self action:@selector(doUpdate:)];
	
	sizes = [[Sizes alloc] init:self];

	scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
	[scrollView setScrollEnabled:YES];
	scrollView.backgroundColor = [UIColor whiteColor];
	scrollView.delegate = self;	
	
	contentView = [[UIView alloc] initWithFrame:CGRectZero];
	contentView.backgroundColor = [UIColor whiteColor];

	if (newsflashData == nil) {
		newsflashData = [[NewsflashData alloc] init];
		upcomingEventsData = [[UpcomingeventsData alloc] init];
		youtubeData = [[YoutubeData alloc] init];
		planetFreeBSDData = [[PlanetFreeBSDData alloc] init];
		mapData = [[MapData alloc] init];
	}
 
	UILabel *label;
	UIButton *button;
	CGFloat y = 3;
	UIActivityIndicatorView *pv;
	UILabel *l;
	CGRect frameLabel = CGRectMake(20, 32, 115, 8);
	CGRect frameProgressView = CGRectMake(60, 8, 25, 25);

	self.title = @"The FreeBSD Community";
	
	UIApplication *app = [UIApplication sharedApplication];
	UIInterfaceOrientation newOrientation = [app statusBarOrientation];
	if (newOrientation != [sizes currentOrientation]) {
		[sizes orientation:newOrientation];
		[self viewDidLoad];
	}
	
	NSMutableString *imgString = [[NSMutableString alloc] initWithFormat:@"%@/logo-full.png", dataDir()];
	UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:imgString]];
	UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
	
	if (image.size.width > [sizes screenWidth]) {
		imgView.frame = CGRectMake(0, 0, [sizes screenWidth], image.size.height * ([sizes screenWidth] / image.size.width));
	} else {
		imgView.frame = CGRectMake([sizes screenWidthMiddle] - image.size.width / 2, 0, image.size.width, image.size.height);
	}
	[contentView addSubview:imgView];
	y += imgView.frame.size.height; 

	/* News Flash */
	button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self action:@selector(doNewsFlash:) forControlEvents:UIControlEventTouchDown];
	[button setTitle:@"News Flash" forState:UIControlStateNormal];
	button.frame = CGRectMake([sizes screenWidthMiddle] - 155, y, 155, 42);

   	l = [[UILabel alloc] initWithFrame:frameLabel];
	l.text = [newsflashData getLastUpdate];
	l.textAlignment = NSTextAlignmentCenter;
	l.font = [UIFont systemFontOfSize:8.0f];
	l.backgroundColor = [UIColor clearColor];
	[button addSubview:l];
	refreshObject.labelNewsflash = l;

	pv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	pv.frame = frameProgressView;
	pv.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	[button addSubview:pv];
	[pv stopAnimating];
	refreshObject.progressViewNewsflash = pv;
	
	[contentView addSubview:button];
	// y += 42;

	/* Committers map */
	button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self action:@selector(doCommittersMap:) forControlEvents:UIControlEventTouchDown];
	[button setTitle:@"Committers Map" forState:UIControlStateNormal];
	button.frame = CGRectMake([sizes screenWidthMiddle], y, 155, 42);

	l = [[UILabel alloc] initWithFrame:frameLabel];
	l.text = [mapData getLastUpdate];
	l.textAlignment = NSTextAlignmentCenter;
	l.font = [UIFont systemFontOfSize:8.0f];
	l.backgroundColor = [UIColor clearColor];
	[button addSubview:l];
	refreshObject.labelCommittersMap = l;
	
	pv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	pv.frame = frameProgressView;
	pv.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	[button addSubview:pv];	
	[pv stopAnimating];
	refreshObject.progressViewCommittersMap = pv;
	
	[contentView addSubview:button];
	y += 42;
	
	/* Upcoming events */
	button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self action:@selector(doUpcomingEvents:) forControlEvents:UIControlEventTouchDown];
	[button setTitle:@"Upcoming events" forState:UIControlStateNormal];
	button.frame = CGRectMake([sizes screenWidthMiddle] - 155, y, 155, 42);

	l = [[UILabel alloc] initWithFrame:frameLabel];
	l.text = [upcomingEventsData getLastUpdate];
	l.textAlignment = NSTextAlignmentCenter;
	l.font = [UIFont systemFontOfSize:8.0f];
	l.backgroundColor = [UIColor clearColor];
	[button addSubview:l];
	refreshObject.labelUpcomingEvents = l;

	pv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	pv.frame = frameProgressView;
	pv.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	[button addSubview:pv];	
	[pv stopAnimating];
	refreshObject.progressViewUpcomingEvents = pv;
	
	[contentView addSubview:button];
	// y += 42;
	
	/* Videos */
	button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self action:@selector(doYoutubeVideos:) forControlEvents:UIControlEventTouchDown];
	[button setTitle:@"YouTube videos" forState:UIControlStateNormal];
	button.frame = CGRectMake([sizes screenWidthMiddle], y, 155, 42);

	l = [[UILabel alloc] initWithFrame:frameLabel];
	l.text = [youtubeData getLastUpdate];
	l.textAlignment = NSTextAlignmentCenter;
	l.font = [UIFont systemFontOfSize:8.0f];
	l.backgroundColor = [UIColor clearColor];
	[button addSubview:l];
	refreshObject.labelYoutubeVideos = l;
	
	pv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	pv.frame = frameProgressView;
	pv.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	[button addSubview:pv];	
	[pv stopAnimating];
	refreshObject.progressViewYoutubeVideos = pv;

	[contentView addSubview:button];
	y += 42;
	
	/* Planet FreeBSD */
	button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button addTarget:self action:@selector(doPlanetFreeBSD:) forControlEvents:UIControlEventTouchDown];
	[button setTitle:@"Planet FreeBSD" forState:UIControlStateNormal];
	button.frame = CGRectMake([sizes screenWidthMiddle] - 155, y, 155, 42);

	l = [[UILabel alloc] initWithFrame:frameLabel];
	l.text = [planetFreeBSDData getLastUpdate];
	l.textAlignment = NSTextAlignmentCenter;
	l.font = [UIFont systemFontOfSize:8.0f];
	l.backgroundColor = [UIColor clearColor];
	[button addSubview:l];
	refreshObject.labelPlanetFreeBSD = l;
	
	pv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	pv.frame = frameProgressView;
	pv.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
	[button addSubview:pv];	
	[pv stopAnimating];
	refreshObject.progressViewPlanetFreeBSD = pv;
		
	[contentView addSubview:button];
	// y += 42;
	y += 42;	
	
	/* Trademarks and disclaimer */
	y += 5;
	label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, 0, 0)];
	label.text = @
	"The mark FreeBSD is a registered trademark of The FreeBSD Foundation "
	"and is used by Edwin Groothuis with the permission of The FreeBSD Foundation.\n\n"
	"The FreeBSD Logo is a trademark of The FreeBSD Foundation and is used "
	"by Edwin Groothuis with the permission of The FreeBSD Foundation.\n\n"
	"Disclaimer: Despite the name of the app ('The FreeBSD Community'), this app is not an "
	"official communication medium of the FreeBSD Project.\n\n"
	"THIS SOFTWARE IS PROVIDED BY Edwin Groothuis ''AS IS'' AND ANY "
	"EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED "
	"WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE "
	"DISCLAIMED. IN NO EVENT SHALL Edwin Groothuis BE LIABLE FOR ANY "
	"DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES "
	"(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; "
	"LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND "
	"ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT "
	"(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS "
	"SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.";
	label.backgroundColor = [UIColor whiteColor];
	label.font = [UIFont systemFontOfSize:8.0f];
	label.numberOfLines = 0;
	ADJUSTLABEL(label, y);
	if (y < [sizes screenHeight]) {
		label.frame = CGRectMake(0, [sizes screenHeight] - label.frame.size.height, label.frame.size.width, label.frame.size.height);
	}
	[contentView addSubview:label];
	y += 5;

	contentView.frame = CGRectMake(0, 0, [sizes screenWidth], y);
	scrollView.contentSize = contentView.frame.size;
	[scrollView addSubview:contentView];
	self.view = scrollView;

	refreshObject.forced = NO;
	[self callUpdater];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.title = @"The FreeBSD Community";

    refreshObject.labelPlanetFreeBSD.text = [planetFreeBSDData getLastUpdate];
    refreshObject.labelNewsflash.text = [newsflashData getLastUpdate];
    refreshObject.labelCommittersMap.text = [mapData getLastUpdate];
    refreshObject.labelUpcomingEvents.text = [upcomingEventsData getLastUpdate];
	refreshObject.labelYoutubeVideos.text = [youtubeData getLastUpdate];
}

@end
