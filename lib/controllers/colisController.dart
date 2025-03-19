import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/colis_model.dart';


class ColisController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var colisList = <Data>[].obs;

  // API endpoint
  final String apiUrl = "https://shipr.ggsdrc.com/index.php/api/tbl_colis_prises/get_all";

  // Fetch colis data from API
  Future<void> fetchColisData() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var colisModel = ColisModel.fromJson(jsonData);

        // Update the observable list
        if (colisModel.data != null) {
          colisList.value = colisModel.data!;
        } else {
          Get.snackbar("Error", "No data found.");
        }
      } else {
        Get.snackbar("Error", "Failed to fetch data: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }


  @override
  void onInit() {
    super.onInit();
    fetchColisData(); // Automatically fetch data when controller is initialized
  }
}
