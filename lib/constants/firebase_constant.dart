





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


// instance
var auth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;
var storage = FirebaseStorage.instance;


//fires store
var touristspots =   firestore.collection('touristspot');
var users =   firestore.collection('users');
