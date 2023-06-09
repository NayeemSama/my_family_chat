import 'package:familychat/features/auth/controllers/email_controller.dart';
import 'package:familychat/features/home/controllers/home_controller.dart';
import 'package:familychat/features/home/screens/search_users.dart';
import 'package:familychat/models/user_model.dart';
import 'package:familychat/utils/colors.dart';
import 'package:familychat/widgets/contacts_list.dart';
import 'package:familychat/widgets/error_screen.dart';
import 'package:familychat/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with WidgetsBindingObserver {
  List<UserModel>? allUsers;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(homeControllerProvider).initNotifications();
      allUsers = await ref.read(homeControllerProvider).getAllUsers();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        ref.read(homeControllerProvider).statusChange(online: false);
        print('AppState -> Paused---------------------------------------------- ❚❚');
        break;
      case AppLifecycleState.detached:
        print('AppState -> Detached---------------------------------------------- 💔');
        ref.read(homeControllerProvider).statusChange(online: false);
        break;
      case AppLifecycleState.resumed:
        print('AppState -> Resumed---------------------------------------------- ▶');
        ref.read(homeControllerProvider).statusChange(online: true);
        break;
      case AppLifecycleState.inactive:
        print('AppState -> Inactive---------------------------------------------- 💤');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.read(homeControllerProvider).getAllChatList();
    ref.read(userDataProvider).whenData((value) => null);
    var size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(size.width, size.height * 0.08 + MediaQuery.of(context).viewPadding.top),
          child: Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            color: const Color(0xff1c2e46),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.03,
                  horizontal: size.width * 0.08,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration:
                            BoxDecoration(color: const Color(0xff304057), borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        )),
                    const Text('Messages',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white)),
                    Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration:
                            BoxDecoration(color: const Color(0xff304057), borderRadius: BorderRadius.circular(8)),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: ref.watch(chatListProvider).when(
              data: (data) => Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35))),
                  child: ContactsList(userList: data!)),
              error: (error, stackTrace) => ErrorScreen(error: error.toString()),
              loading: () => const Loader(),
            ),
        floatingActionButton: Container(
          height: size.height * 0.1,
          width: size.height * 0.1,
          child: FittedBox(
            child: FloatingActionButton(
              backgroundColor: AppColors.darkBackground,
              onPressed: () {},
              child: const Icon(
                Icons.add,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
}
