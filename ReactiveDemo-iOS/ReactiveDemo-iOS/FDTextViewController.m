//
//  FDTextViewController.m
//  ReactiveDemo-iOS
//
//  Created by Sergii Nezdolii on 2014-06-04.
//  Copyright (c) 2014 FrostDigital. All rights reserved.
//

#import "FDTextViewController.h"
#import <ReactiveCocoa.h>

@implementation FDTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Combine both signals for 2 text fields
    RACSignal *combined = [RACSignal
        combineLatest:@[_text1.rac_textSignal, _text2.rac_textSignal]
        reduce:^id(NSString *text1, NSString *text2){
            return [text1 stringByAppendingString:text2];
        }];
    
    //Listen to combined signal and setup "enabled" property of button
    RAC(_magicButton, enabled) = [combined map:^id(NSString *value) {
        return @([value isEqualToString:@"minecraft"]);
    }];
}

@end
