#import <Foundation/Foundation.h>
#import "optool-operations.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        if ( argc == 3 ) {
        
            NSArray *arguments = [[NSProcessInfo processInfo] arguments];
            NSString *libraryName = arguments[ 1 ];
            NSString *path = arguments[ 2 ];
            
            NSMutableData *binary = [NSMutableData dataWithContentsOfFile: path];
            
            struct thin_header thin_header = {.offset = 0, .size = sizeof(struct mach_header_64), .header  = *(struct mach_header *)(binary.bytes)};
            
            
            insertLoadEntryIntoBinary(libraryName, binary, thin_header, LC_LOAD_WEAK_DYLIB);
            
            [binary writeToFile: path atomically: YES];
        }
    }
    return 0;
}
