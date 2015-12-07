//
//  Figure.h
//  TechTableView
//
//  Created by TaiND on 12/3/15.
//  Copyright (c) 2015 Toan Lai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Figure : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, assign) int age;
@property(nonatomic, assign) BOOL sex;

-(instancetype)initWithName:(NSString*)name andAge:(int)age andSex:(BOOL)sex;

@end
