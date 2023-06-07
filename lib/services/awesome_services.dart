import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:familychat/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class AwesomeService {
  ProviderRef? ref;

  static initialize() {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'calling_channel',
          channelKey: 'calling_channel',
          channelName: 'Calling Notification',
          channelDescription: 'Notification channel for calling',
          defaultColor: AppColors.backgroundColor,
          importance: NotificationImportance.Max,
          defaultPrivacy: NotificationPrivacy.Public,
          playSound: true,
          defaultRingtoneType: DefaultRingtoneType.Ringtone,
          ledColor: Colors.green,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(channelGroupKey: 'calling_channel', channelGroupName: 'Call Group'),
      ],
    );
  }

  static setListeners() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
    );

    _checkPermissions();
  }

  static _checkPermissions() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) async {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        await AwesomeNotifications().requestPermissionToSendNotifications(
          channelKey: 'android_calling_key',
          permissions: [
            NotificationPermission.Alert,
            NotificationPermission.Sound,
            NotificationPermission.Vibration,
          ],
        );
      }
    });
  }

  static showNotification({required String channel, required String from, required String type}) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'calling_channel',
        title: 'Incoming call from $from',
        category: NotificationCategory.Call,
        fullScreenIntent: true,
        wakeUpScreen: true,
        actionType: ActionType.KeepOnTop,
        locked: true,
        body: 'Pickup the call  ${type == 'audioCall' ? '📞' : '📹'}',
      ),
      actionButtons: [
        NotificationActionButton(key: 'accept', label: 'Accept', color: Colors.green),
        NotificationActionButton(
            key: 'decline', label: 'Decline', color: Colors.red, actionType: ActionType.SilentBackgroundAction),
      ],
    );
  }

  static void dismissNotifications() {
    AwesomeNotifications().dismissAllNotifications();
  }
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(ReceivedNotification receivedNotification) async {}

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(ReceivedNotification receivedNotification) async {}

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(ReceivedAction receivedAction) async {
    // Your code goes here
    print('Dismissed Action --------------------><');
    print(receivedAction.buttonKeyPressed);
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    print('Button Pressed Action --------------------><');
    print(receivedAction.buttonKeyPressed);
    if (receivedAction.buttonKeyPressed == 'accept') {
    } else if (receivedAction.buttonKeyPressed == 'decline') {}
  }
}
