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
      // logo
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Icon(
          Icons.person,
          size: 80,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),

      // divider line
      Divider(
        color: Theme.of(context).colorScheme.primary,
      ),

      // settings tile
      MyDrawerTile(
        title: "HOME",
        icon: Icons.home,
        onTap: () {
          // pop menu drawer
          Navigator.of(context).pop();

          // navigate to the profile page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomePage(),
              ));
        },
      ),
      // home tile
      MyDrawerTile(
          title: "POSTS",
          icon: Icons.post_add,
          onTap: () {
            Navigator.of(context).pop();

            // navigate to the profile page
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          }),

      // profile tile
      MyDrawerTile(
        title: "PROFILE",
        icon: Icons.person,
        onTap: () {
          // pop menu drawer
          Navigator.of(context).pop();

          // get current user's id
          final user = context.read<AuthCubit>().currentUser;
          String? uid = user!.uid;

          // navigate to the profile page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
                  uid: uid,
                ),
              ));
        },
      ),

      // search tile
      MyDrawerTile(
        title: "SEARCH",
        icon: Icons.search,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(),
          ),
        ),
      ),

      // settings tile
      MyDrawerTile(
        title: "TRANSACTIONS",
        icon: Icons.assignment,
        onTap: () {
          // pop menu drawer
          Navigator.of(context).pop();

          // get current user's id
          final user = context.read<AuthCubit>().currentUser;
          String? uid = user!.uid;

          // navigate to the profile page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransactionsPage(
                  uid: uid,
                ),
              ));
        },
      ),

      const Spacer(),

      // logout tile
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
      // logo
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0),
        child: Icon(
          Icons.person,
          size: 80,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),

      // divider line
      Divider(
        color: Theme.of(context).colorScheme.primary,
      ),
      // settings tile
      MyDrawerTile(
        title: "HOME",
        icon: Icons.home,
        onTap: () {
          // pop menu drawer
          Navigator.of(context).pop();

          // navigate to the profile page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomePage(),
              ));
        },
      ),
      // home tile
      MyDrawerTile(
          title: "POSTS",
          icon: Icons.post_add,
          onTap: () {
            Navigator.of(context).pop();

            // navigate to the profile page
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          }),

      // search tile
      MyDrawerTile(
        title: "SEARCH",
        icon: Icons.search,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(),
          ),
        ),
      ),

      // settings tile
      MyDrawerTile(
        title: "LOG IN / REGISTER",
        icon: Icons.settings,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AuthPage(),
          ),
        ),
      ),
    ],
  );
}
