import 'package:package_info_plus/package_info_plus.dart';

class AppVersionService {
  AppVersionService({this._packageInfo});

  PackageInfo? _packageInfo;

  Future<PackageInfo> load() async {
    return _packageInfo ??= await PackageInfo.fromPlatform();
  }

  Future<String> get version async => (await load()).version;
  Future<String> get buildNumber async => (await load()).buildNumber;
  Future<String> get appName async => (await load()).appName;
  Future<String> get packageName async => (await load()).packageName;
}
