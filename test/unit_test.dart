// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cleararchitecture/features/cat/domain/usecases/get_all_cats.dart';
import 'package:cleararchitecture/features/cat/presentation/bloc/cats/bloc/cats_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCatRepository extends Mock implements GetAllCats {}

void main() {
  MockCatRepository mockCatRepository;

  setUp(() => mockCatRepository = MockCatRepository());
  test('Cat group', () {
    mockCatRepository = MockCatRepository();
    when(
      () {
        mockCatRepository();
      },
    );
    final bloc = CatsBloc(getAllCats: mockCatRepository);
    bloc.add(GetAllCatsEvent());
    emitsInOrder([CatsInitial(), LoadingCatsState(), isA<LoadedCatsState>()]);
  });
}
