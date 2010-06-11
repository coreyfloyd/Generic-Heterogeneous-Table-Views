//
//  CreditsViewController.m
//  Thunderbird
//
//  Created by Craig Hockenberry on 5/14/08.
//  Copyright 2008 The Iconfactory. All rights reserved.
//

#import "CreditsViewController.h"

@implementation CreditsViewController

- (void)loadView
{
	CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];

	UIWebView *webView = [[[UIWebView alloc] initWithFrame:applicationFrame] autorelease];
	[webView setDelegate:self];
	
	self.view = webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	NSString *path = [NSString pathWithComponents:[NSArray arrayWithObjects:[[NSBundle mainBundle] resourcePath], @"credits.html", nil]];
	NSURL *baseURL = [[[NSURL alloc] initFileURLWithPath:path] autorelease];
	[(UIWebView *)self.view loadHTMLString:[NSString stringWithContentsOfURL:baseURL] baseURL:baseURL];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
	[super dealloc];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	NSURL *URL = [request URL];
	if (! [[URL scheme] isEqualToString:@"file"])
	{
		[[UIApplication sharedApplication] openURL:[request URL]];
		return NO;
	}
	
	return YES;
}

@end
