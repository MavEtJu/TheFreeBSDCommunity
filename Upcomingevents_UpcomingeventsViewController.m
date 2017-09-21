//
//  Upcomingevents_UpcomingeventsViewController.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 28/04/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@implementation UpcomingeventsViewController

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
	self.title = @"⌫";
	UpcomingeventsWebViewController *uewvc = [[UpcomingeventsWebViewController alloc] init];
	
	NSEnumerator *itemEnum = [[data items] objectEnumerator];
	PFBObject *item;
	while ((item = [itemEnum nextObject])) {
		if (sender == item.button) {
			NSLog(@"Planet FreeBSD link: %@", item.title);
			uewvc.title = item.title;
			uewvc.url = item.link;
			break;
		}
	}								   
	
	[self.navigationController pushViewController:uewvc animated:YES];
	[self viewWillAppear:FALSE];
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
	
	scrollView.contentSize = CGSizeZero;
	[scrollView addSubview:contentView];
	self.view = scrollView;		

	UILabel *label;
	CGFloat y = 3;
	NSInteger i = 0;
	
	UIApplication *app = [UIApplication sharedApplication];
	UIInterfaceOrientation newOrientation = [app statusBarOrientation];
	if (newOrientation != [sizes currentOrientation]) {
		[sizes orientation:newOrientation];
		[self viewDidLoad];
	}
	
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
	UEObject *item;
	while ((item = [itemEnum nextObject])) {
		
		UIView *thisView = [[UIView alloc] initWithFrame:CGRectMake(0, y, 0, 0)];
		thisView.backgroundColor = backgroundGrey(i++);
		thisView.layer.cornerRadius = 12;
		NSInteger thisY = 0;
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(10, thisY, 0, 0)];
		label.text = item.title;
		label.backgroundColor = [UIColor clearColor];
		label.numberOfLines = 0;
		ADJUSTLABEL(label, thisY);
		[thisView addSubview:label];
		thisY += 5;
		
		if ([item.description compare:@""] != NSOrderedSame) {
			label = [[UILabel alloc] initWithFrame:CGRectMake(10, thisY, 0, 0)];
			label.text = item.description;
			label.backgroundColor = [UIColor clearColor];
			label.font = [UIFont systemFontOfSize:12];
			label.numberOfLines = 0;
			ADJUSTLABEL(label, thisY);
			[thisView addSubview:label];
			thisY += 5;
		}
		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[button addTarget:self action:@selector(doViewLink:) forControlEvents:UIControlEventTouchDown];
		[button setTitle:@"Goto website" forState:UIControlStateNormal];
		button.frame = CGRectMake(5, thisY, 150, 22);
		button.backgroundColor = [UIColor clearColor];
		[item setButton:button];
		[thisView addSubview:button];
		thisY += 22;
		
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
    
    self.title = @"Upcoming events";
}


- (void)viewWillDisappear:(BOOL)animated
{
    contentView = nil;
	scrollView = nil;
	sizes = nil;
    [super viewWillDisappear:animated];
}


@end
