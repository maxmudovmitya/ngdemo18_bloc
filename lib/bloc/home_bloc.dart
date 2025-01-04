
import 'package:bloc/bloc.dart';

import '../models/random_user_list_res.dart';
import '../services/http_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  List<RandomUser> userList = [];
  int currentPage = 0;

  HomeBloc() : super(HomeInitialState()) {
    on<LoadRandomUserListEvent>(_onLoadRandomUserList);
  }

  Future<void> _onLoadRandomUserList(LoadRandomUserListEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    var response = await Network.GET(Network.API_RANDOM_USER_LIST, Network.paramsRandomUserList(currentPage));
    if (response != null) {
      var randomUserListRes = Network.parseRandomUserList(response);
      emit(HomeRandomUserListState(randomUserListRes.results));
    } else {
      emit(HomeErrorState("Couldn't not fetch random users"));
    }
  }

}