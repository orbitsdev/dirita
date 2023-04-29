





  import 'dart:math';

String randomUber() {
    int n = 1 + Random().nextInt(100);

    return n.toString();
  }

 String sampleimage =  "https://picsum.photos/200/300?random=${randomUber()}";
 const String defaultsample =  "https://picsum.photos/200/300";




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

  static const bannerDefault =
      'https://thumbs.dreamstime.com/b/abstract-stained-pattern-rectangle-background-blue-sky-over-fiery-red-orange-color-modern-painting-art-watercolor-effe-texture-123047399.jpg';
  static const avatarDefault =
      'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';
}