# AssignmentAcharyaPrashantJi
new
Image Grid iOS Application
This iOS application efficiently loads and displays images in a scrollable grid. It implements asynchronous image loading from a specified API endpoint and utilizes caching mechanisms to store images in both memory and disk cache for efficient retrieval.

Overview
The application features a 3-column square image grid where images are center-cropped for optimal display. It loads images lazily, ensuring smooth scrolling even when navigating through a large number of images. The caching mechanism ensures that images are retrieved efficiently, with disk cache utilized when images are missing from memory cache.

API Endpoint
The application fetches image data from the following API endpoint:

Base URL: https://acharyaprashant.org/api/v2/content/
Endpoint Path: misc/media-coverages?limit=100
Image URL Construction
The image URL is constructed using the thumbnail object retrieved from the API response. The formula used for constructing the image URL is as follows:
imageURL = domain + "/" + basePath + "/0/" + key

Implementation Details
Language: Swift
Native Technology: UIKit

Instructions to Run the Code
Clone the repository to your local machine.
Open the Xcode project file.
Build and run the project on an iOS simulator or device.
Enjoy browsing through the image grid!

Evaluation Criteria
Images load lazily.
Image loading cancellation is implemented when quickly scrolling to different pages.
Smooth scrolling experience with no lag.
Both memory and disk cache mechanisms are functional.
Graceful handling of network errors and image loading failures.
