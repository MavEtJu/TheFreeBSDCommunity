//
//  Newsflash_NewsflashViewController.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 27/04/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"


@implementation NewsflashViewController

@synthesize data;

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
//	[self.parentViewController childRotated:[sizes currentOrientation]];
}

- (void) viewDidLoad
{
	sizes = [[Sizes alloc] init:self];

	scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero]; //[[UIScreen mainScreen] applicationFrame]];
	[scrollView setScrollEnabled:YES];
	scrollView.backgroundColor = [UIColor blackColor];
	scrollView.delegate = self;
	
	contentView = [[UIView alloc] initWithFrame:CGRectZero];
	contentView.backgroundColor = [UIColor blackColor];
	
	scrollView.contentSize = CGSizeZero;
	[scrollView addSubview:contentView];
	self.view = scrollView;
    
	UILabel *label;
	CGFloat y = 3;
	
	y = 0;
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
	
	NSString *lastMonth = @"";
	NSString *lastYear = @"";
	
	NSEnumerator *itemEnum = [[data items] objectEnumerator];
	NFObject *item;
	NSInteger i = 0;
	while ((item = [itemEnum nextObject])) {
		i++;
	
		NSString *thisMonth = item.pubdate;
		NSArray *words = [thisMonth arrayOfCaptureComponentsMatchedByRegex:@", \\d+ ([^ ]+) (\\d+) \\d+:"];
		if ([words count] == 1) {
			words = [words objectAtIndex:0];
			if ([lastMonth compare:[words objectAtIndex:1]] != NSOrderedSame ||
				[lastYear compare:[words objectAtIndex:2]] != NSOrderedSame) {
				lastMonth = [words objectAtIndex:1];
				lastYear = [words objectAtIndex:2];
				label = [[UILabel alloc] initWithFrame:CGRectMake(3, y, 0, 0)];
				label.text = [[NSString alloc] initWithFormat:@"%@ %@", lastMonth, lastYear];
				label.backgroundColor = [UIColor blackColor];
				label.textColor = [UIColor whiteColor];
				label.numberOfLines = 0;
				ADJUSTLABEL(label, y);
				[contentView addSubview:label];
				y += 5;
			}
		}

		NSInteger thisY = 0;
		UIView *thisView = [[UIView alloc] initWithFrame:CGRectZero];
		thisView.backgroundColor = backgroundGrey(i);	
		thisView.layer.cornerRadius = 12;
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(10, thisY, 0, 0)];
		label.text = item.title;
		label.backgroundColor = [UIColor clearColor];
		label.numberOfLines = 0;
		ADJUSTLABEL(label, thisY);
		[thisView addSubview:label];
		thisY += 5;
		
		NSString *desc = item.description;
		if ([desc compare:@""] != NSOrderedSame) {
			label = [[UILabel alloc] initWithFrame:CGRectMake(10, thisY, 0, 0)];
			label.text = item.description;
			label.backgroundColor = [UIColor clearColor];
			label.font = [UIFont systemFontOfSize:12];
			label.numberOfLines = 0;
			ADJUSTLABEL(label, thisY);
			[thisView addSubview:label];
			thisY += 5;
		}
		
		thisView.frame = CGRectMake(0, y, [sizes screenWidth], thisY);
		[contentView addSubview:thisView];
		
		y += thisY + 2;		
	}
	
	contentView.frame = CGRectMake(0, 0, [sizes screenWidth], y);
	scrollView.contentSize = CGSizeMake([sizes screenWidth], y);	
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated
{
    contentView = nil;
	scrollView = nil;
	data = nil;
	sizes = nil;
    [super viewWillDisappear:animated];
}

@end

