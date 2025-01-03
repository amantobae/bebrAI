import 'package:bebra_ai/features/chat/services/chat_services.dart';
import 'package:bebra_ai/models/message.dart';
import 'package:bebra_ai/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ChatService chatService = ChatService();
  final TextEditingController _controller = TextEditingController();
  final List<Message> messages = [];
  bool isLoading = false;

  void callGeminiModel() async {
    setState(() {
      isLoading = true;
    });

    await chatService.callGeminiModel(
      controller: _controller,
      messages: messages,
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: context.isDarkMode ? Colors.grey[700] : Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset("assets/gpt-robot.png"),
                SizedBox(width: 10.w),
                Text(
                  'BebrAI',
                  style: TextStyle(
                    color: context.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 19.sp,
                  ),
                ),
              ],
            ),
            Image.asset(
              "assets/volume-high.png",
              color: Colors.blue[800],
            )
          ],
        ),
      ),
      body: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        child: SizedBox(
          height: 1.h,
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return ListTile(
                      title: Align(
                        alignment: message.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: GestureDetector(
                          onLongPress: () async {
                            await Clipboard.setData(
                                ClipboardData(text: message.text));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Text copied to clipboard!")),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.sp),
                            decoration: BoxDecoration(
                              color: message.isUser
                                  ? Colors.blue
                                  : context.isDarkMode
                                      ? Colors.grey[500]
                                      : Colors.grey[300],
                              borderRadius: message.isUser
                                  ? BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      bottomLeft: Radius.circular(20.r),
                                      bottomRight: Radius.circular(20.r),
                                    )
                                  : BorderRadius.only(
                                      topRight: Radius.circular(20.r),
                                      bottomLeft: Radius.circular(20.r),
                                      bottomRight: Radius.circular(20.r),
                                    ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  message.text,
                                  style: TextStyle(
                                      color: message.isUser
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16.sp),
                                ),
                                SizedBox(height: 3.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10.sp,
                  bottom: 16.sp,
                  left: 16.sp,
                  right: 16.sp,
                ),
                child: Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                    color: context.isDarkMode ? Colors.grey[700] : Colors.white,
                    borderRadius: BorderRadius.circular(32.r),
                    boxShadow: [
                      BoxShadow(
                        color: context.isDarkMode
                            ? Colors.black.withOpacity(0.5)
                            : Colors.grey.withOpacity(0.5),
                        spreadRadius: 5.r,
                        blurRadius: 7.r,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 100.h,
                            ),
                            child: TextField(
                              controller: _controller,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: "Write your message",
                                hintStyle: TextStyle(fontSize: 15.sp),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.sp,
                                  vertical: 10.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: isLoading
                            ? SizedBox(
                                height: 24.h,
                                width: 24.h,
                                child: const CircularProgressIndicator(),
                              )
                            : GestureDetector(
                                onTap: () {
                                  if (_controller.text.isNotEmpty) {
                                    callGeminiModel();
                                  }
                                },
                                child: Image.asset("assets/send.png"),
                              ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
