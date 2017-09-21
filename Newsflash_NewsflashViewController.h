//
//  Newsflash_NewsflashViewController.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 27/04/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@interface NewsflashViewController : UIViewController <UIScrollViewDelegate>
{
	UIView *contentView;
	UIScrollView *scrollView;
	NewsflashData *data;
	Sizes *sizes;
}

@property (nonatomic, strong) NewsflashData *data;

@end
