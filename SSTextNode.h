//
//  SSTextNode.h
//  Juju
//
//  Created by Saravudh Sinsomros on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSNode.h"

@interface SSTextNode : SSNode {
	NSString *text;
}

@property (nonatomic,retain) NSString *text;

@end
