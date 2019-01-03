//
//  DataContainer.m
//  无痕埋点
//
//  Created by isoft on 2019/1/3.
//  Copyright © 2019 isoft. All rights reserved.
//

#import "DataContainer.h"

@implementation DataContainer


+(instancetype)dataInstance
{
    static DataContainer * instacne = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instacne = [DataContainer new];
        
        NSString * path = [[NSBundle mainBundle] pathForResource:@"20180719090759" ofType:@"json"];
        NSData * JSONData = [NSData dataWithContentsOfFile:path];
        instacne.data = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
    });
    return instacne;
}





@end
