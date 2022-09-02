import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/shop_app/search_model.dart';
import 'package:shop/modules/shop_app/search/cubit/states.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';


class SearchCubit extends Cubit<SearchStates>{

  SearchCubit():super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
  SearchModel? model;
  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH ,
        data:  {
          'text':text,
        },
      token: token,
    ).then((value) {
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
        


  }
}