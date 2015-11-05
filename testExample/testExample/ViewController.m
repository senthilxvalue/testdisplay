//
//  ViewController.m
//  testExample
//
//  Created by mac on 05/11/15.
//  Copyright (c) 2015 senthil. All rights reserved.
//

#import "ViewController.h"
#import "DisplayteamTableViewCell.h"
#import "ApiHelper.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    NSDictionary *dic;
    NSArray *array;
    AppDelegate *app;
    UIActivityIndicatorView *activityIndicatorView;
    UILabel                 *label;
}
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong,nonatomic) NSMutableArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arr = [[NSMutableArray alloc]init];
    app = [[UIApplication sharedApplication]delegate];
    [self showActivity];
    [ApiHelper getlistteams:@"" Block:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpresponse=(NSHTTPURLResponse *) response;
        if (httpresponse.statusCode==200)
        {
             NSMutableDictionary *returnDict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            
            dic = [returnDict valueForKey:@"fixtures"]; //valueForKey:@"awayTeamName"];
            NSLog(@"Dictionary Data :%@", dic);
            
            // dic = [[returnDict valueForKey:@"fixtures"] valueForKey:@"result"];
           array=[[dic valueForKey:@"result"] valueForKey:@"goalsAwayTeam"];
            
            // NSLog(@"Dictionary Data :%@", [dic valueForKey:@"goalsAwayTeam"]);

            [self.tableview reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideActivity];
                //                    [self.myPicker reloadAllComponents];
            });
            
        }
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//[[SharedObjects sharedInstance]commentsDict]setObject:getListArr forKey:@"getList"]
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return  dic.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"homeCell";
    NSLog(@"indexpath %ld",(long)indexPath.row);
    
    DisplayteamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[DisplayteamTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.hometeamlbl.text = [[dic valueForKey:@"homeTeamName"] objectAtIndex:indexPath.row];
     cell.awayteamlbl.text = [[dic valueForKey:@"awayTeamName"] objectAtIndex:indexPath.row];
     cell.datetimelbl.text = [[dic valueForKey:@"date"] objectAtIndex:indexPath.row];
     cell.statuslbl.text = [[dic valueForKey:@"status"] objectAtIndex:indexPath.row];
    NSLog(@"text %@",[array objectAtIndex:indexPath.row]);
     cell.goallbl.text = [[array objectAtIndex:indexPath.row] stringValue];
    
    return cell;
}

- (void)addActivityIndicator {
    
    CGFloat labelX = 120.0 + 2;
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(labelX + 10.0, 30.0f, self.view.bounds.size.width - (labelX + 2), self.view.frame.size.height)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:12.0f];
    label.numberOfLines = 1;
    label.backgroundColor =  [UIColor clearColor];
    label.textColor = [UIColor blackColor];
    label.text = @"Loading..";
    [self.view addSubview:label];
    
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    activityIndicatorView.backgroundColor = [UIColor lightGrayColor];
    
    activityIndicatorView.frame = CGRectMake(0, 0, 100, 100);
    
    activityIndicatorView.center = self.view.center;
    
    activityIndicatorView.layer.cornerRadius = 10;
    
    activityIndicatorView.layer.opacity = .75;
    
    activityIndicatorView.hidesWhenStopped = YES;
    
    [self.view addSubview:activityIndicatorView];
    
}



- (void)showActivity {
    
    
    
    if (!activityIndicatorView)
        
        [self addActivityIndicator];
    
    [label setHidden:NO];
    activityIndicatorView.hidden = NO;
    
    [activityIndicatorView startAnimating];
    
    self.view.userInteractionEnabled = NO;
    
    activityIndicatorView.center = self.view.center;
    
    [self.view bringSubviewToFront:activityIndicatorView];
    [self.view bringSubviewToFront:label];
    
}

- (void)hideActivity {
    
    if (activityIndicatorView) {
        
        if (activityIndicatorView.isAnimating)
            
            [activityIndicatorView stopAnimating];
        
    }
    
    [label setHidden:YES];
    self.view.userInteractionEnabled = YES;
    
}

@end
