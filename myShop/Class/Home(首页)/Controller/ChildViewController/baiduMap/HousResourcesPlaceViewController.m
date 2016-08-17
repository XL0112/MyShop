//
//  HousResourcesPlaceViewController.m
//  WenLou
//
//  Created by zjh on 16/6/20.
//  Copyright © 2016年 Steven. All rights reserved.
//

#import "HousResourcesPlaceViewController.h"
#import <CoreLocation/CoreLocation.h>


#define isIOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)
@interface HousResourcesPlaceViewController ()<BMKPoiSearchDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate>
@property(nonatomic,strong) BMKPoiSearch * searcher;

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;


//百度地图定位服务
@property(nonatomic,strong) BMKLocationService *locService;

@property(assign, nonatomic) CLLocationCoordinate2D coordinate;
@end

@implementation HousResourcesPlaceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //    地图定位服务
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //    指定定位的最小更新距离(米)
    _locService.distanceFilter = kCLLocationAccuracyHundredMeters;
    //启动LocationService
    [_locService startUserLocationService];
    //    设置地图的代理
    self.mapView.delegate = self;
    
    
}
#pragma mark - 地图定位代理服务BMKLocationServiceDelegate
//实现相关delegate 处理位置信息更新
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{

//    添加大头针
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coordinate ;
//    coordinate.longitude = 113.329744 ;
    coordinate.longitude = 116.404;
    coordinate.latitude = 39.915 ;
    annotation.coordinate = coordinate;
    annotation.title = @"广州市天俊阁";
    annotation.subtitle = @"广州市天河区天河路365号";
    [_mapView addAnnotation:annotation];

    // 调整地图区域
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.1, 0.1);
    BMKCoordinateRegion region = BMKCoordinateRegionMake(coordinate, span);
    [self.mapView setRegion:region animated:YES];
    
    //初始化检索对象
//        _searcher =[[BMKPoiSearch alloc]init];
//        _searcher.delegate = self;
//        //发起检索
//        BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
//        option.pageIndex = 0;
//        option.pageCapacity = 10;
//        option.location = coordinate;
//        BOOL flag = [_searcher poiSearchNearBy:option];
//        if(flag)
//        {
//            NSLog(@"检索发送成功");
//        }
//        else
//        {
//            NSLog(@"检索发送失败");
//        }
    
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

#pragma mark - 打印搜索的跨度
//-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//
//
//}
#pragma mark -实现检索PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        NSArray *poiInfos =poiResultList.poiInfoList;
        for (BMKPoiInfo *poiInfo in poiInfos) {
            
            // 添加一个PointAnnotation(大头针)
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            annotation.coordinate = poiInfo.pt;
            annotation.title = poiInfo.name;
            annotation.subtitle = poiInfo.address;
            [_mapView addAnnotation:annotation];
        }
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}



//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
    self.mapView.delegate =nil;
}

#pragma mark -添加大头针代码
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorRed;
        return newAnnotationView;
    }
    if (annotation != nil) {
        [_mapView removeAnnotation:annotation];
    }
    return nil;
}

@end

