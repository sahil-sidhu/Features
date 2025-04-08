import 'package:flutter/material.dart';
import 'package:chambas/features/Post/presentation/pages/post_list_page.dart';
import 'package:chambas/features/Premium_user/presentation/pages/premium_payment_page.dart';
import 'package:chambas/features/Premium_user/presentation/pages/premium_plans_page.dart';
import 'package:chambas/features/Business_Account/presentation/pages/business_dashboard_page.dart';
import 'package:chambas/features/Home/presentation/pages/welcome_page.dart';
import 'package:chambas/features/Post/presentation/pages/upload_post_page.dart';
import 'package:chambas/features/Business_Account/presentation/pages/add_team_member_page.dart';
import 'package:chambas/features/Business_Account/presentation/pages/analytics_page.dart';
import 'package:chambas/features/Business_Account/presentation/pages/branded_profile_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const WelcomePage(),
  '/posts': (context) => const PostListPage(),
  '/createpost': (context) => const UploadPostPage(),
  '/premium': (context) => const PremiumPaymentPage(),
  '/premium-dashboard': (context) => const PremiumPlansPage(),
  '/business': (context) => const BusinessDashboardPage(),
  '/addTeam': (context) => const AddTeamPage(),
  '/analytics': (context) => const AnalyticsPage(),
  '/brandedProfile': (context) => const BrandedProfilePage(),
};
