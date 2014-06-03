//
//  FDCar.m
//  ReactiveDemo
//
//  Created by Sergii Nezdolii on 2014-06-01.
//  Copyright (c) 2014 FrostDigital. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "FDCar.h"
#import "EXPMatchers+equal.h"

@implementation FDCar

- (instancetype)initWithDictionary:(NSDictionary *)carDict {
    if(self = [super init]) {
        _brand = carDict[kCarBrand];
        _model = carDict[kCarModel];
        _carType = (CarType) [carDict[kCarType] integerValue];
        _year = carDict[kCarYear];
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    BOOL equal = NO;
    if ([object isKindOfClass:[FDCar class]]) {
        equal = [self.brand isEqualToString:((FDCar *)object).brand];
        equal = equal && [self.model isEqualToString:((FDCar *)object).model];
        equal = equal && self.carType == ((FDCar *)object).carType;
        equal = equal && [self.year isEqualToNumber:((FDCar *)object).year];
    }
    return equal;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ : %@ \t %@ : %@ \t %@ : %@ \t %@ : %@",
            kCarBrand, self.brand,
            kCarModel, self.model,
            kCarType, [self carTypeDescription:self.carType],
            kCarYear, [self.year stringValue]
    ];
}

- (NSString *)carTypeDescription:(CarType)carType {
    NSString *type;
    switch (carType) {
        case CarTypeMicroCar:
            type = @"Microcar";
            break;
        case CarTypeSedan:
            type = @"Sedan";
            break;
        case CarTypeCrossover:
            type = @"Crossover";
            break;
        case CarTypeSport:
            type = @"Sport";
            break;
        case CarTypeConvertible:
            type = @"Convertible";
            break;
        case CarTypeBus:
            type = @"Bus";
            break;
        case CarTypeTruck:
            type = @"Truck";
            break;
        case CarTypeOther:
            type = @"Other";
            break;
        default:
            type = @"";
            break;
    }
    return type;
}

@end
