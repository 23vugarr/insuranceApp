import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pasha_insurance/constants/strings/api_consts.dart';
import 'package:pasha_insurance/models/enum/api_schema.dart';
import 'package:pasha_insurance/utils/extensions/api_schema_extension.dart';

class EndpointBuilder {
  EndpointBuilder();

  String _schema = "";
  String _baseUrl = "";
  String _apiIndetifier = "";
  String _apiVersion = "";

  String _endpointBase = "";

  String _endpointParams = "";

  String _savedParams = "";

  void _addBaseParam(String baseParam) {
    _endpointBase += "/$baseParam";
  }

  EndpointBuilder addParam(String param) {
    _endpointParams += "/$param";
    return this;
  }

  EndpointBuilder addPersistentParam(String param) {
    _endpointParams += "/$param";
    return this;
  }

  void _constructBaseEndpoint() {
    if (_schema.isEmpty) {
      setSchema();
    }
    if (_baseUrl.isEmpty) {
      setBaseUrl();
    }
    // if (_apiIndetifier.isEmpty) {
    //   setApiIdentifier();
    // }
    // if (_apiVersion.isEmpty) {
    //   setApiVersion();
    // }

    this
      .._addSchema()
      .._addBaseUrl();
      // .._addApiIdentifier()
      // .._addApiVersion();
  }

  EndpointBuilder setSchema({ApiSchema? schema}) {
    _schema = schema?.getSchema ?? ApiSchema.HTTPS.getSchema;
    return this;
  }

  void _addSchema() {
    _endpointBase = "$_schema://$_endpointBase";
  }

  EndpointBuilder setBaseUrl() {
    // _baseUrl = Platform.isAndroid ? dotenv.env["API_URL_ANDROID"]! : dotenv.env["API_URL"]!;  //? temp
    _baseUrl = Platform.isAndroid ? dotenv.env["API_URL"]! : dotenv.env["API_URL"]!;  //? temp
    return this;
  }

  void _addBaseUrl() {
    _endpointBase += _baseUrl;
  }

  EndpointBuilder setApiIdentifier([String? apiIdentifer]) {
    _apiIndetifier = apiIdentifer ?? ApiConsts.apiIdentifier;
    return this;
  }

  void _addApiIdentifier() {
    _addBaseParam(_apiIndetifier);
  }

  EndpointBuilder setApiVersion([String? version]) {
    _apiVersion = version ?? ApiConsts.version;
    return this;
  }

  void _addApiVersion() {
    _addBaseParam(_apiVersion);
  }

  EndpointBuilder saveCurrentParams() {
    _savedParams += _endpointParams;
    _endpointParams = "";
    return this;
  }

  String build() {
    _constructBaseEndpoint();
    String finalUrl = _endpointBase + _savedParams + _endpointParams;
    _endpointBase = "";
    _endpointParams = "";
    return finalUrl;
  }
}
