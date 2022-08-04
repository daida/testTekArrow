This App should render template From JSON File.

The Render part is made in UIView draw rect by using UIGraphics methods.

The Interface part is done with SwiftUI.

The App is based on MVVM architecture patern, and use OOP and dependency injection.

- Templates are cached in order to be retrived if there is no internet connection. (if there is internet we always try to fetch new template then fallback
on cached templates.)
- User can long press on template on list or in detail view to share a picture of their template.

Unit test coverage:

- model Parsing
- Drawer (frame generator)
- ViewModels
- Archiver

![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-04 at 10 06 20](https://user-images.githubusercontent.com/2492897/182800292-ef859b6c-211f-4a25-bffe-b7c174b86ea8.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-04 at 10 05 39](https://user-images.githubusercontent.com/2492897/182800314-765bf5dc-496c-4ca8-b160-d7439a29dcbe.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-04 at 10 05 48](https://user-images.githubusercontent.com/2492897/182800433-c5e6b079-77dd-41b7-a936-203311e0d258.png)
![Simulator Screen Shot - iPhone 13 Pro Max - 2022-08-04 at 10 25 18](https://user-images.githubusercontent.com/2492897/182800461-2f87c955-b1be-4f01-8676-66afd79ca883.png)
![IMG_C4EEBB1A524E-1](https://user-images.githubusercontent.com/2492897/182915991-a5763157-6fde-48fc-8c89-3bee2fe3e9ab.jpeg)
![IMG_E09E551988ED-1](https://user-images.githubusercontent.com/2492897/182915997-edc04e3f-56b2-43bf-b4fd-46f1dd6bf9fe.jpeg)
