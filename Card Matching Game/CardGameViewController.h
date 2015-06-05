//
//  CardGameViewController.h
//  Card Matching Game
//
//  Created by Kiba on 5/14/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// Must be implemented in subclasses
-(Deck *) createDeck;        // Abstract

-(NSAttributedString *) titleForCard: (Card *)card;
-(UIImage *) backgroundImageForCard: (Card *)card;
-(void) updateUI;

@end