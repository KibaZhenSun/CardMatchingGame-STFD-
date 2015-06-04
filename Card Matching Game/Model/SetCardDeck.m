//
//  SetCardDeck.m
//  Card Matching Game
//
//  Created by Kiba on 6/2/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardDeck()

@end

@implementation SetCardDeck

-(instancetype) init
{
    self = [super init];
    
    if (self)
    {
        for (NSString *color in [SetCard validColors])
        {
            for (NSString *symbol in [SetCard validSymbols])
            {
                for (NSString *shading in [SetCard validShadings])
                {
                    for (NSUInteger number = 1; number <= [SetCard maxNumber]; number ++)
                    {
                        SetCard *card = [[SetCard alloc] init];
                        card.color = color;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.number = number;
                        
                        [self addCard: card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end