//
//  NSString+LoremIpsum.m
//  CSLinearLayoutView
//
//  Created by Charles Scalesse on 4/29/12.
//  Copyright (c) 2012 Charles Scalesse. All rights reserved.
//

#import "NSString+LoremIpsum.h"

@implementation NSString (LoremIpsum)

+ (NSString *)loremIpsumSentences:(NSUInteger)numberOfSentences {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"lorem" ofType:@"txt"];
    NSError *error = nil;
    NSString *loremText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    // sanity
    if (error != nil || loremText == nil || loremText.length < 1) {
        return nil;
    }
    
    NSMutableArray *sentences = [[NSMutableArray alloc] initWithArray:[loremText componentsSeparatedByString:@". "]];
    if (numberOfSentences >= [sentences count]) {
        return loremText;
    }
    
    NSString *resultingPhrase = @"";
    
    for (uint i=0; i < numberOfSentences; i++) {
        NSInteger index = arc4random() % (sentences.count - 1);
        NSString *sentence = [sentences objectAtIndex:index];
        NSString *appendingString = (i == numberOfSentences - 1) ? @"." : @". "; 
        resultingPhrase = [resultingPhrase stringByAppendingString:[NSString stringWithFormat:@"%@%@", sentence, appendingString]];
        [sentences removeObjectAtIndex:index];
    }
    
    return resultingPhrase;
}

@end
