part of 'sheep_list_page.dart';

class _SheepListController extends ScreenController {
  _SheepListController(super.state);

  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Filter states
  ESheepStatus? selectedStatus;
  ESheepStage? selectedStage;
  ESheepSurveyStatus? selectedSurveyStatus;

  @override
  @protected
  void onInit() {
    // Initial load of sheep list
    BlocProvider.of<_SheepBloc>(context).add(_LoadSheepEvent());

    // Pagination listener
    scrollController.addListener(_onScroll);
  }

  @override
  @protected
  void onDispose() {
    searchController.dispose();
    scrollController.dispose();
  }

  void _onScroll() {
    if (scrollController.position.atEdge &&
        scrollController.position.pixels != 0) {
      // Trigger load more when scrolled to bottom
      BlocProvider.of<_SheepBloc>(context).add(_LoadMoreSheepEvent(
        query: searchController.text,
        status: selectedStatus,
        stage: selectedStage,
        surveyStatus: selectedSurveyStatus,
      ));
    }
  }

  void applyFilters() {
    BlocProvider.of<_SheepBloc>(context).add(
      _SearchSheepEvent(
        query: searchController.text,
        status: selectedStatus,
        stage: selectedStage,
        surveyStatus: selectedSurveyStatus,
      ),
    );
  }

  void onSelectStatus(ESheepStatus? newValue) {
    updateUI(() => selectedStatus = newValue);
  }

  void onSelectStage(ESheepStage? newValue) {
    updateUI(() => selectedStage = newValue);
  }

  void onSelectSurveyStatus(ESheepSurveyStatus? newSurveyStatus) {
    updateUI(() => selectedSurveyStatus = newSurveyStatus);
  }

  void onResetStatusFilter() {
    updateUI(() => selectedStatus = null);
    applyFilters();
  }

  void onResetStageFilter() {
    updateUI(() => selectedStage = null);
    applyFilters();
  }

  void onResetSurveyStatusFilter() {
    updateUI(() => selectedSurveyStatus = null);
    applyFilters();
  }
}
