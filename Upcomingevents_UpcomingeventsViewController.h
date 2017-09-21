//
//  Upcomingevents_UpcomingeventsViewController.h
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 28/04/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@interface UpcomingeventsViewController : UIViewController <UIScrollViewDelegate> {
	UIView *contentView;
	UIScrollView *scrollView;
	UpcomingeventsData *data;
	Sizes *sizes;
}

@property (nonatomic, strong) UpcomingeventsData *data;
	
@end

