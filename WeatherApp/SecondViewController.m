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

static NSString *cellIdentifier = @"ciudadIdentifier";

@interface SecondViewController () <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate> {
    BOOL isFiltered;
}
@property (strong,nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *ciudadesMza;
@property (strong,nonatomic) NSMutableArray *ciudadesMzaFiltradas;
@property (strong,nonatomic) UISwitch *switchTableView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    [self initializeArrayCiudadesMza];
    [self initializeTableview];
    [self initializeSearchBar];
    [self initializeSwitchTableview];
    [self applyTableViewConstranints];
    [self applySearchBarConstraints];
    [self applySwitchTableView];
    
    [self.switchTableView addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    
    isFiltered = NO;
    self.searchBar.delegate = self;
    
}

#pragma mark - private methods

-(void) initializeArrayCiudadesMza {
    self.ciudadesMza = @[@"Mendoza", @"General Alvear", @"San Martín", @"Godoy Cruz", @"Guaymallén", @"Junín", @"La Paz", @"Las Heras", @"Lavalle", @"Luján de Cuyo", @"Maipú", @"Malargüe", @"Rivadavia", @"San Carlos", @"San Rafael", @"Santa Rosa", @"Tunuyán", @"Tupungato"];
}

-(void) initializeTableview {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
}

-(void) initializeSearchBar {
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.placeholder = @"Ingrese ciudad a filtrar";
    self.searchBar.barTintColor = self.view.backgroundColor;
    self.searchBar.tintColor = [UIColor whiteColor];
}

-(void) initializeSwitchTableview {
    self.switchTableView = [[UISwitch alloc] initWithFrame:CGRectZero];
    self.switchTableView.onTintColor = [UIColor greenColor];
    self.switchTableView.tintColor = [UIColor blueColor];
    self.switchTableView.thumbTintColor = [UIColor whiteColor];
    self.switchTableView.on = YES;
}

-(void) applyTableViewConstranints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.view addSubview:self.tableView];
        make.top.equalTo(self.view.mas_centerY);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
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

-(void) applySwitchTableView {
    [self.switchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        [self.view addSubview:self.switchTableView];
        make.bottom.equalTo(self.tableView.mas_top).offset(-10);
        make.right.equalTo(self.searchBar.mas_right);
        make.width.equalTo(@40);
    }];
}

-(void) searchBar: (UISearchBar *) searchBar textDidChange:(NSString *)searchText{
    if(searchText.length == 0){
        isFiltered = NO;
        [self.searchBar endEditing:YES];
    }
    else {
        isFiltered = YES;
        _ciudadesMzaFiltradas = [[NSMutableArray alloc]init];
        for (NSString *i in self.ciudadesMza) {
            NSRange range = [i rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [_ciudadesMzaFiltradas addObject:i];
            }
        }
    }
    [self.tableView reloadData];
}

- (void) switchToggled:(UISwitch *) switchA {
    if ([switchA isOn]) {
        [self.tableView setUserInteractionEnabled:YES];
    } else {
        [self.tableView setUserInteractionEnabled:NO];
    }
}

// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// number of row in the section, devuelve el tamaño del array content
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isFiltered){
        return _ciudadesMzaFiltradas.count;
    }
    return _ciudadesMza.count;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if(isFiltered) {
        cell.textLabel.text = [_ciudadesMzaFiltradas objectAtIndex:indexPath.row];
    }
    else {
        cell.textLabel.text =  [_ciudadesMza objectAtIndex:indexPath.row];
    }
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
