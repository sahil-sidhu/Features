import 'package:chambas/features/Auth/data/repository/auth_repo_impl.dart';
import 'package:chambas/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:chambas/features/Auth/presentation/cubit/auth_states.dart';
import 'package:chambas/features/Auth/presentation/pages/auth_page.dart';
import 'package:chambas/features/Contract/data/contract_repo_impl.dart';
import 'package:chambas/features/Contract/presentation/cubit/contract_cubit.dart';

import 'package:chambas/features/Home/presentation/pages/welcome_page.dart';
import 'package:chambas/features/Matching/data/match_repo_impl.dart';
import 'package:chambas/features/Matching/presentation/cubit/match_cubit.dart';
import 'package:chambas/features/Matching/presentation/cubit/match_states.dart';
import 'package:chambas/features/Post/data/post_repo_impl.dart';
import 'package:chambas/features/Post/presentation/cubit/post_cubit.dart';
import 'package:chambas/features/Profile/data/profile_repo_impl.dart';
import 'package:chambas/features/Profile/presentation/cubit/profile_cubit.dart';
import 'package:chambas/features/Search/data/search_repo_impl.dart';
import 'package:chambas/features/Search/presentation/cubit/search_cubit.dart';
import 'package:chambas/features/Storage/data/storage_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  final authRepoImpl = AuthRepoImpl();

  final profileRepoImpl = ProfileRepoImpl();

  final storageRepoImpl = StorageRepoImpl();

  final postRepoImpl = PostRepoImpl();

  final searchRepoImpl = SearchRepoImpl();

  final matchRepoImpl = MatchRepoImpl();

  final contractImpl = ContractRepoImpl();

  MyApp({super.key}); // Add const here

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // auth cubit
        BlocProvider<AuthCubit>(
          lazy: true,
          create: (context) =>
              AuthCubit(authRepoImpl: authRepoImpl)..checkAuth(),
        ),

        // profile cubit
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(
            profileRepoInterface: profileRepoImpl,
            storageRepoInterface: storageRepoImpl,
            authCubit: BlocProvider.of<AuthCubit>(context),
          ),
        ),

        // Post cubit
        BlocProvider<PostCubit>(
          create: (context) =>
              PostCubit(postRepo: postRepoImpl, storageRepo: storageRepoImpl),
        ),

        // Search cubit
        BlocProvider<SearchCubit>(
          lazy: true,
          create: (context) => SearchCubit(searchRepo: searchRepoImpl),
        ),

        // Match cubit
        BlocProvider<MatchCubit>(
          lazy: true,
          create: (context) => MatchCubit(matchRepo: matchRepoImpl),
        ),

        // Contract cubit
        BlocProvider<ContractCubit>(
          lazy: true,
          create: (context) => ContractCubit(contractRepo: contractImpl),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          buttonTheme: Theme.of(context).buttonTheme.copyWith(
                highlightColor: Colors.deepPurple,
              ),
          primarySwatch: Colors.deepPurple,
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        home: BlocListener<MatchCubit, MatchState>(
          listener: (context, state) {
            if (state is MatchRequested) {
              // show dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("New Match Request"),
                  content: Text("You have a new match request."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Close"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        // Navigate to a match details page
                      },
                      child: Text("View"),
                    ),
                  ],
                ),
              );
            }
          },
          child: WelcomePage(),
        ),
      ),
    );
  }
}
