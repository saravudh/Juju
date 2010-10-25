//
//  XPathQuery+Addition.m
//  FlightSearchSystem
//
//  Created by saravudh.sinsomros on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "XPathQuery+Addition.h"

NSString *StringForNode(xmlNodePtr currentNode, NSMutableDictionary *parentResult)
{
	NSMutableDictionary *resultForNode = [NSMutableDictionary dictionary];
	
	if (currentNode->name)
    {
		NSString *currentNodeContent =
        [NSString stringWithCString:(const char *)currentNode->name encoding:NSUTF8StringEncoding];
		[resultForNode setObject:currentNodeContent forKey:@"nodeName"];
    }
	
	if (currentNode->content && currentNode->content != (xmlChar *)-1)
    {
		NSString *currentNodeContent =
        [NSString stringWithCString:(const char *)currentNode->content encoding:NSUTF8StringEncoding];
		
		if ([[resultForNode objectForKey:@"nodeName"] isEqual:@"text"] && parentResult)
        {
			[parentResult
			 setObject:
			 [currentNodeContent
			  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
			 forKey:@"nodeContent"];
			return nil;
        }
		
		[resultForNode setObject:currentNodeContent forKey:@"nodeContent"];
    }
	
	xmlAttr *attribute = currentNode->properties;
	if (attribute)
    {
		NSMutableArray *attributeArray = [NSMutableArray array];
		while (attribute)
        {
			NSMutableDictionary *attributeDictionary = [NSMutableDictionary dictionary];
			NSString *attributeName =
            [NSString stringWithCString:(const char *)attribute->name encoding:NSUTF8StringEncoding];
			if (attributeName)
            {
				[attributeDictionary setObject:attributeName forKey:@"attributeName"];
            }
			
			if (attribute->children)
            {
				NSDictionary *childDictionary = DictionaryForNode(attribute->children, attributeDictionary);
				if (childDictionary)
                {
					[attributeDictionary setObject:childDictionary forKey:@"attributeContent"];
                }
            }
			
			if ([attributeDictionary count] > 0)
            {
				[attributeArray addObject:attributeDictionary];
            }
			attribute = attribute->next;
        }
		
		if ([attributeArray count] > 0)
        {
			[resultForNode setObject:attributeArray forKey:@"nodeAttributeArray"];
        }
    }
	
	xmlNodePtr childNode = currentNode->children;
	if (childNode)
    {
		NSMutableArray *childContentArray = [NSMutableArray array];
		while (childNode)
        {
			NSDictionary *childDictionary = DictionaryForNode(childNode, resultForNode);
			if (childDictionary)
            {
				[childContentArray addObject:childDictionary];
            }
			childNode = childNode->next;
        }
		if ([childContentArray count] > 0)
        {
			[resultForNode setObject:childContentArray forKey:@"nodeChildArray"];
        }
    }
	
	return resultForNode;
}
