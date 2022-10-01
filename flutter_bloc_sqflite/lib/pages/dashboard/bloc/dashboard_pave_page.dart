part of '../../pages.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocListener<DashboardPageBloc, DashboardPageState>(
      listenWhen: (previous, current) =>
          previous.navigateToForm != current.navigateToForm,
      listener: (context, state) {
        if (state.navigateToForm is NavigatorTriggerStatusTriggered) {
          navigatorHandler(
              context: context,
              route: (state.navigateToForm as NavigatorTriggerStatusTriggered)
                  .route);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        floatingActionButton:
            BlocBuilder<DashboardPageBloc, DashboardPageState>(
                builder: (context, state) {
          return FloatingActionButton(
            onPressed: () => context
                .read<DashboardPageBloc>()
                .add(DashboardPageEventNavigateToFormPageCreate()),
            child: const Icon(Icons.add),
          );
        }),
        appBar: AppBar(
          title: const Text('BLOC & Sqflite'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              dataWidget(),
              dataWidget(),
              dataWidget(),
            ],
          ),
        ),
      ),
    ));
  }

  void navigatorHandler({
    required BuildContext context,
    required String route,
  }) {
    late MaterialPageRoute routeTo;
    if (route == 'form_create') {
      routeTo = MaterialPageRoute(builder: (context) => const FormPage());
    }
    Navigator.push(
      context,
      routeTo,
    );
  }

  Widget dataWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: const ListTile(
        leading: Icon(Icons.storage_rounded),
        title: Text('Dummy Data'),
        trailing: Icon(Icons.arrow_circle_right_rounded),
      ),
    );
  }
}
