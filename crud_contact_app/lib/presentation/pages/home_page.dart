import 'package:crud_contact_app/domain/models/contact.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<Contacts> contacts = List.empty(growable: true);

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact App",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            TextFormField(
              
              controller: nameController,
              decoration:  InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                fillColor: Colors.grey[300],
                filled: true,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent
                  )
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.transparent
                  ),

                ),
              ),

            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: emailController,

              decoration:  InputDecoration(
                fillColor: Colors.grey[300],
                  contentPadding: const EdgeInsets.all(15),
                filled: true,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent
                  ),

                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.transparent
                  ),

                ),
              ),
            ),
            const SizedBox(height: 20,),
            TextButton(onPressed: (){
              String name = nameController.text.trim();
              String email = emailController.text.trim();
              if(name.isNotEmpty && email.isNotEmpty){
                if(selectedIndex == -1){
                setState(() {
                  nameController.text = '';
                  emailController.text = '';
                    contacts.add(Contacts(name: name, number: email));
                });}
                else{
                  setState(() {
                    nameController.text = '';
                    emailController.text = '';
                    contacts[selectedIndex].name = name;
                    contacts[selectedIndex].number = email;
                    selectedIndex =-1;
                  });
                }
              }

            },style: TextButton.styleFrom(
              backgroundColor: Colors.blue,shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            )
            ), child: const Text("Submit",style: TextStyle(color: Colors.white),),),
            const SizedBox(height: 20,),
            Expanded(child: ListView.builder(itemCount: contacts.length,itemBuilder: (context,index)=> getList(index)))

          ],
        ),
      ),
    );
  }

  Widget getList(int index) {
    return Card(
      color: Colors.blue[100],
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: (index % 2 == 0) ? Colors.orangeAccent : Colors.redAccent,
          child: Text(contacts[index].name[0]),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contacts[index].name),
            Text(contacts[index].number),
          ],
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(onPressed: (){
                setState(() {
                  nameController.text = contacts[index].name;
                  emailController.text = contacts[index].number;
                  selectedIndex = index;
                });
              }, icon: const Icon(Icons.edit,color: Colors.green,)),
              IconButton(onPressed: (){
                setState(() {
                  contacts.removeAt(index);
                });
              }, icon: const Icon(Icons.delete,color: Colors.red,)),
            ],
          ),
        ),
      ),
    );
  }
}
