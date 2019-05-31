//
//  CustomTableViewCell.h
//  WeatherApp
//
//  Created by Rodrigo Cámara Robles on 5/27/19.
//  Copyright © 2019 Rodrigo Cámara Robles. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel *countryName;
@property(nonatomic,strong) UILabel *cityName;
@property(nonatomic,strong) UILabel *cityTemp;
@property(nonatomic,strong) UILabel *cityHumidity;
@property(nonatomic,strong) UIImageView *contryFlagImage;

@end
