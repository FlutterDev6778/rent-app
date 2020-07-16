class Validators {
  static final RegExp emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  static final RegExp imageUrlRegExp = RegExp(
    r'(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|gif|png)',
  );

  static final RegExp imageNameRegExp = RegExp(
    r'([/|.|\w|\s|-])*\.(?:jpg|gif|png)',
  );

  static final RegExp simpleTextRegExp = RegExp(
    r'^[a-zA-Z]{1}.+$',
  );

  static bool isValidEmail(String email) {
    return emailRegExp.hasMatch(email);
  }

  static bool isValidImageUrl(String imageUrl) {
    return imageUrlRegExp.hasMatch(imageUrl);
  }

  static bool isEmpty(String string) {
    return (string == '' || string == null) ? false : true;
  }

  static bool isSimpleText(String string) {
    return simpleTextRegExp.hasMatch(string);
  }

  static bool isValidImageName(String imageName) {
    return imageNameRegExp.hasMatch(imageName);
  }

  static final RegExp storageFileName = RegExp(
    r'(%2)|([?])',
  );
}
