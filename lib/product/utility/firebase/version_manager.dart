//version manager compare client version and server version and return true if client version is less than server version
class VersionManager {
  bool versionProcess(String? clientVersion, String? serverVersion) {
    //if client version or server version is null return true
    if (clientVersion == null || serverVersion == null) {
      return true;
    }
    //client and server version split version and join with empty string
    final clientVersionSplit = clientVersion.split('.').join('');
    final serverVersionSplit = serverVersion.split('.').join('');
    //client and server version parse to int
    final clientVersionNumberInt = int.parse(clientVersionSplit);
    final serverVersionNumberInt = int.parse(serverVersionSplit);
    //if client version is less than server version return true
    if (clientVersionNumberInt < serverVersionNumberInt) {
      return true;
    } else {
      return false;
    }
  }
}
