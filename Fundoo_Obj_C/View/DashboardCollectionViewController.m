#import "DashboardCollectionViewController.h"
#import "NoteCollectionViewCell.h"
#import "TakeNoteViewController.h"

@interface DashboardCollectionViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *noteCollectionView;
@property (strong, nonatomic) IBOutlet UIButton *takeNewNoteBtn;

@end

@implementation DashboardCollectionViewController
@synthesize presenter = _presenter;
@synthesize notes = _notes;
@synthesize isListView = _isListView;
- (void)viewDidLoad {
    [super viewDidLoad];
    _presenter = [[DashboardCollectionViewPresenter alloc]initWithObjects:self];
    [self initialiseView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:true];
    _presenter = [[DashboardCollectionViewPresenter alloc]initWithObjects:self];
    [_presenter fetchNotes:^(NSMutableArray *notes) {
        _notes = notes;
        [self.noteCollectionView reloadData];
    }];
}
-(void)initialiseView{
    self.noteCollectionView.delegate = self;
    self.noteCollectionView.dataSource = self;
    [_presenter fetchNotes:^(NSMutableArray *notes) {
        _notes = notes;
        [self.noteCollectionView reloadData];
    }];
    [self.navigationItem setTitle:@"Notes"];
    UIBarButtonItem *showOptionBtn = [[UIBarButtonItem alloc]initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(showSideMenuBtnTapped)];
    self.changeViewBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"list_view"] style:UIBarButtonItemStyleDone target:self action:@selector(onChangeViewTapped)];
    [showOptionBtn setTitle:@"Option"];
    [showOptionBtn setImage:[UIImage imageNamed:@"side_menu"] ];
    [self.takeNewNoteBtn addTarget:self action:@selector(onTakeNoteBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setLeftBarButtonItem:showOptionBtn];
    [self.navigationItem setRightBarButtonItem:self.changeViewBtn];
    UINib *cell = [UINib nibWithNibName:@"NoteCollectionViewCell" bundle:nil];
    [_noteCollectionView registerNib:cell forCellWithReuseIdentifier:@"NoteCollectionViewCell"];
    UILongPressGestureRecognizer *longPressureGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongGesture:)];
    [_noteCollectionView addGestureRecognizer:longPressureGesture];
}
-(void)onTakeNoteBtnPressed{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TakeNoteViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TakeNoteViewController"];
    [self.navigationController pushViewController:vc animated:true];
}
-(void)showSideMenuBtnTapped{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowSideMenu" object:nil];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NoteCollectionViewCell *cell = [self.noteCollectionView dequeueReusableCellWithReuseIdentifier:@"NoteCollectionViewCell" forIndexPath:indexPath];
    [cell setData:_notes[indexPath.row]];
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _notes.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    TakeNoteViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"TakeNoteViewController"];
    vc.note = _notes[indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}
-(void)onChangeViewTapped{
    [self.noteCollectionView setCollectionViewLayout:self.collectionViewLayout animated:true];
    _isListView = _isListView ? false:true;
    [self.changeViewBtn setImage:_isListView ? [UIImage imageNamed:@"list_view"]:[UIImage imageNamed:@"grid_view"] ];
    [self.noteCollectionView reloadData];
}
-(UICollectionViewFlowLayout*)collectionViewLayout{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setItemSize:CGSizeMake(_isListView ? 360:200, 150)];
    return layout;
}
-(void)handleLongGesture:(UILongPressGestureRecognizer*)gesture{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            if ([_noteCollectionView indexPathForItemAtPoint:[gesture locationInView:_noteCollectionView]]) {
                NSIndexPath *selectedIndexPath = [_noteCollectionView indexPathForItemAtPoint:[gesture locationInView:_noteCollectionView]];
                [_noteCollectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
                UICollectionViewCell *cell = [_noteCollectionView cellForItemAtIndexPath:selectedIndexPath];
                [cell.layer setBorderColor:UIColor.grayColor.CGColor];
                [cell.layer setBorderWidth:3.0];
                [_noteCollectionView setAllowsMultipleSelection:true];
                if (self.isMultipleSelectionActive) {
                    
                }else{
                }
                self.isMultipleSelectionActive = true;
                [_noteCollectionView selectItemAtIndexPath:selectedIndexPath animated:true scrollPosition:UICollectionViewScrollPositionCenteredVertically];
            }
            break;
        default:
            break;
    }
    
}
@end
//@objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
//    switch(gesture.state) {
//
//        case .began:
//            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else {
//                break
//            }
//            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
//            let cell = collectionView.cellForItem(at: selectedIndexPath)
//            cell?.layer.borderColor = UIColor.gray.cgColor
//            cell?.layer.borderWidth = 3.0
//            collectionView.allowsMultipleSelection = true
//            if isMultipleSelectionActive{
//
//            }else{
//                NavigationHelper.setNavigationItem(target: self, delegate: self, option: self.activeView, completion: { (navigationItem) in
//                    if let navigationItems = navigationItem.leftBarButtonItems{
//                        navigationItems[1].title = "\(self.selectedNotes.count)"
//                    }
//                    self.navigationBar.pushItem(navigationItem, animated: false)
//                })
//            }
//            self.isMultipleSelectionActive = true
//            self.view.backgroundColor = UIColor(hexString: Constant.Color.colourReminderText)
//            self.navigationBar.barTintColor = UIColor.white
//            collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .centeredVertically)
//        case .changed:
//            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
//        case .ended:
//            collectionView.endInteractiveMovement()
//            self.collectionView.reloadData()
//        default:
//            collectionView.cancelInteractiveMovement()
//    }
//}
//}

