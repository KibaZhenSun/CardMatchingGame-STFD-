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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;

@end

@implementation ViewController

- (void)setFlipCount: (int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat: @"Flips: %d", self.flipCount];
    NSLog(@"Flips Changed to: [%d]", self.flipCount);
}

-(Deck *) deck
{
    if (!_deck)
    {
        _deck = [self createDeck];
    }
    return _deck;
}

-(Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    if ([sender.currentTitle length])
    {
        [sender setBackgroundImage: [UIImage imageNamed: @"cardBack"]
                          forState: UIControlStateNormal];
        [sender setTitle: @"" forState: UIControlStateNormal];
        self.flipCount++;
    }
    else
    {
        Card *card = [self.deck drawRandomCard];
        if (card)
        {
            [sender setBackgroundImage: [UIImage imageNamed: @"cardFront"]
                              forState: UIControlStateNormal];
            [sender setTitle: card.contents forState: UIControlStateNormal];
            self.flipCount++;
        }
    }
}

@end