//
//  Youtube_YoutubeViewController.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 28/04/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@interface YoutubeViewController : UIViewController <UIScrollViewDelegate> {
	UIView *contentView;
	UIScrollView *scrollView;
	YoutubeData *data;
	Sizes *sizes;
}

@property (nonatomic, strong) YoutubeData *data;

@end
