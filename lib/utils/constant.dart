




  import 'dart:math';

String randomUber() {
    int n = 1 + Random().nextInt(100);

    return n.toString();
  }

 String sampleimage =  "https://picsum.photos/200/300?random=${randomUber()}";
 const String defaultsample =  "https://picsum.photos/200/300";