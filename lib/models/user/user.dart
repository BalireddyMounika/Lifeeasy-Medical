class User {
  int uid;
  bool isSpeaking;

  User(this.uid, this.isSpeaking);

  @override
  String toString() {
    return 'User{uid: $uid, isSpeaking: $isSpeaking}';
  }

}
const APP_ID = "5e02efd03ba84594937104d0d79a0eec";
