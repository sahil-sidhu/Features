import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/premium_user_repo.dart';

class PremiumUserCubit extends Cubit<bool> {
  final PremiumUserRepo premiumRepo;

  PremiumUserCubit(this.premiumRepo) : super(false);

  Future<void> checkSubscription(String userId) async {
    bool isSubscribed = await premiumRepo.checkUserSubscription(userId);
    emit(isSubscribed);
  }
}
