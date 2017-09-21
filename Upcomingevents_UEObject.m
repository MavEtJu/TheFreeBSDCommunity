//
//  Upcomingevents_UEObject.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 5/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"


@implementation UEObject

@synthesize title, description, link, pubdate, button;

- (UEObject *) init
{
	title = nil;
	description = nil;
	pubdate = nil;
	link = nil;
	button = nil;
	return(self);
}

- (void)setTitle:(NSString *)_title
{
	title = [[NSString alloc] initWithString:_title];
}

- (void)setDescription:(NSString *)_description
{
	description = [[NSString alloc] initWithString:_description];
}

- (void)setPubdate:(NSString *)_pubdate
{
	pubdate = [[NSString alloc] initWithString:_pubdate];
}

- (void)setLink:(NSString *)_link
{
	link = [[NSString alloc] initWithString:_link];
}

- (void)setButton:(UIButton *)_button
{
	button = _button;
}

- (void)fillup
{
	if (title == nil)
		title = @"";
	if (link == nil)
		link= @"";
	if (description == nil)
		description = @"";
	if (pubdate == nil)
		pubdate = @"";;
}

@end
