import 'package:chambas/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:chambas/features/Auth/presentation/cubit/auth_states.dart';
import 'package:chambas/features/Auth/presentation/pages/auth_page.dart';
import 'package:chambas/features/Home/presentation/components/drawer_tile.dart';
import 'package:chambas/features/Home/presentation/pages/home_page.dart';
import 'package:chambas/features/Home/presentation/pages/welcome_page.dart';
import 'package:chambas/features/Profile/presentation/pages/profile_page.dart';
import 'package:chambas/features/Search/presentation/pages/search_page.dart';
import 'package:chambas/features/Transactions/presentation/transactions_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
            if (state is Authenticated) {
              return buildAuthenticatedDrawer(context);
            } else {
              return buildUnauthenticatedDrawer(context);
            }
          }),
        ),
      ),
    );
  }
}

// authenticated user drawer
Widget buildAuthenticatedDrawer(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Icon(
          Icons.person,
          size: 80,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      Divider(color: Theme.of(context).colorScheme.primary),
      MyDrawerTile(
        title: "HOME",
        icon: Icons.home,
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WelcomePage()));
        },
      ),
      MyDrawerTile(
        title: "POSTS",
        icon: Icons.post_add,
        onTap: () {
          Navigator.of(context).pop();
          Navigator.pushNamed(context, '/posts');
        },
      ),
      MyDrawerTile(
        title: "PROFILE",
        icon: Icons.person,
        onTap: () {
          Navigator.of(context).pop();
          final user = context.read<AuthCubit>().currentUser;
          String? uid = user!.uid;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfilePage(uid: uid)));
        },
      ),
      MyDrawerTile(
        title: "SEARCH",
        icon: Icons.search,
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchPage())),
      ),
      MyDrawerTile(
        title: "TRANSACTIONS",
        icon: Icons.assignment,
        onTap: () {
          Navigator.of(context).pop();
          final user = context.read<AuthCubit>().currentUser;
          String? uid = user!.uid;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TransactionsPage(uid: uid)));
        },
      ),
      const Divider(),
      MyDrawerTile(
        title: "GO TO PREMIUM",
        icon: Icons.workspace_premium,
        onTap: () => Navigator.pushNamed(context, '/premium'),
      ),
      MyDrawerTile(
        title: "BUSINESS ACCOUNT",
        icon: Icons.business,
        onTap: () => Navigator.pushNamed(context, '/business'),
      ),
      const Spacer(),
      MyDrawerTile(
        title: "LOGOUT",
        icon: Icons.logout,
        onTap: () => context.read<AuthCubit>().logout(),
      ),
    ],
  );
}

// unauthenticated user drawer
Widget buildUnauthenticatedDrawer(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Icon(
          Icons.person,
          size: 80,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      Divider(color: Theme.of(context).colorScheme.primary),
      MyDrawerTile(
        title: "HOME",
        icon: Icons.home,
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WelcomePage()));
        },
      ),
      MyDrawerTile(
        title: "POSTS",
        icon: Icons.post_add,
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
      ),
      MyDrawerTile(
        title: "SEARCH",
        icon: Icons.search,
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => SearchPage())),
      ),
      MyDrawerTile(
        title: "LOG IN / REGISTER",
        icon: Icons.settings,
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AuthPage())),
      ),
      const Divider(),
      MyDrawerTile(
        title: "GO TO PREMIUM",
        icon: Icons.workspace_premium,
        onTap: () => Navigator.pushNamed(context, '/premium'),
      ),
      MyDrawerTile(
        title: "BUSINESS ACCOUNT",
        icon: Icons.business,
        onTap: () => Navigator.pushNamed(context, '/business'),
      ),
    ],
  );
}
