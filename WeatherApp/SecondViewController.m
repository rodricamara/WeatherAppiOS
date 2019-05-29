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
@property (strong,nonatomic) NSArray *content;
@property (strong,nonatomic) UIButton *buttonSiguiente;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [self cofigureTableview];
    self.content = @[ @"Mendoza", @"Rawson", @"Misiones"];
    
    // BUTTON SIGUIENTE
    self.buttonSiguiente = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _buttonSiguiente.frame = CGRectZero;
    [self.buttonSiguiente setBackgroundColor:[UIColor greenColor]];
    [_buttonSiguiente setTitle:@"BUSCAR" forState:UIControlStateNormal];
    [_buttonSiguiente addTarget:self action:@selector(buttonCiudadesPreCargadas) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonSiguiente];
    
    [self.buttonSiguiente mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.table.mas_bottom).offset(25);
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
    }];
    
}

-(void)cofigureTableview
{
    //init tableview
    self.table = [[UITableView alloc] initWithFrame:CGRectZero];
    //set delegate & datasource
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.height.equalTo(@250);
        make.width.equalTo(@250);
    }];
    
}

// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
// number of row in the section, devuelve el tamaño del array content
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _content.count;
}

// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    cell.textLabel.text =  [_content objectAtIndex:indexPath.row];
    return cell;
}

// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"selected row: %@", [_content objectAtIndex:indexPath.row]);
    [self buttonPressed:[_content objectAtIndex:indexPath.row]];
}

- (void)buttonPressed:(NSString*) city {
    ThirdViewController *tvw = [[ThirdViewController alloc] initWithCity:city];
    [self.navigationController pushViewController:tvw animated:YES];
}


@end
