import 'dart:io' show Platform, File, Directory;

import 'package:brain_fusion/brain_fusion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:path/path.dart' as xp;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../core/utils/strings.dart';
import '../../../services/openai_service.dart';
import '../../../ui_components/components/feature_box.dart';
import '../bloc/app_directory_cubit.dart';
import '../bloc/image_cubit.dart';
import 'package:malarify/core/utils/app_locale.dart';


class EduGenPage extends StatefulWidget {
  const EduGenPage({Key? key}) : super(key: key);

  @override
  State<EduGenPage> createState() => _EduGenPageState();
}

class _EduGenPageState extends State<EduGenPage> {
  late ImageCubit _imageCubit;
  late AppDirectoryCubit _appDirectoryCubit;
  late Directory directory;
  final TextEditingController _textEditingController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  final Map<AIStyle, String> styleDisplayText = {
    AIStyle.noStyle: 'No style',
    AIStyle.render3D: '3D render',
    AIStyle.anime: 'Anime',
    AIStyle.iconography: 'Icon Graphy',
    AIStyle.mosaic: 'Mosaic',
    AIStyle.moreDetails: 'More Detailed',
    AIStyle.cyberPunk: 'CyberPunk',
    AIStyle.cartoon: 'Cartoon',
    AIStyle.picassoPainter: 'Picasso painter',
    AIStyle.oilPainting: 'Oil painting',
    AIStyle.digitalPainting: 'Digital painting',
    AIStyle.portraitPhoto: 'Portrait photo',
    AIStyle.pencilDrawing: 'Pencil drawing',
  };



  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }
  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }


  @override
  void initState() {
    super.initState();
    _imageCubit = ImageCubit();
    initSpeechToText();
    initTextToSpeech();
    _appDirectoryCubit = context.read<AppDirectoryCubit>()..loadPath();
  }

  @override
  void dispose() {
    _imageCubit.close();
    _textEditingController.dispose();
    speechToText.stop();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _imageCubit,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              text: 'Malarify ',
              style: GoogleFonts.montserrat(
                textStyle:
                const TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 21
                ),
              ),
            ),
          ),
          centerTitle: true,
          leading: null,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              BlocBuilder<ImageCubit, ImageState>(
                builder: (context, state) {
                  if (state is ImageLoading) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(100),
                              child: Lottie.asset(
                                'assets/animations/loading.json',
                                frameRate: FrameRate(120),
                                repeat: true,
                                animate: true,
                              ),
                            ),
                          ),
                          Text(
                            translation(context).loading,
                            style: const TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    );
                  }
                  if (state is ImageLoaded) {
                    final image = state.image;
                    if (Platform.isAndroid) {
                      if (MediaQuery.of(context).orientation ==
                          Orientation.portrait) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  height: 60,
                                  width:
                                  MediaQuery.of(context).size.width * 0.9,
                                  child: InkWell(
                                    focusColor: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    borderRadius: BorderRadius.circular(7),
                                    onTap: () async {
                                      await _saveImage(image);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.9,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(4),
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                translation(context).download,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  focusColor: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  borderRadius: BorderRadius.circular(7),
                                  onTap: () async {
                                    await _saveImage(image);
                                  },
                                  child: SizedBox(
                                    width: 125,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Container(
                                            width: 125,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(4),
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                translation(context).download,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    } else {
                      if (MediaQuery.of(context).size.width >
                          MediaQuery.of(context).size.height) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: InkWell(
                                  focusColor: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  borderRadius: BorderRadius.circular(7),
                                  onTap: () async {
                                    await _saveImage(image);
                                  },
                                  child: SizedBox(
                                    width: 125,
                                    height: 50,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Container(
                                            width: 125,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(4),
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                translation(context).download,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Column(
                            children: [

                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  height: 60,
                                  width:
                                  MediaQuery.of(context).size.width * 0.9,
                                  child: InkWell(
                                    focusColor: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    borderRadius: BorderRadius.circular(7),
                                    onTap: () async {
                                      await _saveImage(image);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.9,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(4),
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                translation(context).download,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .background,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  }
                  return Container();
                },
              ),
              if (generatedContent != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20 * 0.75,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    generatedContent!,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.deepOrange, fontSize: 19),
                    ),
                  ),
                ),
              ),
              if (generatedImageUrl != null)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(generatedImageUrl!),
                  ),
                ),
              SlideInLeft(
                child: Visibility(
                  visible: generatedContent == null && generatedImageUrl == null,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 10, left: 22),
                    child: Text(
                      'What Malarify Could do',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            color: Color(0xFF39CBC3), fontSize: 19),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Column(
                  children: [
                    SlideInLeft(
                      delay: Duration(milliseconds: start),
                      child: const FeatureBox(
                        color: Colors.orangeAccent,
                        headerText: 'ChatGPT',
                        descriptionText:
                        'A smarter way to stay organized and informed with ChatGPT',
                      ),
                    ),
                    SlideInLeft(
                      delay: Duration(milliseconds: start + delay),
                      child: const FeatureBox(
                        color: Colors.orangeAccent,
                        headerText: 'Dall-E',
                        descriptionText:
                        'Get inspired and stay creative',
                      ),
                    ),
                    SlideInLeft(
                      delay: Duration(milliseconds: start + 2 * delay),
                      child: const FeatureBox(
                        color: Colors.orangeAccent,
                        headerText: 'Smart Voice Assistant',
                        descriptionText:
                        'Generate Malaria info with voice assistant powered '
                            'by Dall-E and ChatGPT',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 32,
                      color: const Color(0xFF087949).withOpacity(0.08),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      InkWell(
                        child: const Icon(Icons.mic, color: Color(0xFF00BF6D)),
                        onTap: ()async{
                          if (await speechToText.hasPermission &&
                          speechToText.isNotListening) {
                            await startListening();
                          } else if (speechToText.isListening) {
                            final speech = await openAIService.isArtPromptAPI(lastWords);
                            if (speech.contains('https')) {
                              generatedImageUrl = speech;
                              generatedContent = null;
                              setState(() {});
                            } else {
                              generatedImageUrl = null;
                              generatedContent = speech;
                              setState(() {});
                              await systemSpeak(speech);
                            }
                            await stopListening();
                          } else {
                            initSpeechToText();}
                        },
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(
                          padding:  const EdgeInsets.symmetric(
                            horizontal: 20 * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00BF6D).withOpacity(0.05),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _textEditingController,
                                  decoration: const InputDecoration(
                                    hintText: "Generate Educative Malaria Info",
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (text) {
                                    if (text.isEmpty) {
                                      setState(() {
                                        _textEditingController.clear();
                                      });
                                    }
                                  },
                                  onSubmitted: (query)async {
                                    if (query.isNotEmpty) {
                                      if (FocusScope.of(context).hasFocus) {
                                        FocusScope.of(context).unfocus();
                                      }
                                      setState(() {
                                        _textEditingController.text = query;
                                      });
                                      final res = await openAIService.isArtPromptAPI(query);
                                      if (res.contains('https')) {
                                        generatedImageUrl = res;
                                        generatedContent = null;
                                        setState(() {});
                                      } else {
                                        generatedImageUrl = null;
                                        generatedContent = res;
                                        setState(() {});
                                        await systemSpeak(res);
                                      }
                                      await stopListening();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _chooseStyle(String query) async {
    showDialog<AIStyle>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('${translation(context).chooseStyle} :'),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10.0,
                runSpacing: 10.0,
                children: styleDisplayText.entries.map((entry) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _imageCubit.generate(query, entry.key);
                      Navigator.pop(context);
                    },
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

          ],
        );
      },
    );
  }

  void _choosePath() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${translation(context).chooseDirectory} :'),
          content: Text(translation(context).confirmDirectory),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(translation(context).no),
            ),
            TextButton(
              onPressed: () {

              },
              child: Text(translation(context).yes),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveImage(Uint8List canvas) async {
    final String path = _appDirectoryCubit.state.path;
    try {
      if (path != pathHint) {
        directory = Directory(path);
        final appDir = Directory('${directory.path}/$app');
        if (!(await appDir.exists())) {
          await appDir.create();
        }
        final image =
        '''IMG-${DateTime.now().day.toString()}-${DateTime.now().month.toString()}-${DateTime.now().year.toString()}--${DateTime.now().hour.toString()}-${DateTime.now().minute.toString()}-${DateTime.now().millisecond.toString()}-logo.jpeg''';
        final filePath = xp.join(appDir.path, image);
        final file = File(filePath);
        await file.writeAsBytes(canvas).whenComplete(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
              Text('${translation(context).imageWasSaved} : $filePath'),
              elevation: 10,
            ),
          );
        });
      } else {
        _choosePath();
      }
    } catch (e) {
      if (kDebugMode) {
        print('when save image : $e');
      }
      _choosePath();
    }
  }
}
