/*
 * JBoss, Home of Professional Open Source.
 * Copyright Red Hat, Inc., and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "AppDelegate.h"
#import <AeroGear.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    AGKeyStoreCryptoConfig *config = [[AGKeyStoreCryptoConfig alloc] init];
    [config setAlias:@"alias"];
    [config setPassword:@"passphrase"];

    id<AGEncryptionService> service = [[AGKeyManager manager] keyService:config];
    
    NSData *dataToEncrypt = [@"password" dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *encryptedData = [service encrypt:dataToEncrypt];
    
    NSData* decryptedData = [service decrypt:encryptedData];

    // should match
    NSString* decryptedString = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
    
    if ([@"password" isEqualToString:decryptedString]) {
        NSLog(@"SUCCESS");
    } else {
        NSLog(@"FAILURE");
    }
    
    return YES;
}

@end
