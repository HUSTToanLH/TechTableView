//
//  MainTableVC.m
//  TechTableView
//
//  Created by TaiND on 12/3/15.
//  Copyright (c) 2015 Toan Lai. All rights reserved.
//

#import "MainTableVC.h"
#import "Figure.h"

@interface MainTableVC ()

@end

@implementation MainTableVC{
    NSMutableArray *arrayData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    self.title = @"Main";
    
    //set blank for footer of table view when not exist data
    self.tableView.tableFooterView = [UIView new];
    
    //important for multiple selection edditing
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    [self createData];

    [self addBarButton];
}

-(void)createData{
    Figure *figure1 = [[Figure alloc] initWithName:@"Luffy" andAge:17 andSex:1];
    Figure *figure2 = [[Figure alloc] initWithName:@"Zoro" andAge:17 andSex:1];
    Figure *figure3 = [[Figure alloc] initWithName:@"Ussop" andAge:17 andSex:1];
    Figure *figure4 = [[Figure alloc] initWithName:@"Sanji" andAge:17 andSex:1];
    Figure *figure5 = [[Figure alloc] initWithName:@"Nami" andAge:17 andSex:0];
    Figure *figure6 = [[Figure alloc] initWithName:@"Robin" andAge:20 andSex:0];
    Figure *figure7 = [[Figure alloc] initWithName:@"Chopper" andAge:5 andSex:1];
    Figure *figure8 = [[Figure alloc] initWithName:@"Franky" andAge:25 andSex:1];
    Figure *figure9 = [[Figure alloc] initWithName:@"Brook" andAge:40 andSex:1];
    Figure *figure10 = [[Figure alloc] initWithName:@"Jinbei" andAge:41 andSex:1];
    
    arrayData = [NSMutableArray arrayWithArray:@[figure1, figure2, figure3, figure4, figure5, figure6, figure7, figure8, figure9, figure10]];
}

-(void)addBarButton{
    UIBarButtonItem *btnAdd = [[UIBarButtonItem alloc] initWithImage:[[[UIImage imageNamed:@"addButton"] convertToSize:CGSizeMake(24, 24)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onAdd)];
    
    self.navigationItem.rightBarButtonItem = btnAdd;
    
    UIBarButtonItem *btnEdit = [[UIBarButtonItem alloc] initWithImage:[[[UIImage imageNamed:@"editButton"] convertToSize:CGSizeMake(24, 24)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onEdit)];
    
    self.navigationItem.leftBarButtonItem = btnEdit;
}

-(void)onEdit{
    
    //set real color of image for uibarbuttonitem
    //using [UIImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    if (self.tableView.editing) {
        [self.tableView setEditing:false animated:YES];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[[UIImage imageNamed:@"addButton"] convertToSize:CGSizeMake(24, 24)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onAdd)];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[[UIImage imageNamed:@"editButton"] convertToSize:CGSizeMake(24, 24)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onEdit)];
    }else{
        [self.tableView setEditing:true animated:YES];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[[UIImage imageNamed:@"deleteButton"] convertToSize:CGSizeMake(24, 24)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onDelete)];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[[UIImage imageNamed:@"doneButton"] convertToSize:CGSizeMake(24, 24)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onEdit)];
    }
}

-(void)onAdd{
    Figure *figure = [Figure new];
    [arrayData addObject:figure];
    [self.tableView reloadData];
}

-(void)onDelete{
    NSArray *selectedRows;
    selectedRows = self.tableView.indexPathsForSelectedRows;
    if (selectedRows.count > 0) {
        NSMutableIndexSet *itemsToDelete = [NSMutableIndexSet new];
        for (NSIndexPath*selectedIndex in selectedRows) {
            [itemsToDelete addIndex:selectedIndex.row];
        }
        [arrayData removeObjectsAtIndexes:itemsToDelete];
        [self.tableView deleteRowsAtIndexPaths:selectedRows withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
//    cell.accessoryType = UITableViewCellStyleSubtitle;
    
    Figure *figure = [Figure new];
    figure = arrayData[indexPath.row];
    
    cell.textLabel.text = figure.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", figure.age];
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//
//}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //Delete object at index in arrayData
        [arrayData removeObjectAtIndex:indexPath.row];
        
        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }   
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    Figure *figure = [Figure new];
    figure = arrayData[sourceIndexPath.row];
    [arrayData removeObjectAtIndex:sourceIndexPath.row];
    [arrayData insertObject:figure atIndex:destinationIndexPath.row];
}
@end
