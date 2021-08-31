# stacked_notification_cards

A Flutter implementation of iOS style stacked notifications. 

### Features
1. Given notifications can be stacked one upon the other (iOS style)
2. Notifications can be expanded with fan animation.
3. Individual notification card can slide either left or right
4. Individual cards or the entire stack of cards can be dismissed via slide action.
4. It's possible to use multiple `StackedNotificationCards` within a `Column`.

Make sure to wrap `StackedNotificationCards` in `SingleChildScrollView` if using within a  ``Column``.

### Install

In the ``pubspec.yaml`` of your flutter project, add the following dependency:


Add then following import:

``import 'package:stacked_notification_cards/stacked_notification_cards.dart';``


### Getting Started

Example:

```
            StackedNotificationCards(
              shadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 2.0,
                )
              ],
              type: 'Message',
              notifications: [..._listOfNotification],
              cardColor: Color(0xFFF1F1F1),
              padding: 16,
              headerTitle: Text(
                'Notifications',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              headerShowLess: Text(
                'Show less',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              onTapClearAll: () {
                setState(() {
                  _listOfNotification.clear();
                });
              },
              headerClearAllButton: Icon(Icons.close),
              clearAllStacked: Text('Clear All'),
              clear: Text('clear'),
              view: Text('view'),
              onTapClearCallback: (index) {
                print(index);
                setState(() {
                  _listOfNotification.removeAt(index);
                });
              },
              onTapViewCallback: (index) {
                print(index);
              },
            ),

```
### Demo

<img src="https://raw.githubusercontent.com/OakTree-Apps/stacked_notification_cards/main/assets/demo_record.gif"  width="300"/>

### Contributions

Feel free to contribute to this project.

- If you find a bug or want a feature, but don't know how to fix/implement it, please fill an issue.
- If you fixed a bug or implemented a feature, please send a pull request.
