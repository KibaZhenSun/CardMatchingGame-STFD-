//
//  PlayingCard.h
//  Card Matching Game
//
//  Created by Kiba on 5/15/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *) validSuits;
+(NSArray *) rankStrings;
+(NSUInteger) maxRank;

@end