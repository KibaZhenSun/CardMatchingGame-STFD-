//
//  Card.m
//  Card Matching Game
//
//  Created by Kiba on 5/21/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *otherCard in otherCards)
    {
        if([self.contents isEqualToString: otherCard.contents])
        {
            score = 1;
        }
    }
    
    return score;
}

@end