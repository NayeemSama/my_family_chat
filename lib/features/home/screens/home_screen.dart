import 'package:familychat/features/auth/controllers/email_controller.dart';
import 'package:familychat/features/home/controllers/home_controller.dart';
import 'package:familychat/features/home/repositories/home_repository.dart';
import 'package:familychat/features/home/screens/search_users.dart';
import 'package:familychat/models/user_model.dart';
import 'package:familychat/utils/colors.dart';
import 'package:familychat/widgets/contacts_list.dart';
import 'package:familychat/widgets/error_screen.dart';
import 'package:familychat/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.appBarColor,
          centerTitle: false,
          title: const Text(
            'WhatsApp',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.grey),
              onPressed: () {
                ref.read(homeControllerProvider).getAllUsers();
                showSearch(context: context, delegate: SearchUsers(allUsers!));
              },
            ),
            PopupMenuButton<int>(
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(Icons.logout),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Logout")
                    ],
                  ),
                ),
              ],
              offset: const Offset(0, 50),
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              color: AppColors.bgBlueGrey,
              elevation: 2,
              onSelected: (value) {
                if (value == 1) {
                  ref.read(homeControllerProvider).logOut(context);
                }
              },
            ),
          ],
          bottom: const TabBar(
            indicatorColor: AppColors.tabColor,
            indicatorWeight: 4,
            labelColor: AppColors.tabColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: ref.watch(chatListProvider).when(
              data: (data) => ContactsList(userList: data!),
              error: (error, stackTrace) => ErrorScreen(error: error.toString()),
              loading: () => const Loader(),
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.tabColor,
          child: const Icon(
            Icons.comment,
            color: Colors.white,
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
