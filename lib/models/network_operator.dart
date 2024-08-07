enum NetworkOperator {
  mpt,
  ooredoo,
  atom,
  mytel,
  other,
}

extension NetworkOperatorX on NetworkOperator {
  String getImgaePath() {
    switch (this) {
      case NetworkOperator.mpt:
        return "assets/operators/mpt.png";
      case NetworkOperator.ooredoo:
        return "assets/operators/mpt.png";
        case NetworkOperator.atom:
        return "assets/operators/mpt.png";
      case NetworkOperator.mytel:
        return "assets/operators/mpt.png";
      default :  
      return  "";
    }
  }
}
