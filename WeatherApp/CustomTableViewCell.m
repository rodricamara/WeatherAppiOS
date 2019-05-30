//
//  CustomTableViewCell.m
//  WeatherApp
//
//  Created by Rodrigo Cámara Robles on 5/27/19.
//  Copyright © 2019 Rodrigo Cámara Robles. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "Masonry.h"

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor grayColor]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView setBackgroundColor:[UIColor grayColor]];
    }
    
    return self;
}

@end
