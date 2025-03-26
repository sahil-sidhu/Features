import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/business_repo.dart';
import '../../data/business_account_model.dart';

class BusinessCubit extends Cubit<List<BusinessAccountModel>> {
  final BusinessRepo businessRepo;

  BusinessCubit(this.businessRepo) : super([]);

  Future<void> loadBusinesses() async {
    var businesses = await businessRepo.fetchBusinessAccounts();
    emit(businesses);
  }
}
