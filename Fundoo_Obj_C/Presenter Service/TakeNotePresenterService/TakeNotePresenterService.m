#import "TakeNotePresenterService.h"

@implementation TakeNotePresenterService : NSObject 
-(void)saveNote:(APINoteModel*)note{
    [[APIDBManager sharedInstance]saveNote:note completion:^(BOOL result) {
        
    }];
//    [[CoreDataDBManager sharedInstance]saveNote:note];
}
-(void)updateNote:(APINoteModel*)note completion:(void(^)(BOOL))completion{
//    [[CoreDataDBManager sharedInstance]updateNote:note completion:^(BOOL result) {
//        if (result) {
//            NSLog(@"Hii");
//        }else{
//            NSLog(@"HEllo");
//        }
//    }];
    [[APIDBManager sharedInstance]updateNote:note completion:^(BOOL result) {
        
    }];
}
-(void)deleteNote:(APINoteModel*)note completion:(void(^)(BOOL))completion{
//    [[CoreDataDBManager sharedInstance]deleteNote:note completion:^(BOOL result) {
//        completion(result);
//    }];
    [[APIDBManager sharedInstance]deleteNote:note completion:^(BOOL result) {
        
    }];
}
@end
