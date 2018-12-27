#import <UIKit/UIKit.h>
#import "SetReminderTableViewCell.h"
#import <MDTimePickerDialog.h>
#import <MDDatePickerDialog.h>
#import "Protocols.h"


@interface SetReminderTableViewController : UITableViewController<MDDatePickerDialogDelegate,MDTimePickerDialogDelegate>
@property (strong,nonatomic) id<SetReminderDelegate> setReminderDelegate;
@property (strong,nonatomic) MDDatePickerDialog *datePicker;
@property (strong,nonatomic) MDTimePickerDialog *timePicker;
@property (strong,nonatomic) UIBarButtonItem* doneBtn;
@property (strong,nonatomic) UIBarButtonItem* clearBtn;
@property (strong,nonatomic) NSArray *titles;
@property (strong,nonatomic) NSMutableArray *subTitles;
@end
