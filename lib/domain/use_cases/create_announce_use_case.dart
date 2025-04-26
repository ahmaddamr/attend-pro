import 'package:attend_pro/data/models/create_announce_model.dart';
import 'package:attend_pro/data/repo/home_repo_implementation.dart';
import 'package:attend_pro/domain/repo/home_repo.dart';

class CreateAnnounceUseCase {
  HomeRepo repo = HomeRepoImplementation();
  Future<CreateAnnounceModel> createannouncement(
          {required String content,
          required String groupId,
          required String subjectId}) async =>
      await repo.createannouncement(
          content: content, groupId: groupId, subjectId: subjectId);
}
