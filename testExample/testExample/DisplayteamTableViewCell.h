//
//  DisplayteamTableViewCell.h
//  testExample
//
//  Created by mac on 05/11/15.
//  Copyright (c) 2015 senthil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayteamTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *hometeamlbl;
@property (strong, nonatomic) IBOutlet UILabel *awayteamlbl;
@property (strong, nonatomic) IBOutlet UILabel *statuslbl;

@property (strong, nonatomic) IBOutlet UILabel *datetimelbl;
@property (strong, nonatomic) IBOutlet UILabel *goallbl;
@end
