//
//  DHFixCllocation2DHelper.h
//  Find
//
//  Created by Tony on 13-7-1.
//  Copyright (c) 2013年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <math.h>
@interface DHFixCllocation2DHelper : NSObject

- (CLLocationCoordinate2D)transformWglat:(double) wgLat andWglon:(double)wgLon;

@end
