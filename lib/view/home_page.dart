import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:translate_app/components/backgroun.dart';
import 'package:translate_app/controller/controller.dart';
import 'package:translate_app/data/model/translate_model.dart';
import 'package:translate_app/data/service/app_helper.dart';
import 'package:translate_app/repository/get_info_repository.dart';
import '../components/keyboard_dissmisser.dart';
import '../components/time_delayed.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _delayed = Delayed(milliseconds: 700);
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppController>().getLang();
    });
    super.initState();
  }

  getInfo(String text) async {
    await AppHelper.checker(
        context: context,
        onConnect: () async {
          _targetController.text = 'Translating...';
          _targetController.text = await GetInfo.sendTranslate(TranslateModel(
              sourceLanguage: sourceLanguage,
              targetLanguage: targetLanguage,
              text: text));
          setState(() {});
        });
  }

  String sourceLanguage = 'en';
  String targetLanguage = 'uz';

  String source = 'English';
  String target = 'Uzbek';

  @override
  void dispose() {
    _sourceController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(builder: (context, state, child) {
      return Background(
        child: state.isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: Theme.of(context).hintColor,
              ))
            : OnUnFocusTap(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: DropdownButton(
                              dropdownColor: Theme.of(context).hintColor,
                              isExpanded: true,
                              value: source,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() => source = newValue);
                                }
                              },
                              items: state.languages.map((String? items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items ?? ''),
                                );
                              }).toList(),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                String newstr = target;
                                target = source;
                                source = newstr;
                                setState(() {});
                              },
                              icon: Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context)
                                      .hintColor
                                      .withOpacity(0.3),
                                ),
                                child: Icon(
                                  Icons.change_circle_outlined,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              )),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.8,
                            child: DropdownButton(
                              dropdownColor: Theme.of(context).hintColor,
                              style: Theme.of(context).textTheme.displaySmall,
                              isExpanded: true,
                              value: target,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() => target = newValue);
                                }
                              },
                              items: state.languages.map((String? items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items ?? ''),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).hintColor,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (s) {
                              _delayed.run(() async {
                                _targetController.clear();
                                sourceLanguage = state.codes[
                                        state.languages.indexOf(source)] ??
                                    'en';
                                targetLanguage = state.codes[
                                        state.languages.indexOf(target)] ??
                                    'uz';
                                await getInfo(_sourceController.text);
                                // ignore: use_build_context_synchronously
                                context.read<AppController>().addHistory(
                                    TranslateModel(
                                        sourceLanguage: sourceLanguage,
                                        targetLanguage: targetLanguage,
                                        text: _sourceController.text,
                                        response: _targetController.text));
                                setState(() {});
                              });
                            },
                            controller: _sourceController,
                            style: Theme.of(context).textTheme.displaySmall,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).hintColor,
                              hintText: "Type something",
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor
                                          .withOpacity(0.5)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none),
                              suffixIcon: Column(
                                children: [
                                  IconButton(
                                    splashRadius: 24,
                                    icon: Icon(
                                      Icons.star_border,
                                      color: Theme.of(context).cardColor,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<AppController>()
                                          .addFavourites(TranslateModel(
                                              sourceLanguage: sourceLanguage,
                                              targetLanguage: targetLanguage,
                                              text: _sourceController.text,
                                              response:
                                                  _targetController.text));
                                    },
                                  ),
                                  IconButton(
                                    splashRadius: 24,
                                    icon: Icon(
                                      Icons.copy,
                                      color: Theme.of(context).cardColor,
                                    ),
                                    onPressed: () async {
                                      await Clipboard.setData(ClipboardData(
                                          text: _sourceController.text));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(color: Theme.of(context).cardColor),
                          TextFormField(
                            readOnly: true,
                            controller: _targetController,
                            maxLines: 5,
                            minLines: 5,
                            style: Theme.of(context).textTheme.displaySmall,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).hintColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none),
                              suffixIcon: Column(
                                children: [
                                  IconButton(
                                    splashRadius: 24,
                                    icon: Icon(
                                      Icons.star_border,
                                      color: Theme.of(context).cardColor,
                                    ),
                                    onPressed: () {
                                      context
                                          .read<AppController>()
                                          .addFavourites(TranslateModel(
                                              sourceLanguage: sourceLanguage,
                                              targetLanguage: targetLanguage,
                                              text: _sourceController.text,
                                              response:
                                                  _targetController.text));
                                    },
                                  ),
                                  IconButton(
                                    splashRadius: 24,
                                    icon: Icon(
                                      Icons.copy,
                                      color: Theme.of(context).cardColor,
                                    ),
                                    onPressed: () async {
                                      await Clipboard.setData(ClipboardData(
                                          text: _targetController.text));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
