//
//  SetCardGameViewController.m
//  Card Matching Game
//
//  Created by Kiba on 6/2/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "CardMatchingGame.h"

@interface SetCardGameViewController()

@end

@implementation SetCardGameViewController

-(Deck *) createDeck
{
    return [[SetCardDeck alloc] init];
}

@end