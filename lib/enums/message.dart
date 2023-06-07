enum MessageEnum {
  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  audioCall('audioCall'),
  videoCall('videoCall'),
  gif('gif');

  final String name;

  const MessageEnum(this.name);
}

extension ConvertMessage on String {
  MessageEnum toEnum() {
    switch (this) {
      case 'audio':
        return MessageEnum.audio;
      case 'image':
        return MessageEnum.image;
      case 'text':
        return MessageEnum.text;
      case 'gif':
        return MessageEnum.gif;
      case 'video':
        return MessageEnum.video;
      case 'audioCall':
        return MessageEnum.audioCall;
      case 'videoCall':
        return MessageEnum.videoCall;
      default:
        return MessageEnum.text;
    }
  }
}
