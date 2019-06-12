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

@interface ViewController () <UIScrollViewDelegate, UITextFieldDelegate>

@property (strong,nonatomic) UILabel *labelBienvenida;
@property (strong,nonatomic) UILabel *labelIngreseCiudad;
@property (strong,nonatomic) UITextField *textFieldCiudad;
@property (strong,nonatomic) UIButton *buttonBuscar;
@property (strong,nonatomic) UIButton *buttonCiudadesPreCargadas;
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UILabel* label1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeAllViews];
    [self applyAllConstraints];
    [self dismissKeyboardWithTapOnView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private initialize methods

-(void) initializeAllViews {
    [self initializeScrollView];
    [self initializeContentView];
    [self initializeLabelBienvenida];
    [self initializeLabelIngresarCiudad];
    [self initializeTextFieldCiudad];
    [self initializeButtonBuscar];
    [self initializeButtonCiudadesPreCargadas];
}

-(void) initializeScrollView {
    self.view = [[UIView alloc] init];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.backgroundColor = [UIColor blueColor];
    self.scrollView.delegate = self;
}

-(void) initializeContentView {
    self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.scrollView addSubview:_contentView];
}

-(void) initializeLabelBienvenida {
    self.labelBienvenida = [[UILabel alloc] init];
    _labelBienvenida.text = [NSString stringWithFormat: @"%s","App del Clima"];
    _labelBienvenida.textColor = [UIColor blueColor];
    _labelBienvenida.backgroundColor = [UIColor greenColor];
}
    
-(void) initializeLabelIngresarCiudad {
    self.labelIngreseCiudad = [[UILabel alloc] init];
    _labelIngreseCiudad.text = [NSString stringWithFormat: @"%s","Ingrese una ciudad"];
    _labelIngreseCiudad.textColor = [UIColor whiteColor];
}

-(void) initializeTextFieldCiudad {
    self.textFieldCiudad = [[UITextField alloc] initWithFrame:CGRectZero];
    self.textFieldCiudad.placeholder = [NSString stringWithFormat: @"%s","Nombre ciudad"];
    self.textFieldCiudad.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldCiudad.delegate = self;
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

-(void) applyAllConstraints {
    [self applyScrollViewConstraints];
    [self applyContentViewConstraints];
    [self applyConstraintsLabelBienvenida];
    [self applyConstraintsLabelIngreseCiudad];
    [self applyConstraintsTextFieldCiudad];
    [self applyConstraintsButtonBuscar];
    [self applyConstraintsButtonBuscarCiudadesPreCargadas];
}

- (void)applyScrollViewConstraints {
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)applyContentViewConstraints {
    [self.scrollView addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.greaterThanOrEqualTo(self.scrollView);
    }];
}

-(void) applyConstraintsLabelBienvenida {
    [self.contentView addSubview:self.labelBienvenida];
    [self.labelBienvenida mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView);
    }];    
}

-(void) applyConstraintsLabelIngreseCiudad {
    [self.contentView addSubview:self.labelIngreseCiudad];
    [self.labelIngreseCiudad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labelBienvenida.mas_bottom).offset(25);;
        make.left.equalTo(self.scrollView.mas_left).offset(25);
    }];
}

-(void) applyConstraintsTextFieldCiudad {
    [self.contentView addSubview:self.textFieldCiudad];
    [self.textFieldCiudad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.scrollView);
        make.top.equalTo(_labelIngreseCiudad.mas_bottom).offset(5);
        make.left.equalTo(self.scrollView.mas_left).offset(25);
        make.right.equalTo(self.scrollView.mas_right).offset(-25);
    }];
}

-(void) applyConstraintsButtonBuscar {
    [self.contentView addSubview:self.buttonBuscar];
    [self.buttonBuscar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textFieldCiudad.mas_bottom).offset(10);
        make.right.equalTo(_textFieldCiudad.mas_right);
    }];
}

-(void) applyConstraintsButtonBuscarCiudadesPreCargadas {
    [self.contentView addSubview:self.buttonCiudadesPreCargadas];
        [self.buttonCiudadesPreCargadas mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.buttonBuscar.mas_bottom).offset(50);
            make.left.equalTo(self.scrollView.mas_left).offset(25);
            make.right.equalTo(self.scrollView.mas_right).offset(-25);
        }];
}

#pragma mark - private methods

- (void) buscarCiudadIngresada{
    ThirdViewController *tvw = [[ThirdViewController alloc] initWithCity:[_textFieldCiudad text]];
    [self.navigationController pushViewController:tvw animated:YES];
}

- (void) buscarCiudadesPreCargadas {
    SecondViewController *svw = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:svw animated:YES];
}

- (void) dismissKeyboardWithTapOnView {
    //Dismiss a keyboard with tap on view
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self.scrollView action:@selector(endEditing:)];
    [tapGestureRecognizer setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self buscarCiudadIngresada];
    return YES;
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//}
//
//#pragma mark - keyboard movements
//- (void)keyboardWillShow:(NSNotification *)notification
//{
//    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//
//    [UIView animateWithDuration:0.3 animations:^{
//        CGRect f = self.scrollView.frame;
//        f.origin.y = -keyboardSize.height;
//        self.scrollView.frame = f;
//    }];
//}
//
//-(void)keyboardWillHide:(NSNotification *)notification
//{
//    [UIView animateWithDuration:0.3 animations:^{
//        CGRect f = self.scrollView.frame;
//        f.origin.y = 0.0f;
//        self.scrollView.frame = f;
//    }];
//}

@end
