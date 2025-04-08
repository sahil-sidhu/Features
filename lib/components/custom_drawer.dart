import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onGoToPremium;
  final VoidCallback onBusinessAccount;
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  const CustomDrawer({
    super.key,
    required this.onGoToPremium,
    required this.onBusinessAccount,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Welcome!',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Login'),
            onTap: onLogin,
          ),
          ListTile(
            leading: const Icon(Icons.app_registration),
            title: const Text('Register'),
            onTap: onRegister,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Go to Premium'),
            onTap: onGoToPremium,
          ),
          ListTile(
            leading: const Icon(Icons.business_center),
            title: const Text('Business Account'),
            onTap: onBusinessAccount,
          ),
        ],
      ),
    );
  }
}
