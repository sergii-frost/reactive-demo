//
//  ReactiveDemoTests.m
//  ReactiveDemoTests
//
//  Created by Sergii Nezdolii on 2014-05-31.
//  Copyright (c) 2014 FrostDigital. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FDCar.h"

#import <ObjectiveSugar.h>
#import <Specta.h>
#define EXP_SHORTHAND
#import <Expecta.h>

@interface ReactiveDemoTests : XCTestCase

@end

@implementation ReactiveDemoTests

- (void)testExample {
    //GIVEN
    NSArray *cars = @[
        [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Volvo", kCarModel:@"P1900", kCarYear:@1956, kCarType : @(CarTypeSport)}],
        [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Volvo", kCarModel:@"144", kCarYear:@1972, kCarType : @(CarTypeSedan)}],
        [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Volvo", kCarModel:@"V40", kCarYear:@2004, kCarType : @(CarTypeHatchback)}],
        [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Volvo", kCarModel:@"S80", kCarYear:@2006, kCarType : @(CarTypeSedan)}],
        [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Volvo", kCarModel:@"XC60", kCarYear:@2008, kCarType : @(CarTypeCrossover)}],

        [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Saab", kCarModel:@"Sonett III", kCarYear:@1974, kCarType : @(CarTypeSport)}],
        [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Saab", kCarModel:@"900", kCarYear:@1994, kCarType : @(CarTypeMicroCar)}],
        [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Saab", kCarModel:@"9-4X", kCarYear:@2011, kCarType : @(CarTypeCrossover)}],

        [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Scania", kCarModel:@"OmniLink (CL94UA/CL94UB)", kCarYear:@2006, kCarType : @(CarTypeBus)}],
        [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Scania", kCarModel:@"2-series: 142", kCarYear:@1988, kCarType : @(CarTypeTruck)}],

        [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Peugeot", kCarModel:@"206", kCarYear:@1998, kCarType : @(CarTypeMicroCar)}],
        [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Peugeot", kCarModel:@"Quark", kCarYear:@2004, kCarType : @(CarTypeOther)}],
        [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Peugeot", kCarModel:@"607", kCarYear:@1999, kCarType : @(CarTypeSedan)}]
    ];

    //WHEN
    NSArray *expected = @[@"144", @"S80"];

    //Oldschool style programming with manual sorting of collections
    NSMutableArray *volvoSedanCars = [NSMutableArray new];
    for(FDCar *car in cars) {
        if([car.brand isEqualToString:@"Volvo"]) {
            if(car.carType == CarTypeSedan) {
                [volvoSedanCars addObject:car.model];
            }
        }
    }

    //THEN
    XCTAssertEqualObjects(volvoSedanCars, expected, @"All Volvo Sedan Cars models are filtered as expected");
}

@end


SpecBegin(ObjectiveSugarDemo)
    __block NSArray *cars;

    beforeAll(^{
        cars = @[
                [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Volvo", kCarModel:@"P1900", kCarYear:@1956, kCarType : @(CarTypeSport)}],
                [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Volvo", kCarModel:@"144", kCarYear:@1972, kCarType : @(CarTypeSedan)}],
                [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Volvo", kCarModel:@"V40", kCarYear:@2004, kCarType : @(CarTypeHatchback)}],
                [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Volvo", kCarModel:@"S80", kCarYear:@2006, kCarType : @(CarTypeSedan)}],
                [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Volvo", kCarModel:@"XC60", kCarYear:@2008, kCarType : @(CarTypeCrossover)}],

                [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Saab", kCarModel:@"Sonett III", kCarYear:@1974, kCarType : @(CarTypeSport)}],
                [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Saab", kCarModel:@"900", kCarYear:@1994, kCarType : @(CarTypeMicroCar)}],
                [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Saab", kCarModel:@"9-4X", kCarYear:@2011, kCarType : @(CarTypeCrossover)}],

                [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Scania", kCarModel:@"OmniLink (CL94UA/CL94UB)", kCarYear:@2006, kCarType : @(CarTypeBus)}],
                [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Scania", kCarModel:@"2-series: 142", kCarYear:@1988, kCarType : @(CarTypeTruck)}],

                [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Peugeot", kCarModel:@"206", kCarYear:@1998, kCarType : @(CarTypeMicroCar)}],
                [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Peugeot", kCarModel:@"Quark", kCarYear:@2004, kCarType : @(CarTypeOther)}],
                [[FDCar alloc] initWithDictionary:@{kCarBrand:@"Peugeot", kCarModel:@"607", kCarYear:@1999, kCarType : @(CarTypeSedan)}]

        ];
        });

    describe(@"ObjectiveSugar functional programming", ^{
        example(@"should easily filter all Volvo cars after 2000", ^{
            NSArray *volvoAfter2000 = [[[cars
                //1. Select all Volvo cars
                select:^BOOL(id object) {
                    return [object isKindOfClass:[FDCar class]] && [((FDCar *) object).brand isEqualToString:@"Volvo"];
                }]
                //2. Select all cars not older than 2000
                select:^BOOL(FDCar * car) {
                    return [car.year compare:@2000] != NSOrderedAscending;
                //3. Map data to get only some descriptions
                }] map:^id(FDCar *car) {
                    return [NSString stringWithFormat:@"%@: %@", car.model, car.year.stringValue];
            }];

            expect(volvoAfter2000).to.equal(@[@"V40: 2004", @"S80: 2006", @"XC60: 2008"]);
    });
    });
SpecEnd
