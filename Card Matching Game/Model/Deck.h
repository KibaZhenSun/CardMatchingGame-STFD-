//
//  Deck.h
//  Card Matching Game
//
//  Created by Kiba on 5/15/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface Deck : NSObject

-(void) addCard: (Card *)card atTop: (BOOL)atTop;
-(void) addCard: (Card *)card;

-(Card *) drawRandomCard;

@end