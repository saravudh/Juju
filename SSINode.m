//
//  SSINode.m
//  Juju
//
//  Created by Saravudh Sinsomros on 10/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SSINode.h"


@implementation SSINode
@synthesize name;

-(SSINode*) appendChild:(SSINode*) aNode {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

-(NSArray*) childNodes {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

-(SSINode*) firstChild {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}


-(SSINode*) lastChild {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

-(BOOL) hasChildNodes {
	[self doesNotRecognizeSelector:_cmd];
	return NO;
}


-(SSINode*) removeChild:(SSINode*) aNode {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}
-(NSArray*) attributes {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}
-(BOOL) hasAttributes {
	[self doesNotRecognizeSelector:_cmd];
	return NO;
}

@end
