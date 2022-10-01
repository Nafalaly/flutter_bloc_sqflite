part of 'form_page_bloc.dart';

class FormPage extends StatelessWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FormPageBloc, FormPageState>(
      listenWhen: (previous, current) =>
          previous.actionFormState != current.actionFormState,
      listener: (context, state) {
        if (state.actionFormState is ActionFormComplete) {
          Navigator.pop(context, true);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text('Create Data'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {},
            )
          ],
        ),
        body: ListView(
          children: [formWidget(context), footerAction(context)],
        ),
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
                  context
                      .read<FormPageBloc>()
                      .add(FormPageEventMemoSaveInformation());
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
              return TextField(
                onChanged: (val) => context.read<FormPageBloc>().add(
                    FormPageEventMemoInformationChanged(newInformation: val)),
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'put something in here..'),
              );
            },
          )
        ],
      ),
    );
  }
}
