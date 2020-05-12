import 'package:flutter_bloc/flutter_bloc.dart';

enum NumberEvent { addEvent, removeEvent }

class NumberBloc extends Bloc<NumberEvent, int> {
  @override
  int get initialState => 10;

  @override
  Stream<int> mapEventToState(NumberEvent event) async* {
    switch (event) {
      case NumberEvent.addEvent:
        yield state + 5;
        break;
      case NumberEvent.removeEvent:
        yield state - 5;
        break;
    }
  }

  @override
  void onTransition(Transition<NumberEvent, int> transition) {
    print('NumberBloc.onTransition->${transition}');
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('NumberBloc.onError->$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}
