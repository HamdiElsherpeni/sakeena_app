import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakeena_app/features/risk_assessment/data/repositories/risk_assessment_repository.dart';
import 'package:sakeena_app/features/risk_assessment/logic/cubit/risk_assessment_state.dart';

const _stepFields = <int, List<String>>{
  1: ['ageGroup', 'ethnicity', 'bmiCategory'],
  2: ['menarcheAge', 'pregnancyHistory', 'menopauseStatus'],
  3: ['familyHistoryLevel', 'earlyFamilyDiagnosis', 'brcaMutation'],
  4: ['breastDensity', 'biopsyResult', 'radiationHistory'],
};

class RiskAssessmentCubit extends Cubit<RiskAssessmentState> {
  final RiskAssessmentRepository _repository;

  RiskAssessmentCubit(this._repository)
    : super(RiskAssessmentFormState(currentStep: 1, answers: {}));

  static const stepLabels = ['الشخصية', 'الهرمونية', 'العائلية', 'الطبية'];
  static const totalSteps = 4;

  // ── Getters ──────────────────────────────────────────────────────────────

  RiskAssessmentFormState get _form => state as RiskAssessmentFormState;

  int get currentStep =>
      state is RiskAssessmentFormState ? _form.currentStep : 1;

  bool get isCurrentStepComplete {
    if (state is! RiskAssessmentFormState) return false;
    final fields = _stepFields[_form.currentStep] ?? [];
    return _form.isStepComplete(fields);
  }

  int? getAnswer(String fieldName) =>
      state is RiskAssessmentFormState ? _form.answers[fieldName] : null;

  List<String> get currentStepFields => _stepFields[currentStep] ?? [];

  // ── Actions ──────────────────────────────────────────────────────────────

  void selectAnswer(String fieldName, int value) {
    if (state is! RiskAssessmentFormState) return;
    final updatedAnswers = Map<String, int>.from(_form.answers)
      ..[fieldName] = value;
    emit(_form.copyWith(answers: updatedAnswers));
  }

  Future<void> nextStep() async {
    if (state is! RiskAssessmentFormState) return;
    if (!isCurrentStepComplete) return;

    if (_form.currentStep < totalSteps) {
      emit(_form.copyWith(currentStep: _form.currentStep + 1));
    } else {
      await _submitAssessment();
    }
  }

  void previousStep() {
    if (state is! RiskAssessmentFormState) return;
    if (_form.currentStep <= 1) return;
    emit(_form.copyWith(currentStep: _form.currentStep - 1));
  }

  void reset() {
    emit(RiskAssessmentFormState(currentStep: 1, answers: {}));
  }

  // ── Submit ───────────────────────────────────────────────────────────────

  Future<void> _submitAssessment() async {
    final request = _form.buildRequest();
    if (request == null) {
      emit(RiskAssessmentFailure('يرجى الإجابة على جميع الأسئلة'));
      return;
    }

    final savedForm = _form;
    emit(RiskAssessmentLoading());

    final result = await _repository.assess(request);

    result.fold((failure) async {
      emit(RiskAssessmentFailure(failure.errorMessage));
      await Future.delayed(const Duration(seconds: 2));
      if (!isClosed) emit(savedForm);
    }, (response) => emit(RiskAssessmentSuccess(response)));
  }
}
