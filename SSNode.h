//
//  SSNode.h
//  Juju
//
//  Created by Saravudh Sinsomros on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSINode.h"

@interface SSNode : SSINode {
	NSMutableArray *childs;
	NSMutableArray *attributes;
}

-(void) appendTextContent:(NSString*) aContent;
-(void) addAttribute:(NSDictionary*) aAttribute;
//Creates and returns an empty SSNode
+(id) node;
@end
