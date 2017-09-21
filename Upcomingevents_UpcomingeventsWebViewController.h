//
//  Upcomingevents_UpcomingeventsWebViewController.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 5/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@interface UpcomingeventsWebViewController : UIViewController <UIScrollViewDelegate, UIWebViewDelegate> {
	UIWebView *webView;
	NSString *url;
}

@property (nonatomic, retain) NSString *url;

@end
