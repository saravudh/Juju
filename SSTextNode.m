//
//  SSTextNode.m
//  Juju
//
//  Created by Saravudh Sinsomros on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SSTextNode.h"


@implementation SSTextNode
@synthesize text;

-(BOOL) hasChildNodes {
	return NO;
}
-(BOOL) hasAttributes {
	return NO;
}

-(NSString*) description {
	return self.text;
}

-(NSString*) name {
	return @"#text";
}


-(SSINode*) appendChild:(SSINode*) aNode {
	return nil;
}

-(NSArray*) childNodes {
	return nil;
}

-(SSINode*) firstChild {
	return nil;
}

-(SSINode*) lastChild {
	return nil;
}

-(SSINode*) removeChild:(SSINode*) aNode {
	return nil;
}
-(NSArray*) attributes {
	return nil;
}
@end
