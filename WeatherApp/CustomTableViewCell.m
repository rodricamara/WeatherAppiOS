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
        
        [self initializeCityName];
        [self initializeCountryName];
        [self initializeCityTemp];
        [self initializeCityHuimidity];
        [self applyCityNameConstraints];
        [self applyCountryNameConstraints];
        [self applyCityTempConstraints];
        [self applyCityHumidityConstraints];        
        [super layoutSubviews];
        
    }
    
    return self;
}


#pragma mark - private methods

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

- (void)applyCountryNameConstraints {
    [self.contentView addSubview:_countryName];
    [_countryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right).offset(-55);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(self.contentView.mas_height);
    //    make.height.equalTo(@200);
    }];
}

- (void)applyCityNameConstraints {
    [self.contentView addSubview:_cityName];
    [_cityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(self.cityName);
        make.height.equalTo(self.contentView.mas_height);
        make.top.equalTo(self);
        
    }];
}

- (void)applyCityTempConstraints {
    [self.contentView addSubview:_cityTemp];
    [_cityTemp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cityName.mas_left);
        make.top.equalTo(self.cityName.mas_bottom).offset(50);
//        make.width.equalTo(self.contentView.mas_width);
//        make.height.equalTo(self.contentView.mas_height);
        
    }];
}
- (void)applyCityHumidityConstraints {
    [self.contentView addSubview:_cityHumidity];
    [_cityHumidity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right).offset(-55);
        make.top.equalTo(self.countryName.mas_bottom);
//        make.width.equalTo(self.contentView.mas_width);
//        make.height.equalTo(self.contentView.mas_height);
    }];
}



@end
