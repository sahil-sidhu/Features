import 'package:chambas/app.dart';
import 'package:chambas/config/firebase_options.dart';
import 'package:chambas/config/app_routes.dart';
import 'package:chambas/features/Post/presentation/cubit/post_cubit.dart';
import 'package:chambas/features/Post/data/post_repo_impl.dart';
import 'package:chambas/features/Storage/data/storage_repo_impl.dart';
import 'package:chambas/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:chambas/features/Auth/data/repository/auth_repo_impl.dart';
import 'package:chambas/features/Profile/presentation/cubit/profile_cubit.dart';
import 'package:chambas/features/Profile/data/profile_repo_impl.dart';
import 'package:chambas/features/Matching/presentation/cubit/match_cubit.dart';
import 'package:chambas/features/Matching/data/match_repo_impl.dart';
import 'package:chambas/features/Search/presentation/cubit/search_cubit.dart';
import 'package:chambas/features/Search/data/search_repo_impl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authCubit = AuthCubit(authRepoImpl: AuthRepoImpl());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>.value(value: authCubit),
        BlocProvider<PostCubit>(
          create: (_) => PostCubit(
            postRepo: PostRepoImpl(),
            storageRepo: StorageRepoImpl(),
          )..loadPosts(),
        ),
        BlocProvider<ProfileCubit>(
          create: (_) => ProfileCubit(
            profileRepoInterface: ProfileRepoImpl(),
            storageRepoInterface: StorageRepoImpl(),
            authCubit: authCubit,
          ),
        ),
        BlocProvider<SearchCubit>(
          create: (_) => SearchCubit(searchRepo: SearchRepoImpl()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CHAMBAS',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
