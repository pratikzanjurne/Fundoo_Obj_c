#import <Foundation/Foundation.h>



@interface CDNoteModel : NSObject
{
    BOOL is_deleted;
    BOOL is_remindered;
    BOOL is_pinned;
    BOOL is_archived;
    NSString *note;
    NSString *reminder_date;
    NSString *note_title;
    NSString *edited_date;
    NSString *color;
    NSString *created_date;
    NSString *user_id;
}

@property(nonatomic, retain) NSString *note;
@property(nonatomic, retain) NSString *reminder_date;
@property(nonatomic, retain) NSString *note_title;
@property(nonatomic, retain) NSString *edited_date;
@property(nonatomic, retain) NSString *color;
@property(nonatomic, retain) NSString *created_date;
@property(nonatomic, retain) NSString *user_id;
@property(nonatomic,readwrite) BOOL is_deleted;
@property(nonatomic,readwrite) BOOL is_remindered;
@property BOOL is_pinned;
@property BOOL is_archived;
@end
