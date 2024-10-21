abstract class LayoutStates{}

class LayoutInitialState extends LayoutStates{}

class GetUserDataLoadingState extends LayoutStates{}
class GetUserDataSuccessState extends LayoutStates{}
class FailedToGetUserDataState extends LayoutStates{
  final String message;
  FailedToGetUserDataState({required this.message});
}

class GetUserUpdataDataLoadingState extends LayoutStates{}

class FailedToGetUserUpdataDataState extends LayoutStates{
  final String message;
  FailedToGetUserUpdataDataState({required this.message});
}