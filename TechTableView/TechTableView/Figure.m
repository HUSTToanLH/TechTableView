//
//  Figure.m
//  TechTableView
//
//  Created by TaiND on 12/3/15.
//  Copyright (c) 2015 Toan Lai. All rights reserved.
//

#import "Figure.h"

@interface Figure()

@end

@implementation Figure

-(instancetype)initWithName:(NSString*)name andAge:(int)age andSex:(BOOL)sex{
    if (self == [super init]) {
        self.name = name;
        self.age = age;
        self.sex = sex;
    }
    return self;
}

@end
