


class Asset {

  static String n1 = 'assets/images/boarding/n1.png'; 
  static String n2 = 'assets/images/boarding/n2.png'; 
  static String n3 = 'assets/images/boarding/n3.png'; 
  static String n4 = 'assets/images/boarding/n4.png'; 
  static String n5 = 'assets/images/boarding/n5.png'; 

  static String boardingImagePath(String image) {
    return 'assets/images/boarding/$image';
  }
  static String lottiePath(String image) {
    return 'assets/images/lottie/$image';
  }
  static String imagePath(String image) {
    return 'assets/images/$image';
  }
}