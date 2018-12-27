#import "APIDBManager.h"

@implementation APIDBManager
@synthesize request = _request;
+(id)sharedInstance{
    static APIDBManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}
-  (id)init {
    if (self = [super init]) {
        self.getNotesUrl = @"http://192.168.0.75:4000/api/notes";
        self.postNotesUrl = @"http://192.168.0.75:4000/api/notes";
        _request = [[NSMutableURLRequest alloc]init];
    }
    return self;
}

-(void)getNotes:(void(^)(NSMutableArray *))completion{
    [_request setURL:[NSURL URLWithString:self.getNotesUrl]];
    [_request setHTTPMethod:@"GET"];
    [_request setValue: @"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    [_request setValue: @"application/json" forHTTPHeaderField:@"Accept"];
    [_request setValue:@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1YzFiODkwZjk3NzViNjEyMjA3ZmQ1YjciLCJpYXQiOjE1NDUzMTQ2NTl9.Cjhdzv1maNwDViznECEY8LPene952q97C8qrgoeBA2s" forHTTPHeaderField:@"token"];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[manager dataTaskWithRequest:_request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Succesfully received notes list");
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSMutableArray *notes = [[NSMutableArray alloc]init];
                NSArray *notesData = responseObject[@"data"];
                for (NSDictionary *note in notesData) {
                    APINoteModel* DBNote = [[APINoteModel alloc]init];
                    DBNote._id = [note valueForKey:@"_id"];
                    DBNote.note = [note valueForKey:@"note"];
                    DBNote.title = [note valueForKey:@"title"];
                    DBNote.isDeleted = (BOOL)[note valueForKey:@"isDeleted"];
                    DBNote.isArchive = (BOOL)[note valueForKey:@"isArchive"];
                    DBNote.isPinned = (BOOL)[note valueForKey:@"isPinned"];
                    DBNote.reminderDate = [note valueForKey:@"reminderDate"];
                    DBNote.editDate = [note valueForKey:@"editDate"];
                    DBNote.createDate = [note valueForKey:@"createDate"];
                    [notes addObject:DBNote];
                }
                completion(notes);
            }
        } else {
            
            NSLog(@"Error: %@", error);
            NSLog(@"Response: %@",response);
            NSLog(@"Response Object: %@",responseObject);
            
        }
    }] resume];
    
}


-(void)saveNote:(APINoteModel*)note completion:(void(^)(BOOL))completion{
    NSDictionary *dataDictionary = @{
                                     @"title": [NSString stringWithFormat:@"%@",note.title],
                                     @"note": [NSString stringWithFormat:@"%@",note.note],
                                     @"color":[NSString stringWithFormat:@"%@",note.reminderDate],
                                     @"isArchive":[NSNumber numberWithBool:note.isArchive],
                                     @"isPinned": [NSNumber numberWithBool:note.isPinned],
                                     @"isDeleted": [NSNumber numberWithBool:note.isDeleted],
                                     @"reminderDate":[NSString stringWithFormat:@"%@",note.reminderDate]
                                     };
    NSError *error1;
    NSData * myData = [NSJSONSerialization dataWithJSONObject:dataDictionary options:NSJSONWritingPrettyPrinted error:&error1];
    [_request setURL:[NSURL URLWithString:self.postNotesUrl]];
    [_request setHTTPMethod:@"POST"];
    [_request setValue:@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1YzFiODkwZjk3NzViNjEyMjA3ZmQ1YjciLCJpYXQiOjE1NDUzNzExMTJ9.iaNaYYghEJrXNJ_juexm8xDJUC9sf9jL9JJTSuQaHPI" forHTTPHeaderField:@"token"];
    [_request setHTTPBody:myData];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[manager dataTaskWithRequest:_request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (!error && !error1) {
                NSLog(@"Succesfully saved note.");
            }
            else {
            
                NSLog(@"Error: %@", error);
                NSLog(@"Response: %@",response);
                NSLog(@"Response Object: %@",responseObject);
            
        }
    }] resume];
}
-(void)updateNote:(APINoteModel *)note completion:(void (^)(BOOL))completion{
    NSDictionary *dataDictionary = @{
                                     @"title": [NSString stringWithFormat:@"%@",note.title],
                                     @"note": [NSString stringWithFormat:@"%@",note.note],
                                     @"color":[NSString stringWithFormat:@"%@",note.reminderDate],
                                     @"isArchive":[NSNumber numberWithBool:note.isArchive],
                                     @"isPinned": [NSNumber numberWithBool:note.isPinned],
                                     @"isDeleted": [NSNumber numberWithBool:note.isDeleted],
                                     @"reminderDate":[NSString stringWithFormat:@"%@",note.reminderDate]
                                     };
    NSError *error1;
    NSData * myData = [NSJSONSerialization dataWithJSONObject:dataDictionary options:NSJSONWritingPrettyPrinted error:&error1];
    NSString *url = [NSString stringWithFormat:@"%@/%@",self.postNotesUrl,note._id];
    [_request setURL:[NSURL URLWithString:url]];
    [_request setHTTPMethod:@"PUT"];
    [_request setValue:@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1YzFiODkwZjk3NzViNjEyMjA3ZmQ1YjciLCJpYXQiOjE1NDUzNzExMTJ9.iaNaYYghEJrXNJ_juexm8xDJUC9sf9jL9JJTSuQaHPI" forHTTPHeaderField:@"token"];
    [_request setHTTPBody:myData];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[manager dataTaskWithRequest:_request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error && !error1) {
            NSLog(@"Succesfully Updated note.");
        }
        else {
            
            NSLog(@"Error: %@", error);
            NSLog(@"Response: %@",response);
            NSLog(@"Response Object: %@",responseObject);
            
        }
    }] resume];

    
}
-(void)deleteNote:(APINoteModel *)note completion:(void (^)(BOOL))completion{
    NSString *url = [NSString stringWithFormat:@"%@/%@",self.postNotesUrl,note._id];
    [_request setURL:[NSURL URLWithString:url]];
    [_request setHTTPMethod:@"DELETE"];
    [_request setValue:@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1YzFiODkwZjk3NzViNjEyMjA3ZmQ1YjciLCJpYXQiOjE1NDUzNzExMTJ9.iaNaYYghEJrXNJ_juexm8xDJUC9sf9jL9JJTSuQaHPI" forHTTPHeaderField:@"token"];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[manager dataTaskWithRequest:_request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"Succesfully deleted note.");
        }
        else {
            
            NSLog(@"Error: %@", error);
            NSLog(@"Response: %@",response);
            NSLog(@"Response Object: %@",responseObject);
            
        }
    }] resume];

}
@end
