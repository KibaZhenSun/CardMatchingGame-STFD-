//
//  ViewController.m
//  Card Matching Game
//
//  Created by Kiba on 5/14/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegment;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation ViewController

-(CardMatchingGame *) game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount: [self.cardButtons count]
                                                  usingDeck: [self createDeck]];
        [self changeModeSegment: self.modeSegment];
    }
    
    return _game;
}

-(Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction) touchRedealButton: (UIButton *)sender
{
    self.game = nil;
    self.modeSegment.enabled = YES;
    [self updateUI];
    self.statusLabel.text = @"Game Restarted.";
}

- (IBAction) touchCardButton: (UIButton *)sender
{
    self.modeSegment.enabled = NO;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject: sender];
    [self.game chooseCardAtIndex: chosenButtonIndex];
    [self updateUI];
}

- (IBAction)changeModeSegment: (UISegmentedControl *)sender
{
    self.game.maxMatchingCards = (sender.selectedSegmentIndex == 0) ? 2 : 3;
    self.statusLabel.text = [NSString stringWithFormat: @"Changed to %lu-Cards Matching Mode.",
                             (unsigned long)self.game.maxMatchingCards];
    // NSLog(@"Selected: %lu", (unsigned long)self.game.maxMatchingCards);
}

-(void) updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject: cardButton];
        Card *card = [self.game cardAtIndex: cardButtonIndex];
        [cardButton setTitle: [self titleForCard: card] forState: UIControlStateNormal];
        [cardButton setBackgroundImage: [self backgroundImageForCard: card]
                              forState: UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat: @"Score: %ld", self.game.score];
    
    if (self.game)
    {
        NSString *description = @"";
        
        if ([self.game.lastChosenCards count])
        {
            NSMutableArray *cardsContents = [[NSMutableArray alloc] init];
            
            for (Card *card in self.game.lastChosenCards)
            {
                [cardsContents addObject: card.contents];
            }
            
            description = [cardsContents componentsJoinedByString: @" "];
        }
        
        if (self.game.lastScore > 0)
        {
            description = [NSString stringWithFormat:
                           @"Matched: %@ for %ld points.", description, (long)self.game.lastScore];
        }
        else
        {
            description = [NSString stringWithFormat:
                           @"Don't Match. %ld points penalty.", (long)-self.game.lastScore];
        }
        
        self.statusLabel.text = description;
    }
}

-(NSString *) titleForCard: (Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *) backgroundImageForCard: (Card *)card
{
    return [UIImage imageNamed: card.isChosen ? @"cardFront" : @"cardBack"];
}

@end