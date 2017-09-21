//
//  PlanetFreeBSD_PlanetFreeBSDWebViewController.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 2/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@implementation PlanetFreeBSDWebViewController

@synthesize url;

- (void)webViewDidStartLoad:(UIWebView *)thisView
{
}

- (void)webViewDidFinishLoad:(UIWebView *)thisView
{
	[thisView sizeThatFits:CGSizeZero];
	SHOWNETWORK(NO);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return(YES);
}

- (void) viewDidLoad
{
	SHOWNETWORK(YES);
	
	NSURL *URL = [[NSURL alloc] initWithString:url];
	
	webView = [[UIWebView alloc] initWithFrame:CGRectZero];
	NSURLRequest *req = [[NSURLRequest alloc] initWithURL:URL];
	[webView loadRequest:req];
	webView.delegate = self;
	[webView setScalesPageToFit:YES];
	self.view = webView;		
}

@end
