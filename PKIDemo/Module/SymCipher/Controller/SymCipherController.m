//
//  SymCipherController.m
//  PKIDemo
//
//  Created by ezfen on 16/4/18.
//  Copyright © 2016年 ezfen. All rights reserved.
//

#import "SymCipherController.h"

@interface SymCipherController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *cipherFuncTableView;
@property (strong, nonatomic) NSArray *funcArray;
@end

@implementation SymCipherController

- (NSArray *)funcArray {
    if (!_funcArray) {
        _funcArray = @[@"DES",@"AES",@"RC4"];
    }
    return _funcArray;
}

- (void)viewDidLoad {
    self.cipherFuncTableView.dataSource = self;
    self.cipherFuncTableView.delegate = self;
}

- (void)prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender {
    
}

# pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.funcArray.count;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Func"];
    NSString *funcName = self.funcArray[indexPath.row];
    cell.textLabel.text = funcName;
    return cell;
}
@end
