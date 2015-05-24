//
//  CardMatchingGame.h
//  Card Matching Game
//
//  Created by Kiba on 5/21/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

// Designated initializer
-(instancetype) initWithCardCount: (NSUInteger)count
                        usingDeck: (Deck *)deck;

-(void) chooseCardAtIndex: (NSUInteger)index;
-(Card *) cardAtIndex: (NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger maxMatchingCards;

@end