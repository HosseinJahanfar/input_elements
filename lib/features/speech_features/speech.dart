import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Speech extends StatefulWidget {
  const Speech({super.key});

  @override
  State<Speech> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Speech> {
  var textSpeech = "CLICK ON MIC TO RECORD";
  SpeechToText speechToText = SpeechToText();
  var isListening = false;

  void checkMic() async {
    bool micAvailable = await speechToText.initialize();

    if (micAvailable) {
      print("MicroPhone Available");
    } else {
      print("User Denied th use of speech micro");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkMic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(textSpeech),
              GestureDetector(
                onTap: () async {
                  if (!isListening) {
                    bool micAvailable = await speechToText.initialize();

                    if (micAvailable) {
                      setState(() {
                        isListening = true;
                      });

                      speechToText.listen(
                          listenFor: const Duration(seconds: 40),
                          onResult: (result) {
                            setState(() {
                              textSpeech = result.recognizedWords;
                              isListening = false;
                            });
                          });
                    }
                  } else {
                    setState(() {
                      isListening = false;

                      speechToText.stop();
                    });
                  }
                },
                child: CircleAvatar(
                  child: isListening
                      ? const Icon(Icons.record_voice_over)
                      : const Icon(Icons.mic),
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("BackPages"))
            ],
          ),
        ),
      ),
    );
  }
}
