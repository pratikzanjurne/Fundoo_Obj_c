#import "SetReminderTableViewController.h"

@interface SetReminderTableViewController ()
@end

@implementation SetReminderTableViewController
@synthesize doneBtn = _doneBtn;
@synthesize clearBtn = _clearBtn;
@synthesize titles = _titles;
@synthesize subTitles = _subTitles;
@synthesize datePicker = _datePicker;
@synthesize timePicker = _timePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = [[NSArray alloc]initWithObjects:@"Date",@"Time", nil];
    _subTitles = [[NSMutableArray alloc]initWithObjects:@"DD/MM/YYYY",@"HH:MM", nil];
    _doneBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"check"] style:UIBarButtonItemStyleDone target:self action:@selector(onDoneBtnPressed)];
    _clearBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"clear"] style:UIBarButtonItemStyleDone target:self action:@selector(onClearBtnPessed)];
    self.navigationItem.hidesBackButton = YES;
    [self.navigationItem setRightBarButtonItem:_doneBtn];
    [self.navigationItem setLeftBarButtonItem:_clearBtn];
    _datePicker = [[MDDatePickerDialog alloc] init];
    _timePicker = [[MDTimePickerDialog alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)onClearBtnPessed{
    [self.navigationController popViewControllerAnimated:true];
}
-(void)onDoneBtnPressed{
    if (self.setReminderDelegate && ![[_subTitles objectAtIndex:0]  isEqual: @"DD/MM/YYYY"] && ![[_subTitles objectAtIndex:1]  isEqual: @"HH:MM"]) {
        [self.setReminderDelegate setReminderData:[_subTitles objectAtIndex:0] time:[_subTitles objectAtIndex:1]];
    }
    [self.navigationController popViewControllerAnimated:true];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetReminderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setReminderCell" forIndexPath:indexPath];
    [cell.titleLabel setText:[_titles objectAtIndex:indexPath.row]];
    [cell.SubTitleLabel setText:[_subTitles objectAtIndex:indexPath.row]];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            _datePicker.delegate = self;
            [_datePicker show];
            break;
        case 1:
            _timePicker.delegate = self;
            [_timePicker show];
            break;
            
    }

}
-(void)datePickerDialogDidSelectDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMM d,yyyy"];
    NSString *dateString = [formatter stringFromDate:date];
    [_subTitles insertObject:dateString atIndex:0];
    [self.tableView reloadData];

    
}
-(void)timePickerDialog:(MDTimePickerDialog *)timePickerDialog didSelectHour:(NSInteger)hour andMinute:(NSInteger)minute{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *timeString = [NSString stringWithFormat:@"%ld:%ld",(long)hour,(long)minute];
    NSDate *date = [formatter dateFromString:timeString];
    [formatter setDateFormat:@"h:mm a"];
    NSString *time = [formatter stringFromDate:date];
    [_subTitles insertObject:time atIndex:1];
    [self.tableView reloadData];

}
@end

