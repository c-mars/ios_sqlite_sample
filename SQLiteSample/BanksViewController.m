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
#import "../DetailsViewController.h"

@interface BanksViewController ()

@end

@implementation BanksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _a=[Db instance].failedBankInfos;
    self.title=@"Failed Banks";
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
    cell.detailTextLabel.text=info.city;
    
    return cell;
}

FailedBankInfo* info;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController* c=[UIAlertController alertControllerWithTitle:@"Alert" message:[NSString stringWithFormat:@"Clicked %ld", indexPath.row] preferredStyle:UIAlertControllerStyleAlert];
    [c addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* a){
        info = [_a objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"details" sender:nil];
    }]];
    [self presentViewController:c animated:YES completion:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"details"]){
        DetailsViewController* c = [segue destinationViewController];
        c.name = info.name;
    }
}

@end
