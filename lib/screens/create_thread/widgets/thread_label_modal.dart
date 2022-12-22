import 'package:fgd_flutter/models/topic/topic_response.dart';
import 'package:fgd_flutter/providers/create_thread_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fgd_flutter/shared/charum_ui.dart';
import 'package:provider/provider.dart';

class TopicBottomModal extends StatefulWidget {
  TopicBottomModal({Key? key}) : super(key: key);

  @override
  State<TopicBottomModal> createState() => _TopicBottomModal();
}

class _TopicBottomModal extends State<TopicBottomModal> {
  String? topicId;
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateThreadViewModel>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Choose topic',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 16,
              ),
              Wrap(
                children: [
                  for (var i = 0; i < provider.topics.length; i++)
                    Container(
                      margin: spacing8All,
                      child: ElevatedButton(
                        child: Text(
                          provider.topics[i].topic ?? "",
                          style: TextStyle(
                            color: provider.topics[i].isSelected
                                ? AppColors.kcBaseWhite
                                : AppColors.kcPrimaryColor,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: spacing16All,
                          side: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                          backgroundColor: provider.topics[i].isSelected
                              ? AppColors.kcPrimaryColor
                              : AppColors.kcBaseWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: () {
                          provider.setTopic(i);

                          setState(() {
                            topicId = provider.topics[i].sId;
                          });
                        },
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 64,
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0XFF178066),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () => {
                        Navigator.pop(context),
                      },
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
