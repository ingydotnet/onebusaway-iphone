//
//  OBAInfoViewController.m
//  org.onebusaway.iphone
//
//  Created by Aaron Brethorst on 9/17/12.
//
//

#import "OBAInfoViewController.h"
#import "OBAContactUsViewController.h"
#import "OBAAgenciesListViewController.h"
#import "OBASettingsViewController.h"
#import "OBACreditsViewController.h"

#define kContactUsRow 4
#define kSettingsRow 0
#define kAgenciesRow 1
#define kCreditsRow 5
#define kPrivacy 6
#define kIssueTracker 3
#define kFeatureRequests 2

@implementation OBAInfoViewController

- (id)init {
    self = [super initWithNibName:@"OBAInfoViewController" bundle:nil];
    if (self) {
        self.title = NSLocalizedString(@"Info", @"");
        self.tabBarItem.image = [UIImage imageNamed:@"info"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    footerView.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:footerView];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headerView;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [TestFlight passCheckpoint:[NSString stringWithFormat:@"View: %@", [self class]]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:19];
    }

    switch (indexPath.row) {
        case kContactUsRow: {
            cell.textLabel.text = NSLocalizedString(@"Contact Us", @"info row contact us");
            break;
        }
        case kSettingsRow: {
            cell.textLabel.text = NSLocalizedString(@"Settings", @"info row settings");
            break;
        }
        case kAgenciesRow: {
            cell.textLabel.text = NSLocalizedString(@"Agencies", @"info row agencies");
            break;
        }
        case kCreditsRow: {
            cell.textLabel.text = NSLocalizedString(@"Credits", @"info row credits");
            break;
        }
        case kFeatureRequests: {
            cell.textLabel.text = NSLocalizedString(@"Suggest/Vote on New Features", @"info row feture requests");
            break;
        }
        case kIssueTracker: {
            cell.textLabel.text = NSLocalizedString(@"Report Issues/Bugs", @"info row issue tracker");
            break;
        }
        case kPrivacy: {
            cell.textLabel.text = NSLocalizedString(@"Privacy Policy", @"info row privacy");
            break;
        }
        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UIViewController *pushMe = nil;

    switch (indexPath.row) {
        case kContactUsRow: {
            pushMe = [[OBAContactUsViewController alloc] init];
            break;
        }
        case kSettingsRow: {
            pushMe = [[OBASettingsViewController alloc] init];
            break;
        }
        case kAgenciesRow: {
            pushMe = [[OBAAgenciesListViewController alloc] init];
            break;
        }
        case kCreditsRow: {
            pushMe = [[OBACreditsViewController alloc] init];
            break;
        }
        case kFeatureRequests: {
            [TestFlight passCheckpoint:@"Clicked Feature Request Link"];
            NSString *url = [NSString stringWithString: NSLocalizedString(@"http://onebusaway.ideascale.com/a/ideafactory.do?id=8715&mode=top&discussionFilter=byids&discussionID=46166",@"didSelectRowAtIndexPath case 1")];
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
            break;
        }
        case kIssueTracker: {
            [TestFlight passCheckpoint:@"Clicked Issue Tracker Link"];
            NSString *url = [NSString stringWithString: NSLocalizedString(@"https://github.com/OneBusAway/onebusaway-iphone/issues",@"didSelectRowAtIndexPath case 2")];
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
            break;
        }
        case kPrivacy: {
            [TestFlight passCheckpoint:@"Clicked Privacy Policy Link"];
            NSString *url = [NSString stringWithString: NSLocalizedString(@"http://onebusaway.org/privacy/",@"didSelectRowAtIndexPath case 3")];
            [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
            break;
        }
        default:
            break;
    }

    [self.navigationController pushViewController:pushMe animated:YES];
}

@end
