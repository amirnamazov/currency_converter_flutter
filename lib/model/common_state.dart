import 'package:flutter/material.dart';

@immutable
abstract class CommonState {}

class LoadingState extends CommonState {}

class ContentState extends CommonState {}

class ErrorState extends CommonState {}

class EmptyState extends CommonState {}

class InternetErrorState extends CommonState {}
