//
//  SSNode.m
//  Juju
//
//  Created by Saravudh Sinsomros on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SSNode.h"
#import "SSTextNode.h"
@interface SSNode(Private)
-(NSString*) attributeString;
@end

@implementation SSNode

+(id) node {
	return [[SSNode new]autorelease];
}

-(id) init {
	if (self = [super init]) {
		childs = [NSMutableArray new];
		attributes = [NSMutableArray new];
	}
	return self;
}

-(void) dealloc {
	[attributes release];
	[childs release];
	[super dealloc];
}

-(void) appendTextContent:(NSString*) aContent {
	if (aContent && [aContent length] > 0) {
		SSTextNode *newNode = [[SSTextNode new]autorelease];
		newNode.text = aContent;
		[self appendChild:newNode];
	}
}

-(void) addAttribute:(NSDictionary*) aAttribute {
	[attributes addObject:aAttribute];
}

-(NSString*) attributeByName:(NSString*) aName {
	for (NSDictionary *d in attributes) {
		if ([[d objectForKey:@"attributeName"] isEqualToString:aName]) {
			return [d objectForKey:@"attributeContent"];
		}
	}
	return nil;
}

-(NSString*) description {
	NSMutableString *descriptionString = [[NSMutableString new]autorelease];
	NSString *attributeStr = [self attributeString];
	if ([self hasChildNodes]) {
		[descriptionString appendFormat:@"<%@%@>",self.name,attributeStr];
		for (SSINode *child in childs) {
			[descriptionString appendString:[child description]];
		}
		[descriptionString appendFormat:@"</%@>",self.name];
	} else {
		[descriptionString appendFormat:@"<%@%@ />",self.name,attributeStr];
	}
	return descriptionString;
}

-(SSINode*) appendChild:(SSINode*) aNode {
	if (aNode) {
		aNode.parent = self;
		SSINode *lastChild = nil;
		if ([self hasChildNodes]) {
			lastChild = [childs lastObject];
		}
		lastChild.right = aNode;
		aNode.left = lastChild;
		[childs addObject:aNode];		
	}
	return aNode;
}

-(NSArray*) childNodes {
	return childs;
}

-(SSINode*) firstChild {
	if ([self hasChildNodes]) {
		return [childs objectAtIndex:0];
	}
	return nil;
}

-(SSINode*) lastChild {
	if ([self hasChildNodes]) {
		return [childs objectAtIndex:[childs count]-1];
	}
	return nil;
}

-(BOOL) hasChildNodes {
	return [childs count] > 0;
}

-(SSINode*) removeChild:(SSNode*) aNode {
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
#pragma mark Private
-(NSString*) attributeString {
	NSMutableString *result = [[NSMutableString new]autorelease];
	for (NSDictionary *attr in attributes) {
		[result appendFormat:@" %@=%@",[attr objectForKey:@"attributeName"],[attr objectForKey:@"attributeContent"]];
	}
	return result;
}
@end
