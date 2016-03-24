//
//  ViewController.m
//  SQLiteSample
//
//  Created by Constantine Mars on 3/24/16.
//  Copyright © 2016 Constantine Mars. All rights reserved.
//

#import "BanksViewController.h"
#import "FailedBankInfo.h"
#import "Db.h"

@interface BanksViewController ()

@end

@implementation BanksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _a=[Db db].failedBankInfos;
    self.title=@"Failed Banks";
    
//    for(FailedBankInfo* info in _a){
//        NSLog(@"%@", info.city);
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_a count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* id=@"id";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:id];
    if(cell==NULL) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:id];
    }
    FailedBankInfo* info=[_a objectAtIndex:indexPath.row];
    cell.textLabel.text=info.name;
    cell.textLabel.text=info.city;
    
    return cell;
}

@end
