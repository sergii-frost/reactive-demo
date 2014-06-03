//
//  FDViewController.m
//  ReactiveDemo
//
//  Created by Sergii Nezdolii on 2014-05-31.
//  Copyright (c) 2014 FrostDigital. All rights reserved.
//

#import "FDViewController.h"
#import <ReactiveCocoa.h>

@interface FDViewController ()
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UILabel *redLabel;
@property (weak, nonatomic) IBOutlet UILabel *greenLabel;
@property (weak, nonatomic) IBOutlet UILabel *blueLabel;
@property (weak, nonatomic) IBOutlet UIView *minecraftHolder;

@end

@implementation FDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    // Reactive Cocoa Demo
    //
    
    //
    // Step 1: Simple RAC Signal
    //
    RACSignal *redSignal = [_redSlider rac_signalForControlEvents:UIControlEventValueChanged];
    
    redSignal = [[redSignal map:^id(UISlider *slider) {
            return @((int) (slider.value + 0.5));
        }] distinctUntilChanged];
    
    [redSignal doNext:^(NSNumber *x) {
        CGFloat colorDensity = 1 - x.integerValue/255.0f;
        [_redLabel setTextColor:[UIColor colorWithRed:1.0f green:colorDensity blue:colorDensity alpha:1.0f]];
        _redLabel.text = x.stringValue;
    }];
    
    

    RACSignal *greenSignal = [_greenSlider rac_signalForControlEvents:UIControlEventValueChanged];
    
    greenSignal = [[greenSignal map:^id(UISlider *slider) {
           return @((int) (slider.value + 0.5));
        }] distinctUntilChanged];
    [greenSignal subscribeNext:^(NSNumber *x) {
         CGFloat colorDensity = 1 - x.integerValue/255.0f;
         [_greenLabel setTextColor:[UIColor colorWithRed:colorDensity green:1.0f blue:colorDensity alpha:1.0f]];
         _greenLabel.text = x.stringValue;
    }];
    
    
    RACSignal *blueSignal = [_blueSlider rac_signalForControlEvents:UIControlEventValueChanged];
    
    blueSignal = [[blueSignal map:^id(UISlider *slider) {
           return @((int) (slider.value + 0.5));
       }] distinctUntilChanged];
    [blueSignal subscribeNext:^(NSNumber *x) {
         CGFloat colorDensity = 1 - x.integerValue/255.0f;
         [_blueLabel setTextColor:[UIColor colorWithRed:colorDensity green:colorDensity blue:1.0f alpha:1.0f]];
         _blueLabel.text = x.stringValue;
    }];

    
    //
    // Step 2 - Combine all signals into one
    //
    
    RACSignal *allColorsSignal = [RACSignal
        combineLatest:@[redSignal, greenSignal, blueSignal]
        reduce:^id(UISlider *red, UISlider *green, NSNumber *blue){
            return @{@"red":red, @"green":green, @"blue":blue};
        }];
 
    [allColorsSignal subscribeNext:^(NSDictionary *rgb) {
        CGFloat red = ((NSNumber *)rgb[@"red"]).integerValue/255.0f;
        CGFloat green = ((NSNumber *)rgb[@"green"]).integerValue/255.0f;
        CGFloat blue = ((NSNumber *)rgb[@"blue"]).integerValue/255.0f;
        _minecraftHolder.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    }];
}

- (void) viewWillAppear:(BOOL)animated {
    _redSlider.value = 255;
    _greenSlider.value = 255;
    _blueSlider.value = 255;
    
    [_redSlider sendActionsForControlEvents:UIControlEventValueChanged];
    [_greenSlider sendActionsForControlEvents:UIControlEventValueChanged];
    [_blueSlider sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
