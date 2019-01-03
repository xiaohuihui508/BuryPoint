//
//  DataContainer.h
//  无痕埋点
//
//  Created by isoft on 2019/1/3.
//  Copyright © 2019 isoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataContainer : NSObject

@property(nonatomic,strong)NSDictionary *data;


+(instancetype)dataInstance;

@end
