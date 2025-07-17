class VersionManager {
  bool versionProcess(String? clientVersion,String? serverVersion) {

    if(clientVersion==null || serverVersion==null){
      return true;
    }

    final clientVersionSplit=clientVersion.split('.').join('');
    final serverVersionSplit=serverVersion.split('.').join('');
    final clientVersionNumberInt=int.parse(clientVersionSplit);
    final serverVersionNumberInt=int.parse(serverVersionSplit);
    if(clientVersionNumberInt<serverVersionNumberInt){
      return true;
    }else{
      return false;
    }
  }
}