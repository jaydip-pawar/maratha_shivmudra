enum Side { left, right }

typedef Either<L, R> = (Side, (L?, R?));

Either<L, R> left<L, R>(L value) => (Side.left, (value, null));

Either<L, R> right<L, R>(R value) => (Side.right, (null, value));

extension EitherExtension<L, R> on (Side, (L?, R?)) {
  void fold(void Function(L) leftFn, void Function(R) rightFn) {
    final (side, values) = this;
    final (leftValue, rightValue) = values;

    switch (side) {
      case Side.left:
        leftFn(leftValue as L);
        break;
      case Side.right:
        rightFn(rightValue as R);
        break;
    }
    // T fold<T>(T Function(L) leftFn, T Function(R) rightFn) {
    //   final (side, values) = this;
    //   final (leftValue, rightValue) = values;
    //
    //   return switch (side) {
    //     Side.left => leftFn(leftValue as L),
    //     Side.right => rightFn(rightValue as R),
    //   };
  }

  bool isLeft() => $1 == Side.left;

  bool isRight() => $1 == Side.right;

  L getLeft() => $2.$1 as L;

  R getRight() => $2.$2 as R;
}

/*Future<Either<String, List<String>>> fetchData() async {
  try {
    // Simulating some data fetching
    List<String> data = ['item1', 'item2', 'item3'];
    return right(data);
  } catch (e) {
    return left(e.toString());
  }
}

Future<void> main() async {
  final result = await fetchData();

  result.fold((error) => 'Error: $error', (data) => 'Success: $data');

  // Alternative usage
  if (result.isLeft()) {
    print('Error occurred: ${result.getLeft()}');
  } else {
    print('Data fetched successfully: ${result.getRight()}');
  }
}*/
