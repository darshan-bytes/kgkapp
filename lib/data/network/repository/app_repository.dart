import 'package:kgk/data/network/model/gemstone_strapi_model.dart';
import 'package:kgk/data/network/model/jewelleries_strapi_model.dart';
import 'package:kgk/kgk.dart';
import 'package:http/http.dart' as http;

import '../model/diamonds_strapi_model.dart';

class AppRepository extends ApiService {
  final BuildContext context;

  AppRepository(this.context);

  Future<Either<ErrorResponse, List<Home>>> fetchStrapiHomeData() async {
    try {
      final response = await http.get(Uri.parse(ApiClient.strapiHomeApiUrl));

      if (response.statusCode == 200) {
        final homeStrapiModel = HomeStrapiModel.fromJson(jsonDecode(response.body));
        List<Home> homeStrapiList = homeStrapiModel.data.first.attributes?.home ?? [];
        return Right(homeStrapiList);
      } else {
        return Left(ErrorResponse(
          code: response.statusCode,
          message: response.reasonPhrase ?? 'Unknown error',
        ));
      }
    } catch (e) {
      return Left(ErrorResponse(
        code: 500,
        message: 'An error occurred',
      ));
    }
  }

  Future<Either<ErrorResponse, List<DiamondData>>> fetchStrapiDiamondLandingData() async {
    String populateQuery = await getPopulatedUrl();
    String url = "${EndPoints.diamondPage}?populate[${Attributes.diamondPage}][populate]=$populateQuery&locale=${"en"}";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final diamondsStrapiModel = DiamondsStrapiModel.fromJson(jsonDecode(response.body));
        List<DiamondData> diamondStrapiList = diamondsStrapiModel.data.first.attributes?.diamonds ?? [];
        return Right(diamondStrapiList);
      } else {
        return Left(ErrorResponse(
          code: response.statusCode,
          message: response.reasonPhrase ?? 'Unknown error',
        ));
      }
    } catch (e) {
      return Left(ErrorResponse(
        code: 500,
        message: 'An error occurred',
      ));
    }
  }

  Future<Either<ErrorResponse, List<Gemstone>>> fetchStrapiGemstoneLandingData() async {
    String populateQuery = await getPopulatedUrl();
    String url = "${EndPoints.gemstonePage}?populate[${Attributes.gemstonePage}][populate]=$populateQuery&locale=${"en"}";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final gemstonesStrapiModel = GemstoneStrapiModel.fromJson(jsonDecode(response.body));
        List<Gemstone> gemstoneStrapiList = gemstonesStrapiModel.data.first.attributes?.gemstones ?? [];
        return Right(gemstoneStrapiList);
      } else {
        return Left(ErrorResponse(
          code: response.statusCode,
          message: response.reasonPhrase ?? 'Unknown error',
        ));
      }
    } catch (e) {
      return Left(ErrorResponse(
        code: 500,
        message: 'An error occurred',
      ));
    }
  }

  Future<Either<ErrorResponse, List<Jewellery>>> fetchStrapiJewelleryLandingData() async {
    String populateQuery = await getPopulatedUrl();
    String url = "${EndPoints.jewelleryPage}?populate[${Attributes.jewelleryPage}][populate]=$populateQuery&locale=${"en"}";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jewelleryStrapiModel = JewelleryStrapiModel.fromJson(jsonDecode(response.body));
        List<Jewellery> jewelleryStrapiList = jewelleryStrapiModel.data.first.attributes?.jewelleries ?? [];
        return Right(jewelleryStrapiList);
      } else {
        return Left(ErrorResponse(
          code: response.statusCode,
          message: response.reasonPhrase ?? 'Unknown error',
        ));
      }
    } catch (e) {
      return Left(ErrorResponse(
        code: 500,
        message: 'An error occurred',
      ));
    }
  }
}

const String apiToken =
    '209f75da6d6df7f6e575d7b80779e6ad6fa47720601d5a5f10b3e13616e0c164579ac11c65d0e51d2102db8bdb14d64a0cdc6c922e12c32e73194a7ce816822676c5c8db2da64eb3cda85f23b589b6536c88c937f4e11da29996b3dc216967d61428b25317654d4b061fba344fa0a3970dcfe9df18ee7dba9658ce1cf1a8edc1'; // Replace with your actual API token

String buildPopulateQuery(Map<String, dynamic> components) {
  List<String> populateFields = [];

  void addPopulateField(Map<String, dynamic> component, [String parentPath = '']) {
    String currentPath = parentPath.isNotEmpty ? '$parentPath.' : '';
    component['attributes'].forEach((key, value) {
      if (value['type'] == 'component' || value['type'] == 'dynamiczone') {
        String componentName = value['component'] ?? key;
        String nestedPath = '$currentPath$key';
        populateFields.add(nestedPath);
        if (components.containsKey(componentName)) {
          addPopulateField(components[componentName], nestedPath);
        }
      } else if (value['type'] == 'media') {
        populateFields.add('$currentPath$key');
      }
    });
  }

  components.forEach((componentName, componentValue) {
    addPopulateField(componentValue);
  });

  return populateFields.join(',');
}

Future<String> getPopulatedUrl() async {
  try {
    final response = await http.get(
      Uri.parse(EndPoints.builder),
      headers: {'Authorization': 'Bearer $apiToken'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> temp = json.decode(response.body);

      final Map<String, dynamic> components = {};
      for (var component in temp['data']) {
        components[component['uid']] = component['schema'];
      }

      final String populateQuery = buildPopulateQuery(components);
      return populateQuery;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (error) {
    printWrapped('Error populating query: $error');
    rethrow;
  }
}
