import 'package:flutter/material.dart';

class TopicBottomModal extends StatefulWidget {
  final List<bool> topicStatus;
  TopicBottomModal({Key? key, required this.topicStatus}) : super(key: key);

  @override
  State<TopicBottomModal> createState() => _TopicBottomModal();
}

class _TopicBottomModal extends State<TopicBottomModal> {

  int countBoolList(List<bool> _topicStatus) {
    int count = 0;
    for (int i = 0; i < _topicStatus.length; i++) {
      if (_topicStatus.elementAt(i) == true) {
        count++;
      }
    }
    return count;
  }

  List<bool> _topicStatus = [
    false, 
    false, 
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 16,),
          Text(
            'Choose topic',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16,),
          Row(
            children: [
              ChipButton('Business', 1),
              ChipButton('Technology', 2),
              ChipButton('Games', 3),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              ChipButton('Education', 4),
              ChipButton('Movie', 5),
              ChipButton('Travel', 6),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              ChipButton('Music', 7),
              ChipButton('Horror', 8),
              ChipButton('Fashion', 9),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              ChipButton('Animal', 10),
              ChipButton('Art', 11),
              ChipButton('Food', 12),
            ],
          ),
          SizedBox(height: 64,),
          
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
  }

  Row ChipButton(name, iter) {
    return Row(
      children: [
        ElevatedButton(
          child: Text(
            '$name',
            style: TextStyle(
              color: _topicStatus[iter] ? Colors.white : Colors.grey,
            ),
          ),
          style: ElevatedButton.styleFrom(
            side: BorderSide(
              color: _topicStatus[iter] ? Color(0XFF178066) : Colors.grey,
              width: 1,
            ),

            backgroundColor: _topicStatus[iter] ? Color(0XFF178066) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onPressed: () => {
            setState(() {
              _topicStatus[iter] = !_topicStatus[iter];
            })
          },
        ),
        SizedBox(width: 8,),
      ],
    );
  }
}