import 'package:json_annotation/json_annotation.dart';

enum AppStatusType {
  @JsonValue('APPLICANT_NOT_FOUND')
  notFound,
  @JsonValue('toSubmit')
  submit,
  @JsonValue('toReview')
  review,
  @JsonValue('performing')
  performing,
  @JsonValue('accepted')
  accepted,
  @JsonValue('rejected')
  rejected,
  @JsonValue('counterproposal')
  counterProposed,
}

extension AppStatusTypeX on AppStatusType {
  bool isEnabledTap(int position) {
    switch (this) {
      case AppStatusType.notFound:
      case AppStatusType.submit:
        return position == 0;
      case AppStatusType.review:
        return position == 1;
      case AppStatusType.performing:
      case AppStatusType.accepted:
      case AppStatusType.rejected:
      case AppStatusType.counterProposed:
        return position == 2;
    }
  }
}
