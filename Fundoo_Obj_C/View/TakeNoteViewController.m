#import "TakeNoteViewController.h"
#import "NoteView.h"
#import "APIDBManager.h"
@interface TakeNoteViewController ()
@property (strong, nonatomic) IBOutlet NoteView *noteView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *noteViewHeightConstraint;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addImageBtn;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *deleteBtn;

@end

@implementation TakeNoteViewController
@synthesize note = _note;
@synthesize pinBtn = _pinBtn;
@synthesize archiveBtn = _archiveBtn;
@synthesize setReminderBtn = _setReminderBtn;
@synthesize is_archived = _is_archived;
@synthesize is_pinned = _is_pinned;
@synthesize reminderDataArray = _reminderDataArray;
@synthesize is_remindered = _is_remindered;
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    if (_note == nil) {
    }else{
        [self.noteView.noteTextView setText:_note.note];
        [self.noteView.titleTextView setText:_note.title];
        if (_note.isPinned == true) {
            _is_pinned = true;
            [_pinBtn setTintColor:[UIColor blueColor]];
        }else{
            _is_pinned = false;
            [_pinBtn setTintColor:[UIColor grayColor]];
        }
        if (_note.isArchive == true  ) {
            _is_archived = true;
            [_archiveBtn setTintColor:[UIColor blueColor]];
        }else{
            _is_archived = false;
            [_archiveBtn setTintColor:[UIColor grayColor]];
        }
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.presenter = [[TakeNotePresenter alloc]initWithObjects:self];
    [_addImageBtn setTarget:self];
    [_addImageBtn setAction:@selector(onAddImageBtnPressed)];
    [_deleteBtn setTarget:self];
    [_deleteBtn setAction:@selector(onDeleteBtnPressed)];
    _pinBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"pin"] style:UIBarButtonItemStyleDone target:self action:@selector(onPinBtnPressed)];
    _archiveBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"archive"] style:UIBarButtonItemStyleDone target:self action:@selector(onArchiveBtnPressed)];
    _setReminderBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"remind"] style:UIBarButtonItemStyleDone target:self action:@selector(onSetReminderBtnPressed)];
    [_archiveBtn setTintColor:[UIColor grayColor]];
    [_pinBtn setTintColor:[UIColor grayColor]];
    [_setReminderBtn setTintColor:[UIColor grayColor]];
    NSArray *rightBarBtnItems = [[NSArray alloc]initWithObjects:_setReminderBtn,_archiveBtn,_pinBtn, nil];
    [self.navigationItem setRightBarButtonItems:rightBarBtnItems];
    self.noteView.noteTextView.delegate = self;
    self.noteView.titleTextView.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(onBackBtnPressed)];
    self.navigationItem.hidesBackButton = YES;
    _reminderDataArray = [[NSMutableArray alloc]init];
    
    //New Code
    
        //End

}
-(void)textViewDidChange:(UITextView *)textView{
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, CGFLOAT_MAX)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(MAX(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
    if (self.presenter) {
        [self.presenter updateView];
    }
}
-(void)updateView{
    CGFloat height = 60;
    CGFloat titleHeight = self.noteView.titleTextView.frame.size.height;
    CGFloat noteHeight = self.noteView.noteTextView.frame.size.height;
    CGFloat imageViewHeight = self.noteView.imageView.frame.size.height;
    if (titleHeight >= 30) {
        [self.noteView.titleViewHeightConstraint setConstant:titleHeight];
        height = height + titleHeight;
    }else{
        [self.noteView.titleViewHeightConstraint setConstant:30];
        height = height + 30;
    }
    if (noteHeight >= 30) {
        [self.noteView.noteViewHeightConstraint setConstant:noteHeight];
        height = height + noteHeight;
    }else{
        [self.noteView.noteViewHeightConstraint setConstant:30];
        height = height + 30;
    }
    if (self.image != nil){
        height = height + imageViewHeight;
    }else{
        [_noteView.imageViewHConstraints setConstant:0];
    }
    [self.noteViewHeightConstraint setConstant:height];
}
-(void)updateImageView{
    CGFloat imageViewHeight = _noteView.imageViewHConstraints.constant;
    CGFloat height = self.noteViewHeightConstraint.constant;
    if (self.image != nil){
        height = height + imageViewHeight;
    }else{
        [_noteView.imageViewHConstraints setConstant:0];
    }
    [self.noteViewHeightConstraint setConstant:height];
}

-(void)onAddImageBtnPressed{
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:true completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:true completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if (info[UIImagePickerControllerOriginalImage]) {
        self.image = info[UIImagePickerControllerOriginalImage];
        [_noteView.imageView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width/[[Helper sharedInstance]getImageAspectRatio:self.image])];
        [_noteView.imageView setImage:self.image];
        [_noteView.imageViewHConstraints setConstant:_noteView.imageView.frame.size.height];
        [_presenter updateImageView];
        [self dismissViewControllerAnimated:true completion:nil];
    }else{
        NSLog(@"Something went wrong");
    }
}
-(void)onBackBtnPressed{
    if ([[[self.noteView.titleTextView textStorage]string]  isEqual: @""] && [[[self.noteView.noteTextView textStorage]string]  isEqual: @""]) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        APINoteModel *note = [[APINoteModel alloc]init];
//        note.color = @"Black";
        note.createDate = @"today";
        note.editDate = @"today";
        note.isArchive = _is_archived;
        note.isDeleted = false;
        note.isPinned = _is_pinned;
        note.note = [[_noteView.noteTextView textStorage]string];
        note.title = [[_noteView.titleTextView textStorage]string];
        if (_is_remindered) {
            note.reminderDate = [NSString stringWithFormat:@"%@ %@",[_reminderDataArray objectAtIndex:0],[_reminderDataArray objectAtIndex:1]];
            [[Helper sharedInstance]setReminder:note reminderDate:[_reminderDataArray objectAtIndex:0] reminderTime:[_reminderDataArray objectAtIndex:1] completion:^(BOOL result) {
                if (result) {
                    NSLog(@"true");
                }else{
                    NSLog(@"false");
                }
            }];
        }
        if (_note == nil) {
            [_presenter saveNote:note];
        }else{
            note.createDate = _note.createDate;
            note._id = _note._id;
            [_presenter updateNote:note completion:^(BOOL result) {
                if (result) {
                    NSLog(@"Done");
                }else{
                    NSLog(@"not done");
                }
            }];
        }
        [self.navigationController popViewControllerAnimated:true];
    }
}
-(void)onDeleteBtnPressed{
    if (_note == nil) {
        NSLog(@"Please select note");
    }else{
        [_presenter deleteNote:_note completion:^(BOOL result) {
            if (result) {
                NSLog(@"Done");
                [self.navigationController popViewControllerAnimated:true];
 
            }else{
                NSLog(@"Something went Wrong");
            }
        }];
    }
}
-(void)onPinBtnPressed{
    if (_is_pinned) {
        _is_pinned = false;
        [_pinBtn setTintColor:[UIColor grayColor]];
    }else{
        _is_pinned = true;
        [_pinBtn setTintColor:[UIColor blueColor]];
    }
}
-(void)onArchiveBtnPressed{
    if (_is_archived) {
        _is_archived = false;
        [_archiveBtn setTintColor:[UIColor grayColor]];
    }else{
        _is_archived = true;
        [_archiveBtn setTintColor:[UIColor blueColor]];
    }
}
-(void)onSetReminderBtnPressed{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SetReminderTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"SetReminderTblViewController"];
    vc.setReminderDelegate = self;
    [self.navigationController pushViewController:vc animated:true];
}
-(void)setReminderData:(NSString*)date time:(NSString*)time{
    [_reminderDataArray insertObject:date atIndex:0];
    [_reminderDataArray insertObject:time atIndex:1];
    _is_remindered = true;
    [_noteView.reminderViewHeightC setConstant:18];
    [_noteView.reminderTextLabel setText:[NSString stringWithFormat:@"%@ %@",date,time]];
}
-(void)getRequest{

}
@end
