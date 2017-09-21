//
//  PlanetFreeBSD_PlanetFreeBSD.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 30/04/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@interface PlanetFreeBSDViewController : UIViewController <UIScrollViewDelegate, UIWebViewDelegate> {
	UIView *contentView;
	UIScrollView *scrollView;
	PlanetFreeBSDData *data;
	Sizes *sizes;
}

@property (nonatomic, strong) PlanetFreeBSDData *data;

@end
