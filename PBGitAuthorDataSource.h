//
//  PBGitAuthorDataSource.h
//  GitX
//
//  Created by Ketan Padegaonkar on 7/1/11.
//  Copyright 2011 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PBGitRepository.h"

@interface PBGitAuthorDataSource : NSObject<NSComboBoxDataSource> {
    __weak PBGitRepository *repository;
    NSMutableArray *authors;
}

@property (readonly) __weak PBGitRepository *repository;
@property (readonly) NSMutableArray *authors;

- (id)initWithRepository:(PBGitRepository *)theRepository;

@end
