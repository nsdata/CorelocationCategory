//
//  DHFixCllocation2DHelper.m
//  Find
//
//  Created by Tony on 13-7-1.
//  Copyright (c) 2013年 Tony. All rights reserved.
//

#import "DHFixCllocation2DHelper.h"
#define pi 3.14159265358979324 // pi
#define ee 0.00669342162296594323
#define a 6378245.0


@implementation DHFixCllocation2DHelper

- (CLLocationCoordinate2D)transformWglat:(double) wgLat andWglon:(double)wgLon
{
    double mgLat;
    double mgLon;
    if ([self outOfChinaWithLat:wgLat andLng:wgLon]) {
        mgLat = wgLat;
        mgLon = wgLon;
        
        CLLocationCoordinate2D coor2d = CLLocationCoordinate2DMake(mgLat, mgLon);
        return coor2d;
    }
    
    double dLat = [self transformLatx:wgLon - 105.0 andLaty:wgLat - 35.0];
    double dLon = [self transformLngx:wgLon - 105.0 andLngy:wgLat - 35.0];
    double radLat = wgLat / 180.0 * pi;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
    mgLat = wgLat + dLat;
    mgLon = wgLon + dLon;
    
    CLLocationCoordinate2D coor2d = CLLocationCoordinate2DMake(mgLat, mgLon);
    return coor2d;
}



- (BOOL)outOfChinaWithLat:(double)lat andLng:(double)lon
{
    if (lon < 72.004 || lon > 137.8347)
        return YES;
    if (lat < 0.8293 || lat > 55.8271)
        return YES;
    return NO;
}

-(double)transformLatx:(double)_x  andLaty:(double)_y
{
    
    
    double ret = -100.0 + 2*_x + 3.0 * _y + 0.2 * _y * _y + 0.1 * _x * _y + 0.2 * sqrt(fabs(_x));
    
    ret += (20.0 * sin(6.0 * _x * pi) + 20.0 * sin(2.0 * _x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(_y * pi) + 40.0 * sin(_y / 3.0 * pi)) * 2.0 / 3.0;
    ret += (160.0 * sin(_y / 12.0 * pi) + 320 * sin(_y * pi / 30.0)) * 2.0 / 3.0;
    
    return ret;
    
}

- (double)transformLngx:(double)_x andLngy:(double)_y
{
    double ret = 300.0 + _x + 2.0 * _y + 0.1 * _x * _x + 0.1 * _x * _y + 0.1 *sqrt(fabs(_x));
    ret += (20.0 * sin(6.0 * _x * pi) + 20.0 * sin(2.0 * _x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(_x * pi) + 40.0 * sin(_x / 3.0 * pi)) * 2.0 / 3.0;
    ret += (150.0 * sin(_x / 12.0 * pi) + 300.0 * sin(_x / 30.0 * pi)) * 2.0 / 3.0;
    return ret;
}
@end
