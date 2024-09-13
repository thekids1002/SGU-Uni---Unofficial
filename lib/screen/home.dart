import 'package:flutter/material.dart';
import 'package:sgu_uni/models/auth/user.dart';
import 'package:sgu_uni/utils/shared_preferences_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: currentUser != null
              ? Column(
                  children: [
                    Text('Hello, ${currentUser!.name}'),
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> _loadCurrentUser() async {
    User? user = await SharedPreferencesUtils.getObject(
      'currentUser',
      User.fromJson,
    );
    setState(() {
      currentUser = user;
    });
  }
}
