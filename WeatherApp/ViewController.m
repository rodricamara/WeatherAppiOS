//
//  ViewController.m
//  WeatherApp
//
//  Created by Rodrigo Cámara Robles on 5/24/19.
//  Copyright © 2019 Rodrigo Cámara Robles. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface ViewController ()

@property (strong,nonatomic) UILabel *labelBienvenida;
@property (strong,nonatomic) UILabel *labelIngreseCiudad;
@property (strong,nonatomic) UITextField *textFieldCiudad;
@property (strong,nonatomic) UIButton *buttonBuscar;
@property (strong,nonatomic) UIButton *buttonCiudadesPreCargadas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self initializeLabelBienvenida];
    [self initializeLabelIngresarCiudad];
    [self initializeTextFieldCiudad];
    [self initializeButtonBuscar];
    [self initializeButtonCiudadesPreCargadas];
    [self applyConstraintsLabelBienvenida];
    [self applyConstraintsLabelIngreseCiudad];
    [self applyConstraintsTextFieldCiudad];
    [self applyConstraintsButtonBuscar];
    [self applyConstraintsButtonBuscarCiudadesPreCargadas];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - private initialize methods

-(void) initializeLabelBienvenida {
    self.labelBienvenida = [[UILabel alloc] init];
    _labelBienvenida.text = [NSString stringWithFormat: @"%s","App del Clima"];
    _labelBienvenida.textColor = [UIColor blueColor];
    _labelBienvenida.backgroundColor = [UIColor greenColor];
}
    
-(void) initializeLabelIngresarCiudad {
    self.labelIngreseCiudad = [[UILabel alloc] init];
    _labelIngreseCiudad.text = [NSString stringWithFormat: @"%s","Ingrese una ciudad"];
    _labelIngreseCiudad.textColor = [UIColor blueColor];
}

-(void) initializeTextFieldCiudad {
    self.textFieldCiudad = [[UITextField alloc] initWithFrame:CGRectZero];
    self.textFieldCiudad.placeholder = [NSString stringWithFormat: @"%s","Nombre ciudad"];
    self.textFieldCiudad.borderStyle = UITextBorderStyleRoundedRect;
}

-(void) initializeButtonBuscar {
    self.buttonBuscar = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _buttonBuscar.frame = CGRectZero;
    [self.buttonBuscar setBackgroundColor:[UIColor greenColor]];
    [_buttonBuscar setTitle:@"BUSCAR" forState:UIControlStateNormal];
    [_buttonBuscar addTarget:self action:@selector(buscarCiudadIngresada) forControlEvents:UIControlEventTouchUpInside];
}

-(void) initializeButtonCiudadesPreCargadas {
    self.buttonCiudadesPreCargadas = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _buttonCiudadesPreCargadas.frame = CGRectZero;
    [self.buttonCiudadesPreCargadas setBackgroundColor:[UIColor greenColor]];
    [_buttonCiudadesPreCargadas setTitle:@"VER CIUDADES PRE-CARGADAS" forState:UIControlStateNormal];
    [_buttonCiudadesPreCargadas addTarget:self action:@selector(buscarCiudadesPreCargadas) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - private apply masonry constraints methods

-(void) applyConstraintsLabelBienvenida {
    [self.view addSubview:self.labelBienvenida];
    [self.labelBienvenida mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height + 25);
    }];
}

-(void) applyConstraintsLabelIngreseCiudad {
    [self.view addSubview:self.labelIngreseCiudad];
    [self.labelIngreseCiudad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labelBienvenida.mas_bottom).offset(25);;
        make.left.equalTo(self.view.mas_left).offset(25);
        
    }];
}

-(void) applyConstraintsTextFieldCiudad {
    [self.view addSubview:self.textFieldCiudad];
    [self.textFieldCiudad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_labelIngreseCiudad.mas_bottom).offset(5);
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
    }];
}

-(void) applyConstraintsButtonBuscar {
    [self.view addSubview:self.buttonBuscar];
    [self.buttonBuscar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textFieldCiudad.mas_bottom).offset(10);
        make.right.equalTo(_textFieldCiudad.mas_right);
    }];
}

-(void) applyConstraintsButtonBuscarCiudadesPreCargadas {
    [self.view addSubview:self.buttonCiudadesPreCargadas];
    [self.buttonCiudadesPreCargadas mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-50);
        make.left.equalTo(self.view.mas_left).offset(25);
        make.right.equalTo(self.view.mas_right).offset(-25);
    }];
}

- (void) buscarCiudadIngresada{
    ThirdViewController *tvw = [[ThirdViewController alloc] initWithCity:[_textFieldCiudad text]];
    [self.navigationController pushViewController:tvw animated:YES];
}

- (void) buscarCiudadesPreCargadas {
    SecondViewController *svw = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:svw animated:YES];
}

@end
