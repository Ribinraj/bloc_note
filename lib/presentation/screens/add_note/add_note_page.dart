import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:notebloc/bloc/note_bloc.dart';

import 'package:notebloc/core/colors.dart';
import 'package:notebloc/core/constants.dart';
import 'package:notebloc/data/models/note_model.dart';
import 'package:notebloc/presentation/screens/add_note/widgets/add_custom_textfield.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime inputDateTime = DateTime.parse(DateTime.now().toString());
  late String formattedDateTime;
  @override
  void initState() {
    super.initState();

    formattedDateTime =
        DateFormat('hh:mm a | dd MMM yyyy').format(inputDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: kBlue,
        title: const Text('Add New Note',style: TextStyle(color:kwhite),),
      ),
      body: Container(
        color: kbackgroundcolor,
        child: Column(
          children: [
            const Divider(),
            SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                       AddCustomTextField(
                        controller: titleController,
                          hintText: 'Title',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      const Divider(),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_outlined,
                            size: 18,
                          ),
                          kWidth(5),
                          const Text(
                            'Date Created : ',
                            style: TextStyle(fontSize: 13),
                          ),
                          const Spacer(),
                          Text(
                            formattedDateTime,
                            style: const TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                      const Divider(),
                       AddCustomTextField(
                        controller: descriptionController,
                          hintText: 'Write your notes here.....',
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                    ],
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
          visible: MediaQuery.of(context).viewInsets.bottom == .0,
          child: MaterialButton(
            height: 50,
            color: kBlue,
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final newNote = NoteModel(
                    title: titleController.text,
                    description: descriptionController.text);
                context.read<NoteBloc>().add(NoteAddEvent(note: newNote));
              } else {
                customSnackbar(context, 'fill all forms');
              }
            },
            child: const Text(
              'Create',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          )),
    ));
  }
}
