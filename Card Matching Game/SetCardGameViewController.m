//
//  SetCardGameViewController.m
//  Card Matching Game
//
//  Created by Kiba on 6/2/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "CardMatchingGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController()

@end

@implementation SetCardGameViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

-(Deck *) createDeck
{
    return [[SetCardDeck alloc] init];
}

-(UIImage *) backgroundImageForCard: (Card *)card
{
    return [UIImage imageNamed: card.isChosen ? @"setCardSelected" : @"setCard"];
}

static const int OPEN_STROKE_WIDTH = 5;
static const int FILLED_STROKE_WIDTH = -5;

-(NSAttributedString *) titleForCard: (Card *)card
{
    NSString *symbol = @"?";
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    
    if ([card isKindOfClass: [SetCard class]])
    {
        SetCard *setCard = (SetCard *)card;
        
        if ([setCard.symbol isEqualToString: @"oval"]) symbol = @"●";
        if ([setCard.symbol isEqualToString: @"squiggle"]) symbol = @"▲";
        if ([setCard.symbol isEqualToString: @"diamond"]) symbol = @"■";
        
        symbol = [symbol stringByPaddingToLength: setCard.number
                                      withString: symbol
                                 startingAtIndex: 0];
        
        if ([setCard.color isEqualToString: @"red"])
            [attributes setObject: [UIColor redColor]
                           forKey: NSForegroundColorAttributeName];
        if ([setCard.color isEqualToString: @"green"])
            [attributes setObject: [UIColor greenColor]
                           forKey: NSForegroundColorAttributeName];
        if ([setCard.color isEqualToString: @"purple"])
            [attributes setObject: [UIColor purpleColor]
                           forKey: NSForegroundColorAttributeName];
        
        if ([setCard.shading isEqualToString: @"solid"])
            [attributes setObject: @(FILLED_STROKE_WIDTH)
                           forKey: NSStrokeWidthAttributeName];
        if ([setCard.shading isEqualToString: @"open"])
            [attributes setObject: @(OPEN_STROKE_WIDTH)
                           forKey: NSStrokeWidthAttributeName];
        if ([setCard.shading isEqualToString: @"striped"])
            [attributes addEntriesFromDictionary: @{ NSStrokeWidthAttributeName: @(FILLED_STROKE_WIDTH),
                                                     NSStrokeColorAttributeName: attributes[NSForegroundColorAttributeName],
                                                     NSForegroundColorAttributeName: [attributes[NSForegroundColorAttributeName] colorWithAlphaComponent: 0.1]}];
    }
    
    return [[NSMutableAttributedString alloc] initWithString: symbol
                                                  attributes: attributes];
}


@end