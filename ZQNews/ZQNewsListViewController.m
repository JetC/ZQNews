//
//  ZQNewsListViewController.m
//  ZQNews
//
//  Created by john fg on 13-11-3.
//  Copyright (c) 2013年 john fg. All rights reserved.
//

#import "ZQNewsListViewController.h"

@interface ZQNewsListViewController ()<UITableViewDataSource>//协议提供数据源
@property (weak, nonatomic) IBOutlet UITableView *newsList;
@property (strong, nonatomic) NSMutableArray *newsArray;

@end

@implementation ZQNewsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.newsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel = 
}



@end
