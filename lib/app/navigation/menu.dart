import 'package:beautiful_destinations/app/home/profile_update.dart';
import 'package:beautiful_destinations/app/navigation/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationMenu extends StatelessWidget {
  static const routeName = '/navigation';

  const NavigationMenu({super.key});

  Future<void> onLogoutPressed(BuildContext context) async {
    context.read<SettingsBloc>().add(const AppLogoutRequested());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('settings'),
        elevation: 0,
        backgroundColor: theme.canvasColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfile()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                        // radius: 80.0,
                        backgroundImage: AssetImage("assets/mock/profile.jpg")),
                    title: Text('profileSettings'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ),
              ),
              const Divider(indent: 24, endIndent: 24),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.translate_rounded),
                  title: Text('languages'),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              const Divider(indent: 24, endIndent: 24),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.notifications_none_rounded),
                  title: Text('notificationSettings'),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              const Divider(indent: 24, endIndent: 24),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.shield_outlined),
                  title: Text('termsAndConditions'),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              const Divider(indent: 24, endIndent: 24),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.lock_outline_rounded),
                  title: Text('privacy'),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              const Divider(indent: 24, endIndent: 24),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Icon(Icons.support_agent_rounded),
                  title: Text('helpCenter'),
                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
              const Divider(indent: 24, endIndent: 24),
              InkWell(
                onTap: () => onLogoutPressed(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Icon(Icons.logout_rounded),
                    title: Text('logout'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded),
                  ),
                ),
              ),
              // const Divider(indent: 24, endIndent: 24),
            ],
          ),
        ),
      ),
    );
  }
}
