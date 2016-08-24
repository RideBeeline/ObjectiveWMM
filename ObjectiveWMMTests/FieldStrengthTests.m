//
//  DeclinationTests.m
//  ObjectiveWMM
//
//  Created by Stephen Trainor on 12/15/14.
//  Copyright (c) 2014 Crookneck Consulting LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <ObjectiveWMM/ObjectiveWMM.h>

@interface FieldStrengthTests : XCTestCase

@property (nonatomic, strong) NSCalendar *gregorian;

@end

@implementation FieldStrengthTests

- (NSCalendar *) gregorian {
    
    if (nil == _gregorian) {
        _gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    
    return _gregorian;
}

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // run tests in GMT, overriding local system time zone
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"Etc/GMT"]];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testCoefficientFileFound {
    
    NSBundle *bundle = [NSBundle bundleWithIdentifier:@"com.crookneckconsulting.ObjectiveWMM"];
    NSString *path = [bundle pathForResource:@"WMM" ofType:@"COF"];
    XCTAssertNotNil(path, @"Path to WMM.COF was nil");
}

- (void) testModelValidityPeriod {
    
    // Current model is valid from 2015 through 2020 (see http://www.ngdc.noaa.gov/geomag/WMM/soft.shtml)
    
    NSDate *validFrom = [self dateForYear:2015 month:1 day:1];
    NSDate *validTo = [self dateForYear:2020 month:12 day:31];
    
    XCTAssertTrue([validFrom isEqualToDate:[[CCMagneticModel instance] modelValidityStart]], @"Unexpected model validity start date");
    XCTAssertTrue([validTo isEqualToDate:[[CCMagneticModel instance] modelValidityEnd]], @"Unexpected model validity end date");
}

// See http://www.ngdc.noaa.gov/geomag/WMM/data/WMM2015/WMM2015testvalues.pdf for tests

- (void) testForce01 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    
    CCGeomagneticParameters *declination = [[CCMagneticModel instance] magneticParametersForCoordinate:coord elevation:0 date:date];
    
    NSLog(@"field Strength = %f", declination.fieldStrength);
    XCTAssertEqualWithAccuracy(declination.fieldStrength, 54836.0/1000.0, 0.005, @"Unexpected force");
}

#pragma mark - Helper methods

- (NSDate *) dateForYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    
    static NSDateComponents *comps;
    if (nil == comps) {
        comps = [[NSDateComponents alloc] init];
    }
    
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    NSDate *date = [self.gregorian dateFromComponents:comps];
    
    return date;
}

@end
