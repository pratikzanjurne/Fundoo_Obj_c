
#import "Note+CoreDataProperties.h"

@implementation Note (CoreDataProperties)

+ (NSFetchRequest<Note *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Note"];
}

@dynamic created_date;
@dynamic note;
@dynamic note_title;
@dynamic color;
@dynamic reminder_date;
@dynamic edited_date;
@dynamic is_deleted;
@dynamic is_pinned;
@dynamic user_id;
@dynamic is_remindered;
@dynamic is_archived;

@end
