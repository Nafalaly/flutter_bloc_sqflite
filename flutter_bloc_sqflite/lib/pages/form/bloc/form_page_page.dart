// ignore_for_file: must_be_immutable

part of 'form_page_bloc.dart';

class FormPage extends StatelessWidget {
  FormPage({Key? key}) : super(key: key);
  // ignore: prefer_final_fields
  TextEditingController _textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<FormPageBloc, FormPageState>(
      listenWhen: (previous, current) =>
          previous.actionFormState != current.actionFormState,
      listener: (context, state) {
        print('LISTENER ACTION FORM COMPLETE ${state.actionFormState}');
        if (state.actionFormState is ActionFormComplete) {
          Navigator.pop(context, true);
        }
      },
      child: BlocBuilder<FormPageBloc, FormPageState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: AppBar(
              title: const Text('Create Data'),
              centerTitle: true,
              actions: [
                (state is FormPageEditMode)
                    ? IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => context.read<FormPageBloc>().add(
                            FormPageEventDeleteByActionButton(
                                currentMemo: state.currentMemo)),
                      )
                    : const SizedBox()
              ],
            ),
            body: ListView(
              children: [formWidget(context), footerAction(context)],
            ),
          );
        },
      ),
    );
  }

  Widget footerAction(BuildContext context) {
    return BlocBuilder<FormPageBloc, FormPageState>(
      builder: (_, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 50,
              width: (DeviceScreen.devWidth / 2) - 20,
              child: ElevatedButton(
                onPressed: () {
                  // context.read<LoginPageBloc>().add(LoginAttempt());
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: const Text(
                  'Discard',
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: (DeviceScreen.devWidth / 2) - 20,
              child: ElevatedButton(
                onPressed: () {
                  if (state is FormPageCreateMode) {
                    context
                        .read<FormPageBloc>()
                        .add(FormPageEventMemoSaveInformation());
                  } else {
                    context
                        .read<FormPageBloc>()
                        .add(FormPageEventMemoUpdateButtonAction());
                  }
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(5),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                    backgroundColor: MaterialStateProperty.all(Colors.green)),
                child: const Text(
                  'Save',
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget formWidget(BuildContext context) {
    return Container(
      height: 200,
      width: DeviceScreen.devWidth,
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Memo :',
            style: TextStyle(fontSize: 30),
          ),
          BlocBuilder<FormPageBloc, FormPageState>(
            builder: (_, state) {
              return BlocListener<FormPageBloc, FormPageState>(
                listenWhen: (previous, current) =>
                    _generateFunction(current: current, previous: previous),
                listener: (context, state) {
                  if (state is FormPageEditMode) {
                    print('Listener running?');
                    _setTextFieldToInitialValue(
                        initialValue: (state).currentMemo.memo);
                  }
                },
                child: TextField(
                  controller: _textEditingController,
                  onChanged: (val) => context.read<FormPageBloc>().add(
                      FormPageEventMemoInformationChanged(newInformation: val)),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'put something in here..'),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  bool _generateFunction(
      {required FormPageState previous, required FormPageState current}) {
    print('Generating function run');
    print('previous state$previous');
    print('current state$current');
    bool result = false;
    if (current is FormPageEditMode) {
      return current.initialState;
    } else {
      result = false;
    }
    return result;
  }

  void _setTextFieldToInitialValue({required String initialValue}) {
    _textEditingController = TextEditingController();
    _textEditingController.text = initialValue;
  }
}
