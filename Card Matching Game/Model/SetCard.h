//
//  SetCard.h
//  Card Matching Game
//
//  Created by Kiba on 6/2/15.
//  Copyright (c) 2015 Kiba Zhen Sun. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSString *shading;
@property (nonatomic) NSUInteger number;

+(NSArray *) validColors;
+(NSArray *) validSymbols;
+(NSArray *) validShadings;
+(NSUInteger) maxNumber;

@end