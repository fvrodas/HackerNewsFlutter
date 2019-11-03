import 'IView.dart';

class IPresenter<T extends IView> {
  void attach(T view) {}
  void dispose() {}
}