#import "DashboardCollectionViewPresenterService.h"

@implementation DashboardCollectionViewPresenterService
-(void)fetchNotes:(void(^)(NSMutableArray *))completion{
//    [[CoreDataDBManager sharedInstance]fetchNotes:^(NSMutableArray *notes) {
//        completion(notes);
//    }];
    [[APIDBManager sharedInstance]getNotes:^(NSMutableArray *notes) {
        completion(notes);
    }];
}
@end
