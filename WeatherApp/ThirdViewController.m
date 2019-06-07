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
#import "CustomTableViewCell.h"
#import "Masonry.h"
#import "ViewController.h"

static NSString *CellIdentifier = @"WeatherCell";

@interface ThirdViewController () <UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) BOOL didSetupConstraints;
@property(nonatomic, strong) NSDictionary *response;
@property(nonatomic, strong) NSString *city;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *arrayCityData;

@end


@implementation ThirdViewController 


- (void)viewDidLoad {
    [super viewDidLoad];
    [self obtenerDatosWeatherAPI];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.countryName.text = [_arrayCityData objectAtIndex:[indexPath row]];
    cell.cityName.text = [_arrayCityData objectAtIndex:[indexPath row]+1];
    cell.cityTemp.text = [NSString stringWithFormat: @"%@ %@º",kTemperatura,[_arrayCityData objectAtIndex:[indexPath row]+2]];
    cell.cityHumidity.text = [NSString stringWithFormat: @"%@ %@%s",kHumedad,[_arrayCityData objectAtIndex:[indexPath row]+3],"%"];
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}

#pragma mark - private methods

- (void) initializeTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    [_tableView setSeparatorColor:[UIColor grayColor]];
    [_tableView setBackgroundColor:[UIColor grayColor]];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.greaterThanOrEqualTo(self.view.mas_bottom);
    }];
}

- (void)guardarVariables {
    NSString *country = [[self.response objectForKey:kSys] objectForKey:kCountry];
    NSString *nameCity = [self.response objectForKey:kName];
    NSString *temp = [[[self.response objectForKey:kMain] objectForKey:kTemp] stringValue];
    NSString *humidity = [[[self.response objectForKey:kMain] objectForKey:kHumidity] stringValue];
    
    _arrayCityData = [NSArray arrayWithObjects: country, nameCity, temp, humidity,nil];
    //Imprimir contentido del array completo
    [self initializeTableView];
    
    NSLog(@"%@", _arrayCityData);
}

- (void)obtenerDatosWeatherAPI {
    
    NSString *cityWithEncoding = [self.city stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *url = [NSString stringWithFormat: @"http://api.openweathermap.org/data/2.5/weather?q=%@&lang=es&units=metric&appid=%@",cityWithEncoding, kApiKey];
    
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
        [self popupError];
    }];
}

-(instancetype)initWithCity:(NSString *)city {
    self = [super init];
    if (self) {
        self.city = city;
    }
    return self;
}

-(void) popupError {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"La ciudad ingresada no se encuentra" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:actionOK];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
