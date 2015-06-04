//
//  CardGameViewController.m
//  Card Matching Game
//
//  Created by Kiba on 5/14/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSegment;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) NSMutableArray *statusHistory;
@property (weak, nonatomic) IBOutlet UISlider *statusHistorySlider;

@end

@implementation CardGameViewController

-(NSMutableArray *) statusHistory
{
    if (!_statusHistory) _statusHistory = [[NSMutableArray alloc] init];
    return _statusHistory;
}

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

-(Deck *) createDeck        // Abstract Class
{
    return nil;
}

- (IBAction) touchRedealButton: (UIButton *)sender
{
    self.game = nil;
    self.statusHistory = nil;
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

- (IBAction)slideStatusSlider: (UISlider *)sender
{
    int sliderValue;
    sliderValue = roundf(self.statusHistorySlider.value);
    [self.statusHistorySlider setValue: sliderValue animated: NO];
    
    if ([self.statusHistory count])
    {
        self.statusLabel.alpha =
                                (sliderValue + 1 < [self.statusHistory count]) ? 0.6 : 1;
        self.statusLabel.text = [self.statusHistory objectAtIndex: sliderValue];
    }
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
        self.statusLabel.alpha = 1;
        
        if (![self.statusLabel.text isEqualToString: @""] &&
            ![[self.statusHistory lastObject] isEqualToString: description])
        {
            [self.statusHistory addObject: description];
            [self setStatusSliderRange];
        }
    }
}

-(void) setStatusSliderRange
{
    int maxValue = (int)[self.statusHistory count] - 1;
    self.statusHistorySlider.maximumValue = maxValue;
    [self.statusHistorySlider setValue: maxValue animated: YES];
}

-(NSString *) titleForCard: (Card *)card
{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *) backgroundImageForCard: (Card *)card
{
    return [UIImage imageNamed: card.isChosen ? @"cardFront" : @"dogeWithIt"];
}

@end