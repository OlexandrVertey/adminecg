import 'package:adminecg/common/firebase_collections/firebase_collections.dart';

class DeleteOrganizationRepo {
  DeleteOrganizationRepo({required this.organizationsCollection});

  final OrganizationsCollection organizationsCollection;

  Future<void> deleteOrganization({
    required String id,
  }) async {
    try {
      await organizationsCollection.collectionReference.doc(id).delete();
    } catch (e) {
      print('---DeleteOrganizationRepo e = ${e}');
    }
  }
}
