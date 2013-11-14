//
//  ZQNewsListViewController.m
//  ZQNews
//
//  Created by john fg on 13-11-3.
//  Copyright (c) 2013年 john fg. All rights reserved.
//

#import "ZQNewsListViewController.h"
#import "ZQNewsContentViewController.h"
#import "AFNetworking.h"


#define kNumberOfNewsLoadEachTime 15

@interface ZQNewsListViewController ()<UITableViewDataSource>//协议提供数据源
//@property (weak, nonatomic) IBOutlet UITableView *newsList;
@property (strong, nonatomic) NSArray *newsArray;
@property (strong, nonatomic) AFJSONRequestOperation *newsRequestOperation;
@property (strong, nonatomic) NSOperationQueue *operationQueue;

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
    self.category = @"最新";
    [self loadNewsTitle];
}

- (void)loadNewsTitle
{
    if (self.category && !self.newsRequestOperation)
    {
        NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self.category, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));//把“最新”转换为可用的编码
        NSString *urlString = [NSString stringWithFormat:@"http://news.ziqiang.net/api/article/?n=%i&s=%@&p=%i",kNumberOfNewsLoadEachTime,encodedString,([self.newsArray count]+1)/kNumberOfNewsLoadEachTime+1];
        NSURL *url = [NSURL URLWithString:urlString];//用urlString建立一个NSURL对象
        NSURLRequest *request = [NSURLRequest requestWithURL:url];//用URL建立URLRequest
        
        self.newsRequestOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)//此处用默认
        {
            self.newsArray = [self.newsArray arrayByAddingObjectsFromArray:(NSArray *)JSON];//注意把id的JSON用NSArray表示
            [self.tableView reloadData];
        }
                                                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
        {
            NSLog(@"%@",error);
        }];
        [self.operationQueue addOperation:self.newsRequestOperation];
    }
}

- (NSArray *)newsArray
{
    if (!self.newsArray)
    {
        self.newsArray = [NSMutableArray new];
    }
    return self.newsArray;
}

- (NSOperationQueue *)operationQueue
{
    if (!self.operationQueue)
    {
        self.operationQueue = [NSOperationQueue new];
    }
    return self.operationQueue;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"textNews";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *pieceOfNews = self.news[indexPath.row];
    cell.textLabel.text = pieceOfNews[@"title"];
    cell.detailTextLabel.text = pieceOfNews[@"updated"];
    //cell.imageView.image = self.newsImages[pieceOfNews[@"id"]];
    
    return cell;
}

#pragma mark - Table view dalegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (self.tableView.contentOffset.y>=self.tableView.contentSize.height-self.tableView.bounds.size.height-self.tableView.contentInset.bottom) {
        [self loadNewsTitle];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    //ZQDetailNewsViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"detailNews"];
    //viewController.sourceDict = (NSDictionary *)self.news[indexPath.row];
    //[self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - utilis

- (NSArray *)news
{
    if (!_newsArray) {
        _newsArray = @[];
    }
    return _newsArray;
}







//-(void)setSourceDict:(NSDictionary *)sourceDict
//{
//    _sourceDict = sourceDict;
//    
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Mainstoryboard" bundle:nil];
//    //ZQNewsContentViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"detailNews"];
//}




@end






















