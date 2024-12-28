import 'package:adminecg/common/firebase_collections/firebase_collections.dart';
import 'package:adminecg/common/models/organization_model/organization_model.dart';
import 'package:adminecg/common/models/user_model/user_model.dart';

class GetAllOrganizationsRepo {
  GetAllOrganizationsRepo({required this.organizationsCollection});

  final OrganizationsCollection organizationsCollection;

  Future<List<OrganizationModel>> getAllOrganizations() async {
    print("---getAllOrganizations 1");
    try {
      print("---getAllOrganizations 2");
      final users = await organizationsCollection.collectionReference.get();
      print("---getAllOrganizations 3");
      if (users.docs.isNotEmpty) {
        print("---getAllOrganizations 4");
        return users.docs.map((e) => OrganizationModel.fromJson(e.data() as Map<String, dynamic>)).toList();
      } else {
        print("---getAllOrganizations 5");
        return [];
      }
    } catch (e) {
      print("---getAllOrganizations 6 = ${e}");
      return [];
    }
  }
}
