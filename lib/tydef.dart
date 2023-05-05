









import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

typedef FutureEither<T> = Future<Either<String, T>>;
typedef FutureVoid = FutureEither<void>;

typedef onLanguageSelection = void Function(Map<String, String>);

typedef LanguageSelectionCallback = void Function(String languageCode);
typedef languageSpeak = void Function(BuildContext context);
