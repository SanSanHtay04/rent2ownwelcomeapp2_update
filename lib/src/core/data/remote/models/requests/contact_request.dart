import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_request.freezed.dart';
part 'contact_request.g.dart';

@freezed
class ContactRequest with _$ContactRequest {
  const ContactRequest._();

  const factory ContactRequest({
    required  String displayName,
    required String firstName,
    required String lastName,
    required String phoneNo,
    required String email,
    
  }) = _ContactRequest;

  factory ContactRequest.fromJson(Map<String, dynamic> json) =>
      _$ContactRequestFromJson(json);
}

/*
{
        'displayName': displayName,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNo': phoneNo,
        'email': email
      }
*/