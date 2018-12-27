
#import "Note+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Note (CoreDataProperties)

+ (NSFetchRequest<Note *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *created_date;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSString *note_title;
@property (nullable, nonatomic, copy) NSString *color;
@property (nullable, nonatomic, copy) NSString *reminder_date;
@property (nullable, nonatomic, copy) NSString *edited_date;
@property (nonatomic) BOOL is_deleted;
@property (nonatomic) BOOL is_pinned;
@property (nullable, nonatomic, copy) NSString *user_id;
@property (nonatomic) BOOL is_remindered;
@property (nonatomic) BOOL is_archived;

@end

NS_ASSUME_NONNULL_END
