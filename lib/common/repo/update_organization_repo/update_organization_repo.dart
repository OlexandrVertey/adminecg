import 'package:adminecg/common/firebase_collections/firebase_collections.dart';

class UpdateOrganizationRepo {
  UpdateOrganizationRepo({required this.organizationsCollection});

  final OrganizationsCollection organizationsCollection;

  Future<void> updateOrganization({
    required String id,
    required String name,
    required String premium,
  }) async {
    try {
      print('---UpdateOrganizationRepo try id = ${id}');
      await organizationsCollection.collectionReference.doc(id).update({
        'name': name,
        'premium': premium,
      });
    } catch (e) {
      print('---UpdateUserRepo e = ${e}');
    }
  }
}
