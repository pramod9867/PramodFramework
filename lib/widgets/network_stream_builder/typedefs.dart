import 'package:flutter/material.dart';

typedef OnLoadingWidget<T> = Widget Function(T);
typedef OnSuccessWidget<T> = Widget Function(T);
typedef OnFailureWidget<T> = Widget Function(T);
typedef OnCancelledWidget<T> = Widget Function(T);
typedef NetworkWidgetBuilder<T> = Widget Function(T);