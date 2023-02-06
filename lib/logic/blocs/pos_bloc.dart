import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/logic/events/pos_event.dart';
import 'package:store/logic/services/pos_service.dart';
import 'package:store/logic/states/pos_state.dart';

class PosBloc extends Bloc<PosEvent, PosState?> {
  PosBloc() : super(null) {
    on<SetCommandEvent>(_getArticle);
    on<ShowArticleInCartEvent>(_initCartShow);
    on<SaveCommandEvent>(_saveCommand);
    on<InitCommandEvent>(_initCommand);
    on<FechtDetailsCommandEvent>(_fetchDetailsCommand);
  }

  late final service = PosService();

  _initCartShow(ShowArticleInCartEvent ev, Emitter emit) {
    emit(ShowArticleInCartState());
  }

  _getArticle(SetCommandEvent ev, emit) async {
    var articles = await service.getAllArticles();
    emit(SetCommandState(articles));
  }

  _initCommand(InitCommandEvent ev, emit) async {
    var commandList = await service.getAllCommands();
    emit(InitCommandState(commandList));
  }

  _fetchDetailsCommand(FechtDetailsCommandEvent ev, emit) async {
    var commandDetailsList = await service.getAllDetailsCommands(ev.code);
    print(commandDetailsList);
    emit(FechtDetailsCommandState(commandDetailsList));
  }

  _saveCommand(SaveCommandEvent ev, emit) async {
    final Map commands = ev.commandes;
    await service.saveCommand(commands);
    var commandList = await service.getAllCommands();
    emit(InitCommandState(commandList));
  }
}
