//
//  Youtube_YoutubeViewController.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 28/04/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@implementation YoutubeViewController

@synthesize data;

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	[sizes orientation:toInterfaceOrientation];
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
}

- (void) doViewVideo:(id)sender
{
	YTObject *thisItem;
	
	FILE *fout;
	NSString *seenpath = [[NSString alloc] initWithFormat:@"%@/seen.data", workingDir()];
	if ((fout = fopen([seenpath cStringUsingEncoding:NSASCIIStringEncoding], "w")) != NULL) {

		NSEnumerator *itemEnum = [[data items] objectEnumerator];
		YTObject *item;
		while ((item = [itemEnum nextObject])) {
			if (sender == item.button)
				thisItem = item;
			if (item.seen == YES)
				fprintf(fout, "%s\n", [item.link cStringUsingEncoding:NSASCIIStringEncoding]);
		}
		fprintf(fout, "%s\n", [item.link cStringUsingEncoding:NSASCIIStringEncoding]);
		fclose(fout);	
	}
	NSLog(@"YouTube video: %@", thisItem.link);
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:thisItem.link]];
	// Never returns...
}

- (void) viewDidLoad
{
	sizes = [[Sizes alloc] init:self];

	scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
	[scrollView setScrollEnabled:YES];
	scrollView.backgroundColor = [UIColor blackColor];
	scrollView.delegate = self;

	contentView = [[UIView alloc] initWithFrame:CGRectZero];
	contentView.backgroundColor = [UIColor blackColor];
	
	scrollView.contentSize = CGSizeMake([sizes screenWidth], 0);
	[scrollView addSubview:contentView];
	self.view = scrollView;
}

- (void) viewWillAppear:(BOOL)animated
{
	UILabel *label;
	CGFloat y = 3;
	NSInteger c = 0;
	
	label = [[UILabel alloc] initWithFrame:CGRectMake(3, y, 0, 0)];
	label.text = [[NSString alloc] initWithFormat:@"Number of entries: %d (%d restricted)", [[data items] count] - [data restricted], [data restricted]];
	label.backgroundColor = [UIColor blackColor];
	label.textColor = [UIColor whiteColor];
	label.font = [UIFont systemFontOfSize:12];
	label.numberOfLines = 0;
	ADJUSTLABEL(label, y);
	[contentView addSubview:label];
	y += 5;
	
	/*
	label = [[[UILabel alloc] initWithFrame:CGRectMake(3, y, 0, 0)] autorelease];
	label.text = [[[NSString alloc] initWithFormat:@"Last Update: %@", [data getLastUpdate]] autorelease];
	label.backgroundColor = [UIColor whiteColor];
	label.font = [UIFont systemFontOfSize:12];
	label.numberOfLines = 0;
	ADJUSTLABEL(label, y);
	[contentView addSubview:label];
	y += 5;
	 */
	
	NSEnumerator *itemEnum = [[data items] objectEnumerator];
	YTObject *item;
	while ((item = [itemEnum nextObject])) {	
		if ([item.state compare:@""] != NSOrderedSame)
			continue;

		UIView *thisView = [[UIView alloc] initWithFrame:CGRectMake(0, y, 0, 0)];
		thisView.layer.cornerRadius = 12;
		NSInteger thisY = 0;
		
		thisView.backgroundColor = backgroundGrey(c++);

		label = [[UILabel alloc] initWithFrame:CGRectMake(10, thisY, 0, 0)];
		label.text = item.title;
		label.numberOfLines = 0;
		label.backgroundColor = [UIColor clearColor];
		ADJUSTLABEL(label, thisY);
		[thisView addSubview:label];
		thisY += 5;
		
		NSString *desc = item.description;
		if ([desc compare:@""] != NSOrderedSame) {
			label = [[UILabel alloc] initWithFrame:CGRectMake(10, thisY, 0, 0)];
			label.text = item.description;
			label.font = [UIFont systemFontOfSize:12];
			label.backgroundColor = [UIColor clearColor];
			label.numberOfLines = 0;
			ADJUSTLABEL(label, thisY);
			[thisView addSubview:label];
			thisY += 5;
		}
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[button addTarget:self action:@selector(doViewVideo:) forControlEvents:UIControlEventTouchDown];
		[button setTitle:@"YouTube Video" forState:UIControlStateNormal];
		button.frame = CGRectMake(5, thisY, 150, 22);
		button.backgroundColor = [UIColor clearColor];
		[item setButton:button];
		[thisView addSubview:button];
		// y += 22;   same line
		if (item.seen == YES) {
			label = [[UILabel alloc] initWithFrame:CGRectMake(165, thisY, 0, 0)];
			label.text = @"Already seen";
			label.font = [UIFont systemFontOfSize:12];
			label.backgroundColor = [UIColor clearColor];
			label.numberOfLines = 0;
			[thisView addSubview:label];
		}
		thisY += 22;

		thisView.frame = CGRectMake(0, y, [sizes screenWidth], thisY);
		[contentView addSubview:thisView];
		
		y += thisY + 2;
	}
	
	contentView.frame = CGRectMake(0, 0, [sizes screenWidth], y);
	scrollView.contentSize = CGSizeMake([sizes screenWidth], y);	
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    contentView = nil;
    scrollView = nil;
    sizes = nil;
}

@end
