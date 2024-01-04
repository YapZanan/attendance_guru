class GetName {
  Future<String> getName(String emailAddress) async {
    // Simulating an asynchronous operation, replace this with actual async logic
    await Future<void>.delayed(Duration(milliseconds: 700));

    List<String> parts = emailAddress.split('@');
    return parts[0];
  }
}
