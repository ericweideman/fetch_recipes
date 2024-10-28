//
//  README.md
//  Fetch_Recipes
//
//  Created by Eric Weideman on 10/25/24.
//

### Steps to Run the App

After downloading the app from github, unzip the project and double click on the "Fetch_Recipes.xcodeproj" file. After it is loaded, run the project. Assuming xcode and simulator are up to date, the project should run on the simulator. No other downloads, packages, or dependencies are required.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I spent the most time on the image caching feature because it was the most interesting thing to me and the thing that I thought might be the most differentiating aspect of this assignment. I am really pleased with the way that it turned out. I am especially pleased with how the image is loaded via the AsyncImage code and the user has a clean experience. Only then, after a little conversion, is the image passed to a background thread for the work of saving to disk. Alternatively, I could have loaded the image as a UIImage directly which would have allowed for a more direct path to disk but opting for AsycnImage, in my opinion, gave me the best bang for the buck for my time by letting me leverage the 'phase' captured variable to display conditional placeholder images easily.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent a little more than the 5-6 hrs listed in the recommendation document. I probably spent ~10 hours overall. I wandered down a couple experimental/educational paths for my own benefit while I explored some alternative ways to do things that added time to the project that I would not spend in many professional scenarios.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

There are several options to display this information that I considered including a smaller list item display with a thumbnail icon for the food, a 2 column LazyVGrid and finally the list view that I ended up with. I decided that the most important info for the user to see was the large photo becuase photos are what 'sell' food. I decided against the two column LazyVGrid because, even thought the photo would be bigger, I felt it would end up hiding a high percentage of the food "name" which I deamed as the second most valuable piece of information.

### Weakest Part of the Project: What do you think is the weakest part of your project?

The UI is a little bland in my opinion. I would have liked to add a little color and some of the of the nuanced details that make an app feel more polished. I think a mask to blur the top and bottom of the list would have been a nice touch but, in the end, I chose to spend my time on other elements of the assignment. That being said, I generally prefer clean user interfaces. If you look at apps with big engineering teams behind them (Instagram, Pinterest, etc), many of them have simple layouts. In those instances, its the nuanced details, rather than high profile animations/transitons and complex UIs that provide the high end feel.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

I did not use any external libraries or dependancies. I generally default to using built in options rather than 3rd party frameworks unless there is significant value added by them. In my experience, it can save time in the beginning but can introduce unexpected behavior that is difficult to troubleshoot down the line. It can also leave you at the mercy of the 3rd party documentation and their future maintence of the code. Ultimately, I did not see anything here that warrented the introduction of 3rd party code.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

I made the assumption that image file names will include a UUID. If they do not, app will still work as anticipated but any images missing a UUID will not be cached. I added logging to document when an image is written to disk and when an image is retrieved from disk that helped confirm the image caching was working correctly. I also added a welcome sheet that will only be displayed the first time a user logs in. I didn't attempt to address any light/dark mode or landscape views options. App supports iOS 16 and later and is documented in the app general settings. Lastly, I understand that List comes off the shelf with a title and search features but I wanted to create my own to demonstrate some handle on conditional elements, transitions etc. 

