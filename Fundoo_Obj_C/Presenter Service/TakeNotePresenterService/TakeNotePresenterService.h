#import <Foundation/Foundation.h>
#import "CoreDataDBManager.h"
#import "CDNoteModel.h"
#import "APINoteModel.h"
#import "APIDBManager.h"

@interface TakeNotePresenterService : NSObject
-(void)saveNote:(APINoteModel*)note;
-(void)updateNote:(APINoteModel*)note completion:(void(^)(BOOL))completion;
-(void)deleteNote:(APINoteModel*)note completion:(void(^)(BOOL))completion;
@end
