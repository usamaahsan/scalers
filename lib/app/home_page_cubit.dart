import 'package:flutter_bloc/flutter_bloc.dart';

enum BottomNavItem { jobs, resume, settings }

class HomePageCubit extends Cubit<BottomNavItem> {
  HomePageCubit() : super(BottomNavItem.jobs); // Default item

  void selectItem(BottomNavItem item) {
    emit(item); 
  }
}
