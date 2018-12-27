#import <UIKit/UIKit.h>
#import "CoreDataDBManager.h"
#import "TakeNotePresenter.h"
#import "CDNoteModel.h"
#import "TakeNotePresenterService.h"
#import "Helper.h"
#import "SetReminderTableViewController.h"
#import "APINoteModel.h"
@interface TakeNoteViewController : UIViewController<UITextViewDelegate,TakeNotePresenterDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SetReminderDelegate>
@property (strong,nullable) UIImage* image;
@property (nullable,readwrite) APINoteModel *note;
@property (strong,nullable,nonatomic) TakeNotePresenter*  presenter;
@property (strong,nonatomic) UIBarButtonItem* _Nonnull pinBtn;
@property (strong,nonatomic) UIBarButtonItem* _Nonnull setReminderBtn;
@property (strong,nonatomic) UIBarButtonItem* _Nonnull archiveBtn;
@property (strong,nonatomic) NSMutableArray* _Nullable reminderDataArray;
@property (readwrite) BOOL is_pinned;
@property (readwrite) BOOL is_archived;
@property (readwrite) BOOL is_remindered;
@end
