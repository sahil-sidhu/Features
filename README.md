# CHAMBAS

A marketplace for matching any type of service provider to a client. Think a directory of all of your local craftsmen/service providers or even general laborers. With radius based searches and easy matching, it's a breeze to find help for whatever you are working on. Whether daily tasks, small weekend projects or even larger projects, find the perfect match to help you accomplish your goal.

## Description

Let people know what your project can do specifically. Provide context and add a link to any reference visitors might be unfamiliar with. A list of Features or a Background subsection can also be added here. If there are alternatives to your project, this is a good place to list differentiating factors.

## Badges

On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.

## Visuals

Depending on what you are making, it can be a good idea to include screenshots or even a video (you'll frequently see GIFs rather than actual videos). Tools like ttygif can help, but check out Asciinema for a more sophisticated method.

## Installation

Within a particular ecosystem, there may be a common way of installing things, such as using Yarn, NuGet, or Homebrew. However, consider the possibility that whoever is reading your README is a novice and would like more guidance. Listing specific steps helps remove ambiguity and gets people to using your project as quickly as possible. If it only runs in a specific context like a particular programming language version or operating system or has dependencies that have to be installed manually, also add a Requirements subsection.

## Usage

Use examples liberally, and show the expected output if you can. It's helpful to have inline the smallest example of usage that you can demonstrate, while providing links to more sophisticated examples if they are too long to reasonably include in the README.

## Support

Tell people where they can go to for help. It can be any combination of an issue tracker, a chat room, an email address, etc.

## Roadmap

If you have ideas for releases in the future, it is a good idea to list them in the README.

## Contributing

State if you are open to contributions and what your requirements are for accepting them.

For people who want to make changes to your project, it's helpful to have some documentation on how to get started. Perhaps there is a script that they should run or some environment variables that they need to set. Make these steps explicit. These instructions could also be useful to your future self.

You can also document commands to lint the code or run tests. These steps help to ensure high code quality and reduce the likelihood that the changes inadvertently break something. Having instructions for running tests is especially helpful if it requires external setup, such as starting a Selenium server for testing in a browser.

## Authors and acknowledgment

Show your appreciation to those who have contributed to the project.

## License

For open source projects, say how it is licensed.

## Project status

If you have run out of energy or time for your project, put a note at the top of the README saying that development has slowed down or stopped completely. Someone may choose to fork your project or volunteer to step in as a maintainer or owner, allowing your project to keep going. You can also make an explicit request for maintainers.

## Tecnologies / Dependencies Used

- GoRouter: Helps map all the routes for the project under a single file. Uses `context.push('/route')` for navigation.
- BLoC method: State management
- Firebase_auth_ui: Built in methods for creating quick screens. (SignUpScreen, ForgotPasswordScreen) They have built in widgets to create a SignUpScreen, and methods that simplify the sign up / log in / email confirmation process.

## Clean architecture approach:

### 1. Data Layer

- Purpose: Responsible for retrieving and storing data from external sources like Firebase.
- Key Responsibilities:
  - Manages data fetching and saving logic.
- Acts as a bridge between the app and external services (e.g., Firebase).

- Example Files:
  - `firebase_feature_repo.dart`: A repository that interacts with Firebase to fetch, update, or delete data.

### 2. Domain Layer

- Purpose: Contains the core business logic and entities, making it independent of external frameworks like Firebase.
- Key Responsibilities:
  - Defines entities (the data structure for your core app logic).
  - Contains repositories (interfaces or abstract classes) that define the data access methods required by the domain layer.
- Example Files:
  - Entities:
    - `feature.dart`: Defines core data models, like ProfileUser, used throughout the app.
  - Repositories:
    - `feature_repo.dart`: An abstract definition of how the domain interacts with the data layer. Actual implementation (e.g., Firebase) is provided in the Data Layer.

### 3. Presentation Layer

- Purpose: Handles the user interface (UI) and interacts with the domain layer through state management.
- Key Responsibilities:
  Displays data to the user.
  Reacts to user interactions and updates the UI accordingly.
- Example Files:
  - Pages:
    - `feature_page.dart`: Represents a specific screen or page in your app.
  - Cubits:
    - `feature_cubit.dart`: Manages the state and acts as the middle layer between the presentation layer and the domain layer. Cubits handle business logic for the UI and call the domain layer to fetch or process data.
  - Components:
    - `feature_component.dart`: Reusable UI widgets or components specific to this page.
