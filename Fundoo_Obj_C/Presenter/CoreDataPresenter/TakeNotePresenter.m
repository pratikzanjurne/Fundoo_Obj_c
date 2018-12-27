#import "TakeNotePresenter.h"

@implementation TakeNotePresenter
@synthesize delegate = _delegate;
@synthesize presenterService = _presenterService;
- (instancetype)initWithObjects:(id<TakeNotePresenterDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _presenterService = [[TakeNotePresenterService alloc]init];
    }
    return self;
}
-(void)saveNote:(APINoteModel*)note{
    [_presenterService saveNote:note];
    
}
-(void)updateView{
    [_delegate updateView];
}
-(void)updateImageView{
    [_delegate updateImageView];
}
-(void)updateNote:(APINoteModel*)note completion:(void(^)(BOOL))completion{
    [_presenterService updateNote:note completion:^(BOOL result) {
        completion(result);
    }];
}
-(void)deleteNote:(APINoteModel*)note completion:(void(^)(BOOL))completion{
    [_presenterService deleteNote:note completion:^(BOOL result) {
        completion(result);
    }];
}
@end
