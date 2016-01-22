# Filtacular
This is a base iOS app that wraps a website.  We are adding features to build out core functionally as well as using the project as a test for various online freelance sites.


## Developer Contribution Notes

1. App support:
  1. iOS Version: 8.0 and greater
  2. Phone Devices: iPhone 4S and greater
  3. Tablet Devices: None
  3. Orientation: Portrait only
2. All development is done via a "Fork and Pull" approach on Github around project Issues.  (See [Understanding the GitHub Flow](https://guides.github.com/introduction/flow/) to learn more)
3. This project uses [OCLint](http://oclint.org/) to ensure a good coding style.  Be sure your code is passing OCLint before submitting a pull request.  Installation and usage instructions are below.
4. Be sure to use descriptive comments on your commits -- including why you used the solution you did.
5. Reference the issue number when you submit your Pull Request. (e.g. "Fixes #7")
6. Use of 3rd party libraries (such as CocoaPods) can be used if they meet the following criteria:
  1. Are 100% open source
  2. Licensed under MIT, BSD, or Apache license
  3. Actively maintained (updated in the last 90 days)
  4. Popular enough to have 12+ stars on Github
  5. No open bugs related to our use of the library


## OCLint

### Installing OCLint on OSX

1. brew tap oclint/formulae
2. brew update
3. brew install oclint

### Using OCLint

At the command line run the following in the root of the project directory and fix any issues that are reported:

1. xcodebuild clean
2. xcodebuild | tee xcodebuild.log
3. oclint-xcodebuild
4, oclint-json-compilation-database
