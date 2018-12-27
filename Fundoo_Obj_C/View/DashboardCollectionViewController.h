#import <UIKit/UIKit.h>
#import "Protocols.h"
#import "DashboardCollectionViewPresenter.h"
#import "CDNoteModel.h"
#import "APINoteModel.h"
#import "NoteCollectionViewCell.h"

@interface DashboardCollectionViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,DashboardCollectionViewDelegate>
@property (strong,nonatomic) DashboardCollectionViewPresenter* presenter;
@property NSMutableArray *notes;
@property (readwrite) BOOL isListView;
@property (readwrite) BOOL isMultipleSelectionActive;
@property (strong,nonatomic) UIBarButtonItem *changeViewBtn;

@end


