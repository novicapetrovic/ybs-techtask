# YBS Tech Task

## Architecture
I have chosen to use the MVVM-C architecture for this project as it's a widely adopted industry standard for iOS projects and one I have good experience with and one. The two main alternatives would be MVC and VIPER, MVC would lead to a lack of separation of concerns, whereas VIPER would be overkill for a small app like this.

## Networking
I have split the Networking out into it's own service so each part of the app can inject it where it needs to be used. If I had more time I would support a core networking service that accepts generics, making it reusable.

## Coordinators
I've used the coordinator pattern to handle navigation, this increases the seperation of concerns and allows that logic to live in its own class. For this project I've created one MainCoordinator that handles all the different navigation calls as there are only 2. As the number of calls begins to increase you can look to break this up into smaller coordinators for each area of the app similar to how I have done with the Networking. 

## UI: xib vs programmatic
For the purposes of this tech task I've tried to demonstrate my ability to create views both using code and interface builder. I tried to start using interface builder for the detail screen but ran out of time. 

## Testing
To make the networking classes testable I've used a protocol oriented approach so I can use a MockNetworkService in the tests, avoiding making real network calls for testing which can be unreliable. I've also made the accountUid a { get set } property so that I can modify it to a mockAccountUid in the tests. 

## If I had more time I would/As this project grows in complexity, some things I may consider are...

### Tech
- Test the public interface of the viewModels
- Having another look at how to handle the network service in the ybphotocell and ybimageview
- Test the remaining networking classes/methods
- Add UITests
- Make the app more accessible, tagging UI components (both tech and product improvement, tech as it can help for UI tests)
- Extract the component library as a swift package (especially useful if design kit is shared across multiple apps)

### Product
- Paginate the transactions if there was a large number
- Flesh out the details screen
- Add ability to view the owners profile
