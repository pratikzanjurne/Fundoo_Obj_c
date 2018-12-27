//
//#import "CoreDataDBManager.h"
//@implementation CoreDataDBManager
//@synthesize persistentContainer = _persistentContainer;
//+(id)sharedInstance{
//    static CoreDataDBManager *sharedInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[self alloc]init];
//    });
//    return sharedInstance;
//}
//-  (id)init {
//    if (self = [super init]) {
//    }
//    return self;
//}
//-(NSManagedObjectContext *)context{
//    return self.persistentContainer.viewContext;
//}
//#pragma mark - Core Data stack
//
//- (NSPersistentContainer *)persistentContainer {
//    
//    @synchronized (self) {
//        if (_persistentContainer == nil) {
//            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Fundoo_Obj_C"];
//            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
//                if (error != nil) {
//                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//                    abort();
//                }
//            }];
//        }
//    }
//    
//    return _persistentContainer;
//}
//
//#pragma mark - Core Data Saving support
//
//- (void)saveContext {
//    NSManagedObjectContext *context = self.persistentContainer.viewContext;
//    NSError *error = nil;
//    if ([context hasChanges] && ![context save:&error]) {
//        
//        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
//        abort();
//    }
//}
//-(void)saveNote:(CDNoteModel*)note {
//    Note *DBNote = (Note *)[NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:self.context];
//
//    DBNote.color = note.color;
//    DBNote.is_pinned = note.is_pinned;
//    DBNote.is_deleted = note.is_deleted;
//    DBNote.is_archived = note.is_archived;
//    DBNote.is_remindered = note.is_remindered;
//    DBNote.created_date = note.created_date;
//    DBNote.edited_date = note.edited_date;
//    DBNote.note = note.note;
//    DBNote.note_title = note.note_title;
//    DBNote.user_id = note.user_id;
//    DBNote.reminder_date = note.reminder_date;
//    [self saveContext];
//}
//-(void)fetchNotes:(void(^)(NSMutableArray *))completion{
//    NSFetchRequest<Note *> *request = [Note fetchRequest];
//    NSError *error;
//    NSArray *dataArray = [self.context executeFetchRequest:request error:&error];
//    if (error) {
//    }else{
//        int i = 0;
////        NSMutableArray *newNotes = [[NSMutableArray alloc] initWithCapacity:dataArray.count];
//        for (Note *note in dataArray) {
//            CDNoteModel* DBNote = [[CDNoteModel alloc]init];
//            DBNote.created_date = note.created_date;
//            DBNote.edited_date = note.edited_date;
//            DBNote.is_archived = note.is_archived;
//            DBNote.is_deleted = note.is_deleted;
//            DBNote.is_pinned = note.is_pinned;
//            DBNote.is_remindered = note.is_remindered;
//            DBNote.note = note.note;
//            DBNote.note_title = note.note_title;
//            DBNote.reminder_date = note.reminder_date;
//            DBNote.user_id = note.user_id;
//            [newNotes addObject:DBNote];
//            i = i + 1;
//        }
//        completion(newNotes);
//    }
//}
//-(void)deleteAllData:(void(^)(BOOL))completion{
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:self.context];
//    [fetchRequest setEntity:entity];
//    NSError *error;
////    NSArray *items = [self.context executeFetchRequest:fetchRequest error:&error];
//    [self.context deletedObjects];
//}
//-(void)updateNote:(CDNoteModel*)note completion:(void(^)(BOOL))completion{
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:self.context];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user_id like %@",note.user_id];
//    [fetchRequest setPredicate:predicate];
//    [fetchRequest setFetchLimit:1];
//    [fetchRequest setEntity:entity];
//    NSError *error;
//    NSArray *arrResult = [self.context executeFetchRequest:fetchRequest error:&error];
//    if (arrResult.count > 0) {
//        Note *fetchedNote = arrResult[0];
//        fetchedNote.note_title = note.note_title;
//        fetchedNote.note = note.note;
//        fetchedNote.edited_date = note.edited_date;
//        fetchedNote.is_pinned = note.is_pinned;
//        fetchedNote.is_deleted = note.is_deleted;
//        fetchedNote.is_archived = note.is_archived;
//        fetchedNote.is_remindered = note.is_remindered;
//        note.reminder_date = note.reminder_date;
//        completion(true);
//        [self saveContext];
//    }else{
//        completion(false);
//    }
//}
//-(void)deleteNote:(CDNoteModel*)note completion:(void(^)(BOOL))completion{
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:self.context];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user_id like %@",note.user_id];
//    [fetchRequest setPredicate:predicate];
//    [fetchRequest setEntity:entity];
//    NSError *error;
//    NSArray *items = [self.context executeFetchRequest:fetchRequest error:&error];
//    for (NSManagedObject *managedObject in items)
//    {
//        [self.context deleteObject:managedObject];
//        completion(true);
//    }
//}
//@end

