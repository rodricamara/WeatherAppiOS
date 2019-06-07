//
//  CustomTableViewCell.m
//  WeatherApp
//
//  Created by Rodrigo Cámara Robles on 5/27/19.
//  Copyright © 2019 Rodrigo Cámara Robles. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "Masonry.h"

@interface CustomTableViewCell ()
@property (assign, nonatomic) BOOL didSetupConstraints;
@end

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initializeCityName];
        [self initializeCountryName];
        [self initializeCityTemp];
        [self initializeCityHuimidity];
    }
    return self;
}

-(void) updateConstraints {
    if (!self.didSetupConstraints) {
        [self applyContenViewConstraints];
        [self applyCityNameConstraints];
        [self applyCountryNameConstraints];
        [self applyCityTempConstraints];
        [self applyCityHumidityConstraints];
        self.didSetupConstraints = YES;
}
    [super updateConstraints];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
}

#pragma mark - private initialize methods

-(void)initializeCountryName {
    _countryName =[[UILabel alloc] initWithFrame:CGRectZero];
    [_cityName setTextColor:[UIColor redColor]];
}

-(void)initializeCityName {
    _cityName =[[UILabel alloc] initWithFrame:CGRectZero];
    [_cityName setTextColor:[UIColor blueColor]];
    [_cityName setTranslatesAutoresizingMaskIntoConstraints:NO];
    _cityName.layer.masksToBounds = YES;
}

-(void)initializeCityTemp {
    _cityTemp =[[UILabel alloc] initWithFrame:CGRectZero];
    [_cityTemp setTextColor:[UIColor blueColor]];
}

-(void)initializeCityHuimidity {
    _cityHumidity =[[UILabel alloc] initWithFrame:CGRectZero];
    [_cityHumidity setTextColor:[UIColor blueColor]];
}

#pragma mark - private apply masonry constraints methods

-(void) applyContenViewConstraints{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(@120);
    }];
}

- (void)applyCityNameConstraints {
    [self.contentView addSubview:_cityName];
    [_cityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
}

- (void)applyCountryNameConstraints {
    [self.contentView addSubview:_countryName];
    [_countryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.cityName.mas_right).offset(15);
        make.bottom.equalTo(self.cityName.mas_bottom);
        make.width.equalTo(self.countryName);
    }];
}

- (void)applyCityTempConstraints {
    [self.contentView addSubview:_cityTemp];
    [_cityTemp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cityName.mas_left);
        make.top.equalTo(self.cityName.mas_bottom).offset(15);
        make.height.equalTo(self.cityTemp);
    }];
}
- (void)applyCityHumidityConstraints {
    [self.contentView addSubview:_cityHumidity];
    [_cityHumidity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cityTemp);
        make.top.equalTo(self.cityTemp.mas_bottom).offset(15);
    }];
}

@end
