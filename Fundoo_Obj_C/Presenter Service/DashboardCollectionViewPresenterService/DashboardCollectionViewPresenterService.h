#import <Foundation/Foundation.h>
#import "CoreDataDBManager.h"
#import "APIDBManager.h"
@interface DashboardCollectionViewPresenterService : NSObject
-(void)fetchNotes:(void(^)(NSMutableArray *))completion;
@end
