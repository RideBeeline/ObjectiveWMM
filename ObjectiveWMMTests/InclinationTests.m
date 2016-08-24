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

@interface InclinationTests : XCTestCase

@property (nonatomic, strong) NSCalendar *gregorian;

@end

@implementation InclinationTests

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

- (void) testInclination01 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    CLLocationDistance elevation = 0;

    CCGeomagneticParameters *params = [[CCMagneticModel instance] magneticParametersForCoordinate:coord elevation:elevation date:date];
    
    NSLog(@"Inclination = %f Declination = %f", params.magneticInclination, params.magneticDeclination);

    XCTAssertEqualWithAccuracy(params.magneticInclination, 83.04, [self accuracy], @"Unexpected Inclination");
}

- (void) testInclination02 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    CLLocationDistance elevation = 0;
    
    CCGeomagneticParameters *params = [[CCMagneticModel instance] magneticParametersForCoordinate:coord elevation:elevation date:date];
    
    NSLog(@"Inclination = %f Declination = %f", params.magneticInclination, params.magneticDeclination);

    XCTAssertEqualWithAccuracy(params.magneticInclination, -15.89, [self accuracy], @"Unexpected Inclination");
}

- (void) testInclination03 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    CLLocationDistance elevation = 0;
    
    CCGeomagneticParameters *params = [[CCMagneticModel instance] magneticParametersForCoordinate:coord elevation:elevation date:date];
    
    NSLog(@"Inclination = %f Declination = %f", params.magneticInclination, params.magneticDeclination);
    
    XCTAssertEqualWithAccuracy(params.magneticInclination, -72.39, [self accuracy], @"Unexpected Inclination");
}

- (void) testInclination04 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    CLLocationDistance elevation = 100;
    
    CCGeomagneticParameters *params = [[CCMagneticModel instance] magneticParametersForCoordinate:coord elevation:elevation date:date];
    
    NSLog(@"Inclination = %f Declination = %f", params.magneticInclination, params.magneticDeclination);
    
    XCTAssertEqualWithAccuracy(params.magneticInclination, 83.09, [self accuracy], @"Unexpected Inclination");

}

- (void) testInclination05 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    CLLocationDistance elevation = 100;
    
    CCGeomagneticParameters *params = [[CCMagneticModel instance] magneticParametersForCoordinate:coord elevation:elevation date:date];
    
    NSLog(@"Inclination = %f Declination = %f", params.magneticInclination, params.magneticDeclination);
    
    XCTAssertEqualWithAccuracy(params.magneticInclination, -16.01, [self accuracy], @"Unexpected Inclination");
    
}

- (void) testInclination06 {
    
    NSDate *date = [self dateForYear:2015 month:1 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    CLLocationDistance elevation = 100;
    
    CCGeomagneticParameters *params = [[CCMagneticModel instance] magneticParametersForCoordinate:coord elevation:elevation date:date];
    
    XCTAssertEqualWithAccuracy(params.magneticInclination, -72.57, [self accuracy], @"Unexpected Inclination");
    
}

- (void) testInclination07 {
    
    NSDate *date = [self dateForYear:2017 month:5 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    CLLocationDistance elevation = 0;
    
    CCGeomagneticParameters *params = [[CCMagneticModel instance] magneticParametersForCoordinate:coord elevation:elevation date:date];
    
    XCTAssertEqualWithAccuracy(params.magneticInclination, 83.08, [self accuracy], @"Unexpected Inclination");
    
}

- (void) testInclination08 {
    
    NSDate *date = [self dateForYear:2017 month:5 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    CLLocationDistance elevation = 0;
    
    CCGeomagneticParameters *params = [[CCMagneticModel instance] magneticParametersForCoordinate:coord elevation:elevation date:date];
    
    NSLog(@"Inclination = %f Declination = %f", params.magneticInclination, params.magneticDeclination);
    
    XCTAssertEqualWithAccuracy(params.magneticInclination, -15.57, [self accuracy], @"Unexpected Inclination");
}

- (void) testInclination09 {
    
    NSDate *date = [self dateForYear:2017 month:5 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    CLLocationDistance elevation = 0;
    
    CCGeomagneticParameters *params = [[CCMagneticModel instance] magneticParametersForCoordinate:coord elevation:elevation date:date];
    
    NSLog(@"Inclination = %f Declination = %f", params.magneticInclination, params.magneticDeclination);
    
    XCTAssertEqualWithAccuracy(params.magneticInclination, -72.28, [self accuracy], @"Unexpected Inclination");
}

- (void) testInclination10 {
    
    NSDate *date = [self dateForYear:2017 month:5 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(80, 0);
    CLLocationDistance elevation = 100;
    
    CCGeomagneticParameters *params = [[CCMagneticModel instance] magneticParametersForCoordinate:coord elevation:elevation date:date];
    
    NSLog(@"Inclination = %f Declination = %f", params.magneticInclination, params.magneticDeclination);
    
    XCTAssertEqualWithAccuracy(params.magneticInclination, 83.13, [self accuracy], @"Unexpected Inclination");
    
}

- (void) testInclination11 {
    
    NSDate *date = [self dateForYear:2017 month:5 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(0, 120);
    CLLocationDistance elevation = 100;
    
    CCGeomagneticParameters *params = [[CCMagneticModel instance] magneticParametersForCoordinate:coord elevation:elevation date:date];
    
    NSLog(@"Inclination = %f Declination = %f", params.magneticInclination, params.magneticDeclination);
    
    XCTAssertEqualWithAccuracy(params.magneticInclination, -15.70, [self accuracy], @"Unexpected Inclination");
    
}

- (void) testInclination12 {
    
    NSDate *date = [self dateForYear:2017 month:5 day:1];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-80, 240);
    CLLocationDistance elevation = 100;
    
    CCGeomagneticParameters *params = [[CCMagneticModel instance] magneticParametersForCoordinate:coord elevation:elevation date:date];
    
    XCTAssertEqualWithAccuracy(params.magneticInclination, -72.45, [self accuracy], @"Unexpected Inclination");
    
}


#pragma mark - Helper methods

- (double)accuracy {
    return 0.2;
}

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
