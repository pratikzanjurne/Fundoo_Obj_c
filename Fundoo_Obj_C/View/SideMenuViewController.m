#import "SideMenuViewController.h"
#import "SideMenuTableViewCell.h"

@interface SideMenuViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SideMenuViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialiseView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)initialiseView{
    options = [NSArray arrayWithObjects:@"Notes",@"Remindered",@"Deleted",@"Sign Out", nil];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SideMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    [cell.optionLabel setText:[options objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return options.count;
}

@end
