import 'package:familychat/features/chat/controller/chat_controller.dart';
import 'package:familychat/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;

  // final bool isGroupChat;

  const BottomChatField({
    Key? key,
    required this.recieverUserId,
    // required this.isGroupChat,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();

  // FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isRecording = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // _soundRecorder = FlutterSoundRecorder();
    openAudio();
  }

  void openAudio() async {
    // final status = await Permission.microphone.request();
    // if (status != PermissionStatus.granted) {
    //   throw RecordingPermissionException('Mic permission not allowed!');
    // }
    // await _soundRecorder!.openRecorder();
    // isRecorderInit = true;
  }

  void sendTextMessage() async {
    if (isShowSendButton) {
      ref.read(chatControllerProvider).sendMessage(
            context,
            _messageController.text.trim(),
            widget.recieverUserId,
            false,
          );
      setState(() {
        isShowSendButton = false;
        _messageController.clear();
      });
    } else {
      // var tempDir = await getTemporaryDirectory();
      // var path = '${tempDir.path}/flutter_sound.aac';
      // if (!isRecorderInit) {
      //   return;
      // }
      // if (isRecording) {
      //   await _soundRecorder!.stopRecorder();
      //   sendFileMessage(File(path), MessageEnum.audio);
      // } else {
      //   await _soundRecorder!.startRecorder(
      //     toFile: path,
      //   );
      // }
      //
      // setState(() {
      //   isRecording = !isRecording;
      // });
    }
  }

  // void sendFileMessage(
  //     File file,
  //     MessageEnum messageEnum,
  //     ) {
  //   ref.read(chatControllerProvider).sendFileMessage(
  //     context,
  //     file,
  //     widget.recieverUserId,
  //     messageEnum,
  //     widget.isGroupChat,
  //   );
  // }

  void selectImage() async {
    // File? image = await pickImageFromGallery(context);
    // if (image != null) {
    //   sendFileMessage(image, MessageEnum.image);
    // }
  }

  void selectVideo() async {
    // File? video = await pickVideoFromGallery(context);
    // if (video != null) {
    //   sendFileMessage(video, MessageEnum.video);
    // }
  }

  void selectGIF() async {
    // final gif = await pickGIF(context);
    // if (gif != null) {
    //   ref.read(chatControllerProvider).sendGIFMessage(
    //     context,
    //     gif.url,
    //     widget.recieverUserId,
    //     widget.isGroupChat,
    //   );
    // }
  }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();

  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    // _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    // final messageReply = ref.watch(messageReplyProvider);
    // final isShowMessageReply = messageReply != null;

    var size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.06, vertical: size.height * 0.018),
      decoration: const BoxDecoration(color: AppColors.darkBackground),
      child: Column(
        children: [
          // isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.mobileChatBoxColor,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        constraints: const BoxConstraints(),
                        iconSize: size.width * 0.06,
                        onPressed: toggleEmojiKeyboardContainer,
                        icon: const Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.grey,
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          focusNode: focusNode,
                          controller: _messageController,
                          onChanged: (val) {
                            if (_messageController.text.isNotEmpty) {
                              ref.read(chatControllerProvider).activateTyping(widget.recieverUserId);
                              setState(() {
                                isShowSendButton = true;
                              });
                            } else {
                              setState(() {
                                isShowSendButton = false;
                              });
                            }
                          },
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Colors.white54,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.mobileChatBoxColor,
                            hintText: 'Type a message!',
                            hintStyle: const TextStyle(color: Colors.white60),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(top: 10, right: 5, bottom: 10, left: 0),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: selectVideo,
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        icon: Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                          size: size.width * 0.06,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 5,
                  right: 2,
                  left: 2,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: GestureDetector(
                    onTap: sendTextMessage,
                    child: Icon(
                      isShowSendButton
                          ? Icons.send
                          : isRecording
                              ? Icons.close
                              : Icons.mic,
                      color: AppColors.darkBackground,
                    ),
                  ),
                ),
              ),
            ],
          ),
          isShowEmojiContainer ? SizedBox(height: 310, child: Container()) : const SizedBox(),
        ],
      ),
    );
  }
}
