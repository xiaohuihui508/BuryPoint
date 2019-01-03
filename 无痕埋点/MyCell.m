//
//  MyCell.m
//  无痕埋点
//
//  Created by isoft on 2019/1/3.
//  Copyright © 2019 isoft. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

-(void)setModel:(TestModel *)model
{
    _model = model;
    
    self.textLabel.text = model.name;
}

@end
