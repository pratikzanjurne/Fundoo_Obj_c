#import <Foundation/Foundation.h>
#import "TakeNotePresenterService.h"
#import "Protocols.h"
#import "APINoteModel.h"

@interface TakeNotePresenter : NSObject
@property (weak,nonatomic)id<TakeNotePresenterDelegate> delegate;
@property (strong,nonatomic)TakeNotePresenterService* presenterService;
- (instancetype)initWithObjects:(id<TakeNotePresenterDelegate>)delegate;
-(void)saveNote:(APINoteModel*)note;
-(void)updateView;
-(void)updateImageView;
-(void)updateNote:(APINoteModel*)note completion:(void(^)(BOOL))completion;
-(void)deleteNote:(APINoteModel*)note completion:(void(^)(BOOL))completion;
@end
