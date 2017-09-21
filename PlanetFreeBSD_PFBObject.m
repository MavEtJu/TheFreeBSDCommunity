//
//  PlanetFreeBSD_PFBObject.m
//  FreeBSD_Community
//
//  Created by Edwin Groothuis on 4/05/10.
//  Copyright 2010 -. All rights reserved.
//

#import "FreeBSD Community.h"

@implementation PFBObject

@synthesize title, description, pubdate, link, button, name;

- (PFBObject *)init
{
	title = nil;
	description = nil;
	pubdate = nil;
	link = nil;
	button = nil;
	name = nil;
	return(self);
}

- (void)setTitle:(NSString *)_title
{
	title = [[NSString alloc] initWithString:_title];
}

- (void)setName:(NSString *)_name
{
	name = [[NSString alloc] initWithString:_name];
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
		pubdate = @"";
	if (name == nil)
		name = @"";
}

@end
