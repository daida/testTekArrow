This App should render templates From JSON File.

The Render part is made in UIView draw rect by using UIGraphics methods.

The Interface part is done with SwiftUI.

The App is based on MVVM architecture patern, and use OOP and dependency injection.

- Templates are cached in order to be retrived if there is no internet connection. (if there is internet we always try to fetch new template then fallback
on cached templates.)
- User can long press on template on list or in detail view to share a picture of their template.

Package Manage SPM

Dependency: Reachability

Unit test coverage:

- model Parsing
- Drawer (frame generator)
- ViewModels
- Archiver


![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-05 at 05 16 14](https://user-images.githubusercontent.com/2492897/182994041-792d16b1-901d-440d-8e8e-908e42365306.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-05 at 05 16 35](https://user-images.githubusercontent.com/2492897/182994065-a2ca9dde-f685-45c0-a2cd-aa5aa3383dc9.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-05 at 05 16 46](https://user-images.githubusercontent.com/2492897/182994078-c9caeb41-9053-41f1-95a0-aee7551dd527.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-05 at 05 17 02](https://user-images.githubusercontent.com/2492897/182994114-66c78771-8f3c-41e4-a59c-6e82346b2528.png)
