import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}

class PostRequestFailure extends Failure {
  const PostRequestFailure({required super.message});
}

class GetRequestFailure extends Failure {
  const GetRequestFailure({required super.message});
}
