#import <Foundation/Foundation.h>

@interface APINoteModel : NSObject{
    NSString *title;
    NSString *note;
    BOOL isPinned;
    BOOL isArchive;
    BOOL isDeleted;
    NSString *reminderDate;
    NSString *_id;
    NSString *createDate;
    NSString *editDate;
}

@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *note;
@property (nonatomic,retain) NSString *reminderDate;
@property (nonatomic,retain) NSString *_id;
@property (nonatomic,retain) NSString *createDate;
@property (nonatomic,retain) NSString *editDate;
@property (nonatomic,readwrite) BOOL isPinned;
@property (nonatomic,readwrite) BOOL isArchive;
@property (nonatomic,readwrite) BOOL isDeleted;

@end
