import 'package:appwrite/appwrite.dart';
import 'package:mini_app/constants.dart';
import 'package:mini_app/utils/utils.dart';

import '../models/models.dart';

class AppwriteRepo {
  Future<List<LeaderBoardModel>> getLeaderBoardList() async {
    final db = get.get<Databases>();
    final docList = await db.listDocuments(
      databaseId: kDataBaseId,
      collectionId: kLeaderBoardId,
    );
    return docList.documents
        .map((e) => LeaderBoardModel.fromJson(e.toMap()))
        .toList();
  }
}
