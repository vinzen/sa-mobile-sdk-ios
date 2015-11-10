//
//  SAVASTParser.m
//  Pods
//
//  Copyright (c) 2015 SuperAwesome Ltd. All rights reserved.
//
//  Created by Gabriel Coman on 28/10/2015.
//
//

#import "SAVASTParser.h"

// defines
#define TARGET_TAG @"ClickThrough"

// private anonymous category
@interface SAVASTParser () <NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser *parser;
@property (nonatomic, strong) NSString *element;
@property (nonatomic, strong) NSMutableString *tmpClickURL;

@end

// proper implementation of the SAVAST parser object
@implementation SAVASTParser

- (void) findCorrectVASTClick:(NSString *)vastURL {
    NSURL *url = [NSURL URLWithString:vastURL];
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    _parser.delegate = self;
    _parser.shouldResolveExternalEntities = NO;
    [_parser parse];
}

#pragma mark <NSXMLParserDelegate>

- (void) parserDidStartDocument:(NSXMLParser *)parser {
    _element = @"";
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    _element = elementName;
    
    if ([_element isEqualToString:TARGET_TAG]) {
        _tmpClickURL = [[NSMutableString alloc] init];
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([_element isEqualToString:TARGET_TAG]) {
        [_tmpClickURL appendString:string];
    }
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // do nothing here
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
    if (_delegate != NULL && [_delegate respondsToSelector:@selector(didFindVASTClickURL:)]) {
        [_delegate didFindVASTClickURL:_tmpClickURL];
    }
}

@end