//
//  ThirdViewController.m
//  WeatherApp
//
//  Created by Rodrigo Cámara Robles on 5/27/19.
//  Copyright © 2019 Rodrigo Cámara Robles. All rights reserved.
//

#import "ThirdViewController.h"
#import "AFNetworking.h"
#import "Constants.h"

@interface ThirdViewController ()

@property(nonatomic, strong) NSDictionary *response;
@property(nonatomic, strong) NSString *city;

@end


@implementation ThirdViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self obtenerDatosWeatherAPI];
    
}

- (void)guardarVariables {
    NSString *nameCity = [self.response objectForKey:kName];
    NSString *temp = [[self.response objectForKey:kMain] objectForKey:kTemp];
    NSString *humidity = [[self.response objectForKey:kMain] objectForKey:kHumidity];
    
    NSArray *arrayData = [NSArray arrayWithObjects: nameCity, temp, humidity,nil];
    
    //Acceder e imprimir al elemento 1 del array
    //NSLog(@"%@", [arrayData objectAtIndex: 1]);
    
    //Imprimir contentido del array completo
    NSLog(@"%@", arrayData);
}

- (void)obtenerDatosWeatherAPI {
    
    NSString *url = [NSString stringWithFormat: @"http://api.openweathermap.org/data/2.5/weather?q=%@&lang=es&units=metric&appid=%@",self.city, kApiKey];
    
    [self AFHttpManager:url andSuccesBlock:^(id responseObject) {
        self.response = responseObject;
        [self guardarVariables];
    }];
}

- (void)AFHttpManager:(NSString *)url andSuccesBlock:(void(^)(id response))success {
    NSDictionary __block *response;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET: url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        response = responseObject;
        success(responseObject);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(instancetype)initWithCity:(NSString *)city {
    self = [super init];
    if (self) {
        self.city = city;
    }
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
