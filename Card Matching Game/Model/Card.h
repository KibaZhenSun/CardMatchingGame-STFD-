//
//  Card.h
//  Card Matching Game
//
//  Created by Kiba on 5/15/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isMatched) BOOL matched;
@property (nonatomic, getter = isChosen) BOOL chosen;

@property (nonatomic) NSUInteger numberOfMatchingCards;

-(int) match: (NSArray *)otherCards;

@end