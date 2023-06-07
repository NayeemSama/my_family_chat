import 'dart:convert';

/// senderId : null
/// category : null
/// collapseKey : null
/// contentAvailable : false
/// data : {"fromUser":"nayeem","sound":"ringtone.mp3","type":"videoCall"}
/// from : "1070052475297"
/// messageId : "0:1686136293307257%399d14f6f9fd7ecd"
/// messageType : null
/// mutableContent : false
/// notification : {}
/// sentTime : "1686136293296"
/// threadId : null
/// ttl : "2419200"

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    dynamic senderId,
    dynamic category,
    dynamic collapseKey,
    bool? contentAvailable,
    Data? data,
    String? from,
    String? messageId,
    dynamic messageType,
    bool? mutableContent,
    dynamic notification,
    String? sentTime,
    dynamic threadId,
    String? ttl,
  }) {
    _senderId = senderId;
    _category = category;
    _collapseKey = collapseKey;
    _contentAvailable = contentAvailable;
    _data = data;
    _from = from;
    _messageId = messageId;
    _messageType = messageType;
    _mutableContent = mutableContent;
    _notification = notification;
    _sentTime = sentTime;
    _threadId = threadId;
    _ttl = ttl;
  }

  NotificationModel.fromJson(dynamic json) {
    _senderId = json['senderId'];
    _category = json['category'];
    _collapseKey = json['collapseKey'];
    _contentAvailable = json['contentAvailable'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _from = json['from'];
    _messageId = json['messageId'];
    _messageType = json['messageType'];
    _mutableContent = json['mutableContent'];
    _notification = json['notification'];
    _sentTime = json['sentTime'];
    _threadId = json['threadId'];
    _ttl = json['ttl'];
  }

  dynamic _senderId;
  dynamic _category;
  dynamic _collapseKey;
  bool? _contentAvailable;
  Data? _data;
  String? _from;
  String? _messageId;
  dynamic _messageType;
  bool? _mutableContent;
  dynamic _notification;
  String? _sentTime;
  dynamic _threadId;
  String? _ttl;

  NotificationModel copyWith({
    dynamic senderId,
    dynamic category,
    dynamic collapseKey,
    bool? contentAvailable,
    Data? data,
    String? from,
    String? messageId,
    dynamic messageType,
    bool? mutableContent,
    dynamic notification,
    String? sentTime,
    dynamic threadId,
    String? ttl,
  }) =>
      NotificationModel(
        senderId: senderId ?? _senderId,
        category: category ?? _category,
        collapseKey: collapseKey ?? _collapseKey,
        contentAvailable: contentAvailable ?? _contentAvailable,
        data: data ?? _data,
        from: from ?? _from,
        messageId: messageId ?? _messageId,
        messageType: messageType ?? _messageType,
        mutableContent: mutableContent ?? _mutableContent,
        notification: notification ?? _notification,
        sentTime: sentTime ?? _sentTime,
        threadId: threadId ?? _threadId,
        ttl: ttl ?? _ttl,
      );

  dynamic get senderId => _senderId;

  dynamic get category => _category;

  dynamic get collapseKey => _collapseKey;

  bool? get contentAvailable => _contentAvailable;

  Data? get data => _data;

  String? get from => _from;

  String? get messageId => _messageId;

  dynamic get messageType => _messageType;

  bool? get mutableContent => _mutableContent;

  dynamic get notification => _notification;

  String? get sentTime => _sentTime;

  dynamic get threadId => _threadId;

  String? get ttl => _ttl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['senderId'] = _senderId;
    map['category'] = _category;
    map['collapseKey'] = _collapseKey;
    map['contentAvailable'] = _contentAvailable;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['from'] = _from;
    map['messageId'] = _messageId;
    map['messageType'] = _messageType;
    map['mutableContent'] = _mutableContent;
    map['notification'] = _notification;
    map['sentTime'] = _sentTime;
    map['threadId'] = _threadId;
    map['ttl'] = _ttl;
    return map;
  }
}

/// fromUser : "nayeem"
/// sound : "ringtone.mp3"
/// type : "videoCall"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? fromUser,
    String? sound,
    String? type,
  }) {
    _fromUser = fromUser;
    _sound = sound;
    _type = type;
  }

  Data.fromJson(dynamic json) {
    _fromUser = json['fromUser'];
    _sound = json['sound'];
    _type = json['type'];
  }

  String? _fromUser;
  String? _sound;
  String? _type;

  Data copyWith({
    String? fromUser,
    String? sound,
    String? type,
  }) =>
      Data(
        fromUser: fromUser ?? _fromUser,
        sound: sound ?? _sound,
        type: type ?? _type,
      );

  String? get fromUser => _fromUser;

  String? get sound => _sound;

  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fromUser'] = _fromUser;
    map['sound'] = _sound;
    map['type'] = _type;
    return map;
  }
}
