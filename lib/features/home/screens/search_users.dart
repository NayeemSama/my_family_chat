import 'package:familychat/features/chat/screens/chat_screen.dart';
import 'package:familychat/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchUsers extends SearchDelegate with ChangeNotifier {
  final List<UserModel> users;

  SearchUsers(this.users);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            Navigator.pop(context);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    //Add the search term to the searchBloc.
    //The Bloc will then handle the searching and add the results to the searchResults stream.
    //This is the equivalent of submitting the search term to whatever search service you are using.

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        var result = users[index];
        return result.userName.startsWith(query)
            ? ListTile(
                title: Text(result.userName),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserChatScreen(
                          uid: result.uid,
                          name: result.userName,
                          pic: result.profilePic,
                        ),
                      ));
                },
              )
            : SizedBox();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method is called everytime the search term changes.
    // If you want to add search suggestions as the user enters their search term, this is the place to do that.
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        var result = users[index];
        return result.userName.startsWith(query)
            ? ListTile(
                title: Text(result.userName),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          UserChatScreen(uid: result.uid, name: result.userName, pic: result.profilePic),
                    ),
                  );
                },
              )
            : SizedBox();
      },
    );
  }
}
