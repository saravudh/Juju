//
//  XPathQuery.m
//  FuelFinder
//
//  Created by Matt Gallagher on 4/08/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//
//  Modified by Saravudh Sinsomros on 25/10/2010.

#import "XPathQuery.h"

#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>
#import "SSNode.h"

SSNode *SSNodeForNode(xmlNodePtr currentNode, SSNode *parentNode)
{
	if (currentNode->name)
    {
		NSString *currentNodeName = [NSString stringWithCString:(const char *)currentNode->name encoding:NSUTF8StringEncoding];
		SSNode *resultNode = nil;
		NSString *currentNodeContent = nil;
		if (currentNode->content && currentNode->content != (xmlChar *)-1) {
			currentNodeContent = [NSString stringWithCString:(const char *)currentNode->content encoding:NSUTF8StringEncoding];
			currentNodeContent = [currentNodeContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		}

		if ([currentNodeName isEqual:@"text"] && parentNode) {
			[parentNode appendTextContent:currentNodeContent];
			return nil;
		} else {
			resultNode = [SSNode node];
			resultNode.name = currentNodeName;
			[resultNode appendTextContent:currentNodeContent];
		}

	
	xmlAttr *attribute = currentNode->properties;
	if (attribute) {
		while (attribute) {
			NSMutableDictionary *attributeDictionary = [NSMutableDictionary dictionary];
			NSString *attributeName =
            [NSString stringWithCString:(const char *)attribute->name encoding:NSUTF8StringEncoding];
			if (attributeName) {
				[attributeDictionary setObject:attributeName forKey:@"attributeName"];
            }
			
			if (attribute->children) {

				if (attribute->children->content && attribute->children->content != (xmlChar *)-1) {
					NSString *currentNodeContent = [NSString stringWithCString:(const char *)attribute->children->content encoding:NSUTF8StringEncoding];
					currentNodeContent = [currentNodeContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
					[attributeDictionary setObject:currentNodeContent forKey:@"attributeContent"];
				}
            }
			
			if ([attributeDictionary count] > 0) {
				[resultNode addAttribute:attributeDictionary];
            }
			attribute = attribute->next;
        }
    }

		xmlNodePtr childNode = currentNode->children;
		while (childNode) {
			SSNode *childWrapperNode = SSNodeForNode(childNode,resultNode);
			if (childWrapperNode) {
				[resultNode appendChild:childWrapperNode];
			}
			childNode = childNode->next;
		}
		return resultNode;
	}
	return nil;
}

NSArray *PerformXPathQuery(xmlDocPtr doc, NSString *query) {
  xmlXPathContextPtr xpathCtx;
  xmlXPathObjectPtr xpathObj;

  /* Create xpath evaluation context */
  xpathCtx = xmlXPathNewContext(doc);
  if(xpathCtx == NULL) {
      NSLog(@"Unable to create XPath context.");
      return nil;
    }

  /* Evaluate xpath expression */
  xpathObj = xmlXPathEvalExpression((xmlChar *)[query cStringUsingEncoding:NSUTF8StringEncoding], xpathCtx);
  if(xpathObj == NULL) {
    NSLog(@"Unable to evaluate XPath.");
    return nil;
  }

  xmlNodeSetPtr nodes = xpathObj->nodesetval;
  if (!nodes) {
      NSLog(@"Nodes was nil.");
      return nil;
    }

  NSMutableArray *resultNodes = [NSMutableArray array];
  for (NSInteger i = 0; i < nodes->nodeNr; i++) {
		SSNode *node = SSNodeForNode(nodes->nodeTab[i], nil);
		if (node) {
          [resultNodes addObject:node];
        }
    }

  /* Cleanup */
  xmlXPathFreeObject(xpathObj);
  xmlXPathFreeContext(xpathCtx);

  return resultNodes;
}

NSArray *PerformHTMLXPathQuery(NSData *document, NSString *query)
{
  xmlDocPtr doc;

  /* Load XML document */
  doc = htmlReadMemory([document bytes], [document length], "", NULL, HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);

  if (doc == NULL)
    {
      NSLog(@"Unable to parse.");
      return nil;
    }

  NSArray *result = PerformXPathQuery(doc, query);
  xmlFreeDoc(doc);

  return result;
}

NSArray *PerformXMLXPathQuery(NSData *document, NSString *query)
{
  xmlDocPtr doc;

  /* Load XML document */
  doc = xmlReadMemory([document bytes], [document length], "", NULL, XML_PARSE_RECOVER);

  if (doc == NULL)
    {
      NSLog(@"Unable to parse.");
      return nil;
    }

  NSArray *result = PerformXPathQuery(doc, query);
  xmlFreeDoc(doc);

  return result;
}
