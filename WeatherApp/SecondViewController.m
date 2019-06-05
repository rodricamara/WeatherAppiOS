//
//  SecondViewController.m
//  WeatherApp
//
//  Created by Rodrigo Cámara Robles on 5/24/19.
//  Copyright © 2019 Rodrigo Cámara Robles. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "Masonry.h"
#import "ThirdViewController.h"

@interface SecondViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *table;
@property (strong,nonatomic) NSArray *ciudadesMza;
@property (strong,nonatomic) UISearchBar *searchBar;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self initializeArrayCiudadesMza];
    [self initializeTableview];
    [self initializeSearchBar];
    [self applyTableViewConstranints];
    [self applySearchBarConstraints];
}

#pragma mark - private methods

-(void) initializeArrayCiudadesMza {
    self.ciudadesMza = @[@"Mendoza", @"General Alvear", @"San Martín", @"Godoy Cruz", @"Guaymallén", @"Junín", @"La Paz", @"Las Heras", @"Lavalle", @"Luján de Cuyo", @"Maipú", @"Malargüe", @"Rivadavia", @"San Carlos", @"San Rafael", @"Santa Rosa", @"Tunuyán", @"Tupungato"];
}

-(void) initializeTableview {
    self.table = [[UITableView alloc] initWithFrame:CGRectZero];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = [UIColor whiteColor];
}

-(void) applyTableViewConstranints{
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.view addSubview:self.table];
        make.top.equalTo(self.view.mas_centerY);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
}

-(void) initializeSearchBar {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.placeholder = @"Ingrese ciudad a filtrar";
    self.searchBar.barTintColor = [UIColor blackColor];
    self.searchBar.tintColor = [UIColor whiteColor];
    self.searchBar.showsSearchResultsButton = YES;
}

-(void) applySearchBarConstraints {
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.view addSubview:self.searchBar];
        make.top.equalTo(self.view).offset(self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height + 10);
        make.width.equalTo(self.searchBar);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
}

// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// number of row in the section, devuelve el tamaño del array content
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _ciudadesMza.count;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.textLabel.text =  [_ciudadesMza objectAtIndex:indexPath.row];
    return cell;
}

// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [self buttonPressed:[_ciudadesMza objectAtIndex:indexPath.row]];
}

- (void)buttonPressed:(NSString*) city {
    ThirdViewController *tvw = [[ThirdViewController alloc] initWithCity:city];
    [self.navigationController pushViewController:tvw animated:YES];
}


@end
