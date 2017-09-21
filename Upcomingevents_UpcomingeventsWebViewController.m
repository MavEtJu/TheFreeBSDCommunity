//
//  Upcomingevents_UpcomingeventsWebViewController.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 5/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@implementation UpcomingeventsWebViewController

@synthesize url;

- (void)webViewDidStartLoad:(UIWebView *)thisView
{
}

- (void)webViewDidFinishLoad:(UIWebView *)thisView
{
	SHOWNETWORK(NO);
	[thisView sizeThatFits:CGSizeZero];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return(YES);
}

- (void) viewDidLoad
{
	NSURL *URL = [[NSURL alloc] initWithString:url];
	
	webView = [[UIWebView alloc] initWithFrame:CGRectZero];
	NSURLRequest *req = [[NSURLRequest alloc] initWithURL:URL];

	[webView loadRequest:req];
	
	SHOWNETWORK(YES);
	webView.delegate = self;
	[webView setScalesPageToFit:YES];
	self.view = webView;		
}

- (void)viewWillDisappear:(BOOL)animated
{
    webView = nil;
    [super viewDidDisappear:animated];
}

@end
