#import "DashboardViewController.h"


@interface DashboardViewController ()
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sideMenuConstraints;
@property (strong, nonatomic) IBOutlet UIView *containerView;
@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialiseView];
    self.isSlideMenuVisible = NO;

}
-(void)initialiseView{    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedOnView)];
//    [self.containerView addGestureRecognizer:tapGesture];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showSideMenuBtnTapped) name:@"ShowSideMenu" object:nil];
}
-(void)tappedOnView{
    if (_isSlideMenuVisible) {
        [self showSideMenuBtnTapped];
    }else{
    }
}
-(void)showSideMenuBtnTapped{
    if (self.isSlideMenuVisible) {
        self.isSlideMenuVisible = NO;
        [self.sideMenuConstraints setConstant:200];
        [self.navigationController setNavigationBarHidden:NO     animated:YES];
    }else{
        self.isSlideMenuVisible = YES;
        [self.sideMenuConstraints setConstant:-200];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    [UIView animateWithDuration:0.8 animations:^{
        [self.view layoutIfNeeded];
    }];
}
@end
