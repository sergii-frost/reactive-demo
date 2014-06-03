//
//  FDCar.h
//  ReactiveDemo
//
//  Created by Sergii Nezdolii on 2014-06-01.
//  Copyright (c) 2014 FrostDigital. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCarBrand   @"carBrand"
#define kCarModel   @"carModel"
#define kCarType    @"carType"
#define kCarYear    @"carYear"

typedef enum CarType : NSInteger {
    CarTypeMicroCar = 0,
    CarTypeHatchback = 1,
    CarTypeSedan = 2,
    CarTypeCrossover = 3,
    CarTypeSport = 4,
    CarTypeConvertible = 5,
    CarTypeBus = 6,
    CarTypeTruck = 7,
    CarTypeOther = 8
} CarType;

@interface FDCar : NSObject

@property (readonly, nonatomic) NSString *model;
@property (readonly, nonatomic) NSString *brand;
@property (readonly, nonatomic) CarType carType;
@property (readonly, nonatomic) NSNumber *year;


- (instancetype)initWithDictionary:(NSDictionary *)carDict;

@end
