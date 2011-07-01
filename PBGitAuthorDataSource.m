//
//  PBGitAuthorDataSource.m
//  GitX
//
//  Created by Ketan Padegaonkar on 7/1/11.
//  Copyright 2011 ThoughtWorks. All rights reserved.
//

#import "PBGitAuthorDataSource.h"
#import "NSString_RegEx.h"

@implementation PBGitAuthorDataSource

@synthesize repository;
@synthesize authors;

- (id)initWithRepository:(PBGitRepository *)theRepository
{
    if (!(self = [super init]))
		return nil;

    repository = theRepository;
    [self readAuthors];
	return self;
}

-(void)dealloc {
    [super dealloc];
    [authors release];
}

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox {
    return [authors count];
}

- (NSUInteger)comboBox:(NSComboBox *)aComboBox indexOfItemWithStringValue:(NSString *)string {
    return [authors indexOfObject:string];
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index {
    return [authors objectAtIndex:index];
}

- (NSString *)comboBox:(NSComboBox *)aComboBox completedString:(NSString *)string {
    int i=0;
    for (i = 0; i < [authors count]; i++){
        NSString *author = [authors objectAtIndex:i];
        if ([author hasPrefix:string]){
            return author;
        }
    }
    return string;
}

- (void) readAuthors {
    NSString *message = [repository outputForCommand:@"shortlog -sen --all"];
    NSArray *lines = [message componentsSeparatedByString:@"\n"];
    
    authors = [[NSMutableArray alloc] initWithCapacity:[lines count]];
    
    for (NSString *line in lines) {
        NSArray *match = [line substringsMatchingRegularExpression:@"[ ]+[0-9]+\t(.*)" count:2 options:0 ranges:nil error:nil];
        NSLog(@"|%@|", [match objectAtIndex:1]);
        [authors addObject: [match objectAtIndex:1]];
    }
    
}
@end
