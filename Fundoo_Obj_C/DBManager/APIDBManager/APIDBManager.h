#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "APINoteModel.h"
@interface APIDBManager : NSObject
+(id)sharedInstance;
@property (nonatomic,copy) NSString *getNotesUrl;
@property (nonatomic,copy) NSString *postNotesUrl;
@property (strong,nonatomic) NSMutableURLRequest *request;

-(void)getNotes:(void(^)(NSMutableArray *))completion;
-(void)saveNote:(APINoteModel*)note completion:(void(^)(BOOL))completion;
-(void)updateNote:(APINoteModel*)note completion:(void(^)(BOOL))completion;
-(void)deleteNote:(APINoteModel*)note completion:(void(^)(BOOL))completion;
@end
