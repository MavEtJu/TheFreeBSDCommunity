//
//  FreeBSD_CommunityViewController.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 26/04/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@interface FreeBSD_CommunityViewController : UIViewController <UIScrollViewDelegate> {
	UIScrollView *scrollView;
	UIView *contentView;
	Sizes *sizes;
}

@property (nonatomic, retain) UIScrollView *scrollView;

- (void)updateFailures;

@end
