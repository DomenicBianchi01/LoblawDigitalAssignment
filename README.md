# Loblaw Digital Assignment

- Built with Xcode 11.4 and supports iOS 12 and 13.

- The app supports all orientations except upside down on iPhone and all orientations on iPad

- The `JSONService` class is built to show the usefulness of this class and how it could be easily expanded to accommodate additional features. For example, even though the scope of this assignment only requires GET requests, I have included a `RequestType` enum and a `body` parameter in the `request` function that allows different types of HTTP requests to be made.

- For the scope of this assignment, I have assumed any HTTP response code that is **not** 200 is treated as an error.

- Regarding JSON decoding in `Listing.swift` and `Article.swift`, I could have used 3 structs/classes in order to only use `init(from decoder: Decoder)` in the `Article` class . I have included this code in a seperate branch called `db/decoding`. I decided to use the method that required only two structs/classes (in the `master` branch) simply because the code required to manually implement the decoding is straightforward enough to justify not needed a third struct.

- For the child view (the view that displays the article body and image), I decided to use `UITableView` even though `UIScrollView` may have been the more efficient choice given the scope of the assignment. Since this view contains one image and a body of text, a `UIScrollView` could be used since there is no need for reusable cells or any of the other extra features that comes along with `UITableView`. However, in the interest of keeping the code maintainable and easy to expand on, let's say in the near future we will need to add more content to this screen to the point where there is more content then can be fit on the screen all at once. If I had initially used just a `UIScrollView`, the content that is not visible would still be loaded in memory. By using `UITableView` only the cells that are visible are loaded in memory (which is preferable). Also, using `UITableView` allows us to take advantage of reusable cells (which obviously reduces duplicate code and UI in the storyboard...something that would not be possible with `UIScrollView`)
