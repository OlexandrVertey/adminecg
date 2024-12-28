import 'package:adminecg/common/firebase_collections/firebase_collections.dart';

class SetOrganizationRepo {
  SetOrganizationRepo({required this.organizationsCollection});

  final OrganizationsCollection organizationsCollection;

  Future<void> setOrganization({
    required String id,
    required String name,
    required String premium,
  }) async {
    try {
      print('---SetOrganizationRepo try id = ${id}');
      print('---SetOrganizationRepo try name = ${name}');
      print('---SetOrganizationRepo try premium = ${premium}');
      await organizationsCollection.collectionReference.doc(id).set({
        'id': id,
        'name': name,
        'premium': premium
      });
      print('---SetOrganizationRepo try finish');
    } catch (e) {
      print('---SetOrganizationRepo e = ${e}');
    }
  }
}
