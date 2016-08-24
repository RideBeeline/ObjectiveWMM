//
//  CCMagneticDeclination.h
//  ObjectiveWMM
//
//  Created by Stephen Trainor on 1/10/13.
//  Copyright (c) 2013 Crookneck Consulting LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "CCGeomagneticParameters.h"

@interface CCMagneticModel : NSObject

+ (CCMagneticModel *) instance;

+ (CCGeomagneticParameters *) magneticParametersForLocation:(CLLocation *) location;
- (CCGeomagneticParameters *) magneticParametersForCoordinate:(CLLocationCoordinate2D)coordinate elevation:(CLLocationDistance)elevation date:(NSDate *)date;
- (BOOL) dateIsWithinModelBounds:(NSDate *) date;
- (NSDate *) modelValidityStart;
- (NSDate *) modelValidityEnd;
- (NSDate *) dateWithinModelBoundsFromDate:(NSDate *)date;

@end
