//
//  SSNode.h
//  Juju
//
//  Created by Saravudh Sinsomros on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSINode.h"

typedef enum {
	ENCLOSE_TYPE_NO_ENCLOSE = 0,
	ENCLOSE_TYPE_WITH_QUOTE,
	ENCLOSE_TYPE_WITH_DOUBLE_QUOTE
} ENCLOSE_TYPE;

@interface SSNode : SSINode {
	NSMutableArray *childs;
	NSMutableArray *attributes;
}

-(void) appendTextContent:(NSString*) aContent;
-(void) addAttribute:(NSDictionary*) aAttribute;
-(NSString*) description:(ENCLOSE_TYPE) encloseType;
-(NSArray*) allChildsWith:(NSString*) aNodeName;

//Creates and returns an empty SSNode
+(id) node;
@end
