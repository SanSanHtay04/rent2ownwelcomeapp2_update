import 'package:flutter/material.dart';

enum ApplicationFormStatus { submit, review, status }

extension ApplicationFormStatusX on ApplicationFormStatus {
  String getName(BuildContext context) {
    switch (this) {
      case ApplicationFormStatus.submit:
        return  'To Submit'; // context.tr.applicationFormStatusSubmit;
      case ApplicationFormStatus.review:
        return  'To Review'; //context.tr.applicationFormStatusReview;
      case ApplicationFormStatus.status:
        return   'Submit'; //context.tr.applicationFormStatus;
    }
  }
}
