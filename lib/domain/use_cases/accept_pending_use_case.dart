import 'package:attend_pro/data/models/pending_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class AcceptPendingUseCase {
  HomeRepo repo = HomeRepoImplementation();
  Future<PendingModel> acceptPending(String groupId,
          {required String sessionDate, required String sessionType}) async =>
      await repo.acceptPending(groupId,
          sessionDate: sessionDate, sessionType: sessionType);
}
