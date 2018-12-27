#import <Foundation/Foundation.h>
#import "DashboardCollectionViewPresenterService.h"
#import "Protocols.h"

@interface DashboardCollectionViewPresenter : NSObject
@property (strong,nonatomic) id<DashboardCollectionViewDelegate> delegate;
@property (strong,nonatomic) DashboardCollectionViewPresenterService* presenterService;
- (instancetype)initWithObjects:(id<DashboardCollectionViewDelegate>)delegate;
-(void)fetchNotes:(void(^)(NSMutableArray *))completion;
@end
