#import "DashboardCollectionViewPresenter.h"

@implementation DashboardCollectionViewPresenter
@synthesize delegate = _delegate;
@synthesize presenterService = _presenterService;

- (instancetype)initWithObjects:(id<DashboardCollectionViewDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _presenterService = [[DashboardCollectionViewPresenterService alloc]init];
    }
    return self;
}

-(void)fetchNotes:(void (^)(NSMutableArray *))completion{
    [_presenterService fetchNotes:^(NSMutableArray *notes) {
        completion(notes);
    }];
}
@end
