//
//  PlayCardGameViewController.m
//  Card Matching Game
//
//  Created by Kiba on 5/30/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import "PlayCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayCardGameViewController()

@end

@implementation PlayCardGameViewController

-(Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end