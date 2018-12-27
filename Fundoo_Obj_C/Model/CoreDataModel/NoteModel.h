
#import <Foundation/Foundation.h>
typedef struct
{
    BOOL is_deleted;
    BOOL is_remindered;
    BOOL is_pinned;
    BOOL is_archived;
    __unsafe_unretained NSString *note;
    __unsafe_unretained NSString *reminder_date;
    __unsafe_unretained NSString *note_title;
    __unsafe_unretained NSString *edited_date;
    __unsafe_unretained NSString *color;
    __unsafe_unretained NSString *created_date;
    __unsafe_unretained NSString *user_id;
}NoteModel;


