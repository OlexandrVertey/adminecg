import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:adminecg/common/models/organization_model/organization_model.dart';
import 'package:adminecg/common/models/user_model/user_model.dart';

class GetAllOrganizationsRepo {
  GetAllOrganizationsRepo({required this.organizationsCollection});

  final OrganizationsCollection organizationsCollection;

  Future<List<OrganizationModel>> getAllOrganizations() async {
    try {
      final users = await organizationsCollection.collectionReference.get();
      if (users.docs.isNotEmpty) {
        return users.docs.map((e) => OrganizationModel.fromJson(e.data() as Map<String, dynamic>)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("---getAllOrganizations 6 = ${e}");
      return [];
    }
  }
}
