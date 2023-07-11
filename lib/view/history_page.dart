import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:translate_app/components/backgroun.dart';
import 'package:translate_app/controller/controller.dart';
import 'package:translate_app/data/model/translate_model.dart';
import 'package:translate_app/data/store/store.dart';
import 'package:translate_app/view/style/style.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool isLoading = true;

  getHis() async {
    isLoading = true;
    setState(() {});
    List<TranslateModel> listOfWords = await LocalStore.getHistory();
    for (var element in listOfWords.reversed) {
      // ignore: use_build_context_synchronously
      context.read<AppController>().addHistory(element);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getHis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppController>();
    final event = context.read<AppController>();
    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "History",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium!
                      .copyWith(fontSize: 26),
                ),
                TextButton(
                    onPressed: () => event.removeAllHistory(),
                    child: Text(
                      "Clear All",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 12),
                    )),
              ],
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Theme.of(context).hintColor,
                ))
              : SizedBox(
                  height: 575,
                  child: ListView.builder(
                      itemCount: state.listOfHistory.length,
                      itemBuilder: (context, index) {
                        bool isFavourite = false;
                        for (var element in event.listOfFavourites) {
                          if (element == event.listOfHistory[index]) {
                            isFavourite = true;
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 10, right: 20),
                          child: Slidable(
                            key: UniqueKey(),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(
                                  onDismissed: () =>
                                      event.removeHistory(index)),
                              children: [
                                SlidableAction(
                                  onPressed: (s) => event.removeHistory(index),
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ],
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(left: 5, right: 15),
                              height: 70,
                              width: 355,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Theme.of(context).hintColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, bottom: 2),
                                    child: IconButton(
                                      onPressed: () {
                                        if (isFavourite) {
                                          event.removeFavourites(index);
                                          isFavourite = !isFavourite;
                                        } else {
                                          event.addFavourites(context
                                              .read<AppController>()
                                              .listOfHistory[index]);
                                          isFavourite = !isFavourite;
                                        }
                                      },
                                      icon: isFavourite
                                          ? const Icon(
                                              Icons.star,
                                              color: Style.primaryColor,
                                            )
                                          : const Icon(
                                              Icons.star_border,
                                              color: Color(0xffB5B5B5),
                                            ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        state.listOfHistory[index].text ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall!
                                            .copyWith(fontSize: 14),
                                      ),
                                      Text(
                                        state.listOfHistory[index].response ??
                                            '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium!
                                            .copyWith(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                      right: 15,
                                    ),
                                    child: Icon(
                                      Icons.description_outlined,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
        ],
      ),
    );
  }
}
