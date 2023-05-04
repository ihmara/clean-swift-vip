# clean-swift-vip
Test project with VIP pattern

View Controller:
- Establishes and manages the display of views.
- Holds references to the interactor and router.
- Forwards actions from views to the interactor (output) and receives presenter actions as input.

Interactor:
- Contains the business logic related to a view.
- Holds a reference to the presenter.
- Executes actions on workers based on input (from the View Controller), triggers events, and passes the output to the presenter.
- Should not directly depend on UIKit framework.

Presenter:
- Holds a weak reference to the view controller, which acts as its output.
- Receives responses from the interactor, marshals them into suitable view models for display, and passes the view models back to the view controller.

Router:
- Extracts navigation logic from the view controller.
- Holds a weak reference to the source (View Controller).

Worker:
- Handles various low-level operations, such as retrieving user data from Core Data, downloading profile photos, enabling user interactions like liking and following, etc.
- Adheres to the Single Responsibility principle (an interactor may contain multiple workers with distinct responsibilities).

Configurator:
- Responsible for configuring the VIP cycle by encapsulating the creation of all necessary instances and assigning them as required.

Model:
- Represents decoupled data abstractions.