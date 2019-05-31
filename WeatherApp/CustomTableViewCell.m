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

        [self initializeCountryName];
        [self initializeCityName];
        [self applyCityNameConstraints];
        [self applyCountryNameConstraints];

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
    
}

- (void)applyCountryNameConstraints {
    [self.contentView addSubview:_countryName];
    [_countryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_right).offset(-55);
        make.left.equalTo(self.contentView.mas_right).offset(-[self.countryName numberOfLines]);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(self.contentView.mas_height);
    }];
}

- (void)applyCityNameConstraints {
    [self.contentView addSubview:_cityName];
    [_cityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(self.cityName);
        make.height.equalTo(self.contentView.mas_height);
    }];
}



@end
