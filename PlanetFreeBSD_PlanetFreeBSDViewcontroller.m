//
//  PlanetFreeBSD_PlanetFreeBSD.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 30/04/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"


@implementation PlanetFreeBSDViewController

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

- (void) doViewLink:(id)sender
{
	PlanetFreeBSDWebViewController *pfwvc = [[PlanetFreeBSDWebViewController alloc] init];;
	self.title = @"⌫";

	NSEnumerator *itemEnum = [[data items] objectEnumerator];
	PFBObject *item;
	while ((item = [itemEnum nextObject])) {
		if (sender == item.button) {
			NSLog(@"Planet FreeBSD link: %@", item.link);
			pfwvc.title = item.title;
			pfwvc.url = item.link;
			break;
		}
	}								   
	
	[self.navigationController pushViewController:pfwvc animated:YES];
	[self viewWillAppear:FALSE];
}

- (void) viewDidLoad
{
	sizes = [[Sizes alloc] init:self];

	scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
	[scrollView setScrollEnabled:YES];
	scrollView.backgroundColor = [UIColor blackColor];
	scrollView.delegate = self;
	
	contentView = nil;
	
	scrollView.contentSize = CGSizeZero;
	self.view = scrollView;		
}

- (void) viewWillAppear:(BOOL)animated
{
	self.title = @"Planet FreeBSD";
	[super viewWillAppear:animated];
	UILabel *label;
	CGFloat y = 3;
    
	UIApplication *app = [UIApplication sharedApplication];
	UIInterfaceOrientation newOrientation = [app statusBarOrientation];
	if (newOrientation != [sizes currentOrientation]) {
		[sizes orientation:newOrientation];
		[self viewDidLoad];
	}
		
	if (contentView != nil) {
		for (UIView *view in [contentView subviews]) {
			[view removeFromSuperview];
		}
	}

	contentView = [[UIView alloc] initWithFrame:CGRectZero];
	contentView.backgroundColor = [UIColor blackColor];
	[scrollView addSubview:contentView];
	
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
	
	NSEnumerator *itemEnum = [[data items] objectEnumerator];
	PFBObject *item;
	NSInteger i = 0;
	while ((item = [itemEnum nextObject])) {
		i++;
		UIView *thisView = [[UIView alloc] initWithFrame:CGRectMake(0, y, 0, 0)];
		thisView.backgroundColor = backgroundGrey(i);
		thisView.layer.cornerRadius = 12;

		NSInteger thisY = 0;
		
		// Title
		label = [[UILabel alloc] initWithFrame:CGRectMake(10, thisY, 0, 0)];
		label.text = item.title;
		label.backgroundColor = [UIColor clearColor];
		label.numberOfLines = 0;
		ADJUSTLABEL(label, thisY);
		[thisView addSubview:label];
		thisY += 5;
		
		// Name
		label = [[UILabel alloc] initWithFrame:CGRectMake(10, thisY, 0, 0)];
		NSString *name = [[NSString alloc] initWithFormat:@"by %@", item.name];
		label.text = name;
		label.backgroundColor = [UIColor clearColor];
		label.numberOfLines = 0;
		label.font = [UIFont systemFontOfSize:14];
		ADJUSTLABEL(label, thisY);
		[thisView addSubview:label];
		thisY += 5;		
		
		// Description
		NSString *desc = item.description;
		if ([desc compare:@""] != NSOrderedSame) {
			label = [[UILabel alloc] initWithFrame:CGRectMake(10, thisY, 0, 0)];
			NSString *s = [item.description stringByReplacingOccurrencesOfRegex:@"<[^\\>]*>" withString:@" "];
			s = [s stringByReplacingOccurrencesOfRegex:@"\\s+" withString:@" "];
			label.text = s;
			label.backgroundColor = [UIColor clearColor];
			label.font = [UIFont systemFontOfSize:12];
			label.numberOfLines = 0;
			ADJUSTLABEL(label, thisY);
			[thisView addSubview:label];
		}

		// Button
		UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[button addTarget:self action:@selector(doViewLink:) forControlEvents:UIControlEventTouchDown];
		[button setTitle:@"Goto website" forState:UIControlStateNormal];
		button.frame = CGRectMake(5, thisY, 150, 22);
		//button.frame = CGRectMake(5, 0, 150, thisY + 22);
		button.backgroundColor = [UIColor clearColor];
		[item setButton:button];
		[thisView addSubview:button];
		thisY += 22;
		
		thisView.frame = CGRectMake(0, y, [sizes screenWidth], thisY);
		[contentView addSubview:thisView];
		y += thisY + 2;
	}
	
	contentView.frame = CGRectMake(0, 0, [sizes screenWidth], y);
	[scrollView addSubview:contentView];
	scrollView.contentSize = CGSizeMake([sizes screenWidth], y);	
	scrollView.frame = CGRectMake(0, 0, [sizes screenWidth], y);
}

- (void)viewWillDisappear:(BOOL)animated
{
    contentView = nil;
	scrollView = nil;
	sizes = nil;
    [super viewDidDisappear:animated];
}




@end
