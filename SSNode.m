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
-(NSString*) attributeStringEncloseWithQuote;
-(NSString*) attributeStringEncloseWithDoubleQuote;
@end

@implementation SSNode

+(id) node {
	return [SSNode new];
}

-(id) init {
    self = [super init];
	if (self) {
		childs = [NSMutableArray new];
		attributes = [NSMutableArray new];
	}
	return self;
}

-(void) appendTextContent:(NSString*) aContent {
	if (aContent && [aContent length] > 0) {
		SSTextNode *newNode = [SSTextNode new];
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
	return [self description:ENCLOSE_TYPE_NO_ENCLOSE];
}

-(NSString*) description:(ENCLOSE_TYPE) encloseType {
	NSMutableString *descriptionString = [NSMutableString new];
	NSString *attributeStr;
    if (encloseType == ENCLOSE_TYPE_NO_ENCLOSE) {
        attributeStr = [self attributeString];
    } else if (encloseType == ENCLOSE_TYPE_WITH_QUOTE) {
        attributeStr = [self attributeStringEncloseWithQuote];
    } else {
        attributeStr = [self attributeStringEncloseWithDoubleQuote];
    }
	if ([self hasChildNodes]) {
		[descriptionString appendFormat:@"<%@%@>",self.name,attributeStr];
		for (SSNode *child in childs) {
			[descriptionString appendString:[child description:encloseType]];
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
	return attributes;
}
-(BOOL) hasAttributes {
	return [attributes count] > 0;
}

-(NSArray*) allChildsWith:(NSString*) aNodeName {
	NSMutableArray *result = [NSMutableArray array];
	for (SSINode *c in [self childNodes]) {
		NSString *cName = [[c name] lowercaseString];
		if ([cName isEqualToString:aNodeName]) {
			[result addObject:c];
		}
	}
	return result;
}

#pragma mark Private
-(NSString*) attributeStringEncloseWithQuote {
	NSMutableString *result = [NSMutableString new];
	for (NSDictionary *attr in attributes) {
        NSString *attrValue = [attr objectForKey:@"attributeContent"];
        NSMutableString *attrValueTmp = [NSMutableString stringWithString:attrValue];
        [attrValueTmp replaceOccurrencesOfString:@"'" withString:@"&#39;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [attrValueTmp length])];
		[result appendFormat:@" %@='%@'",[attr objectForKey:@"attributeName"],attrValueTmp];
	}
	return result;
}

-(NSString*) attributeStringEncloseWithDoubleQuote {
	NSMutableString *result = [NSMutableString new];
	for (NSDictionary *attr in attributes) {
        NSString *attrValue = [attr objectForKey:@"attributeContent"];
        NSMutableString *attrValueTmp = [NSMutableString stringWithString:attrValue];
        [attrValueTmp replaceOccurrencesOfString:@"\"" withString:@"&#34;" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [attrValueTmp length])];
		[result appendFormat:@" %@=\"%@\"",[attr objectForKey:@"attributeName"],attrValueTmp];
	}
	return result;
}
-(NSString*) attributeString {
	NSMutableString *result = [NSMutableString new];
	for (NSDictionary *attr in attributes) {
		[result appendFormat:@" %@=%@",[attr objectForKey:@"attributeName"],[attr objectForKey:@"attributeContent"]];
	}
	return result;
}

@end
