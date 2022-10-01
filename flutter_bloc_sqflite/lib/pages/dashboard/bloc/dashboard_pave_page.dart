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
            BlocBuilder<DashboardPageBloc, DashboardPageState>(
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => context
                      .read<DashboardPageBloc>()
                      .add(DashboardPageEventFetchDataFromDB()),
                );
              },
            )
          ],
        ),
        body: BlocBuilder<DashboardPageBloc, DashboardPageState>(
          buildWhen: (previous, current) =>
              previous.memoData != current.memoData,
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children:
                    state.memoData.map((e) => dataWidget(data: e)).toList(),
              ),
            );
          },
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
      routeTo = MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) =>
                    FormPageBloc(dbBloc: context.read<MemoDbBloc>()),
                child: const FormPage(),
              ));
    }
    Navigator.push(
      context,
      routeTo,
    );
  }

  Widget dataWidget({required Memo data}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListTile(
        leading: const Icon(Icons.storage_rounded),
        title: Text(data.memo),
        trailing: const Icon(Icons.arrow_circle_right_rounded),
      ),
    );
  }
}
