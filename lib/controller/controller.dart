import 'package:flutter/cupertino.dart';
import 'package:translate_app/data/model/languages_model.dart';
import 'package:translate_app/data/model/translate_model.dart';
import 'package:translate_app/data/store/store.dart';
import 'package:translate_app/repository/get_info_repository.dart';

class AppController extends ChangeNotifier{
  List<TranslateModel> listOfFavourites=[];
  List<TranslateModel> listOfHistory=[];
  LanguagesModel lang=LanguagesModel();
  bool isChangeTheme=false;
  bool isLoading = true;
  List<String?> languages = [];
  List<String?> codes = [];


  changeTheme(){
    isChangeTheme=!isChangeTheme;
    LocalStore.setTheme(isChangeTheme);
    notifyListeners();
  }

  setTheme(bool theme){
    isChangeTheme=theme;
    notifyListeners();
  }


  getLang() async {
    isLoading = true;
    notifyListeners();

    LanguagesModel? data = await LocalStore.getLanguages();
    LanguagesModel? model;
    if (data != null) {
      model = data;
    } else {
      model = await GetInfo.getLanguages();
      LocalStore.setLanguages(model!);
    }
    model.data?.languages?.forEach((element) {
      languages.add(element.name);
      codes.add(element.code);
    });

    isLoading = false;
    notifyListeners();
  }



  //-------------- Favourites ------------//

  addFavourites(TranslateModel model){
    listOfFavourites.add(model);
    LocalStore.setFavourites(model);
    notifyListeners();
  }
  removeFavourites(int index){
    listOfFavourites.removeAt(index);
    LocalStore.removeFavourites(index);
    notifyListeners();
  }
  removeAllFavourites(){
    listOfFavourites.clear();
    LocalStore.removeAllFavourites();
    notifyListeners();
  }

  //-------------- History ------------//

  addHistory(TranslateModel model){
    listOfHistory.add(model);
    LocalStore.setHistory(model);
    notifyListeners();
  }
  removeHistory(int index){
    listOfHistory.removeAt(index);
    LocalStore.removeHistory(index);
    notifyListeners();
  }
  removeAllHistory(){
    listOfHistory.clear();
    LocalStore.removeAllHistory();
    notifyListeners();
  }

  //-------------- Languages ------------//

  addLanguages(LanguagesModel model){
    lang=model;
    LocalStore.setLanguages(model);
    notifyListeners();
  }
//-------------- All ------------//
  clearAllData(){
    listOfHistory.clear();
    listOfFavourites.clear();
    LocalStore.clearAllData();
    notifyListeners();
  }

}

