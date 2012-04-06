Table myTable;
ArrayList<MessageObject> messageList = new ArrayList();
MessageObject sms;
PFont myFont;
PImage heart; //image of heart

void setup() {
  size(1200, 800);
  smooth();
  background(255);
  myFont = createFont("helvetica", 8);
  heart = loadImage("smallheart.png");
  textFont(myFont);
  myTable = new Table(this, "SMS_byDate.csv");
  //heart = loadImage("heart.png"); 
  getData(); // get data from CSV
  positionMessages();
  renderMessages();
  //showMessages(); // println messages
  //drawHearts();
}

void draw() {
  //empty for now
  //background(255);
  //renderMessages();
}

void getData() {
  for (int i = 0; i < myTable.getRowCount(); i++) {
    String dateTime = myTable.getString(i, 1);
    String messageText = myTable.getString(i, 2);
    String messageDirection = myTable.getString(i, 3);
    sms = new MessageObject();
    sms.dateTime = dateTime;
    sms.messageText = messageText;
    sms.messageDirection = messageDirection;
    messageList.add(sms);
  }
}

void positionMessages() {
  for (int i = 0; i < messageList.size(); i++) {
    MessageObject sms = messageList.get(i);
    sms.tpos.x = random(5, width-textWidth(sms.messageText)-5);
    sms.tpos.y = random(10, height - 20);
    //println("X TPOS " + sms.tpos.x);
    //println("Y TPOS " + sms.tpos.y);
  }
}

void renderMessages() {
  int count = 0;
  int total = messageList.size();
  for (MessageObject sms:messageList) {

    if(sms.messageText.contains("love") || sms.messageText.contains( "[Heart]")){
      count++;
      sms.update();
      sms.render();
    }
    
   //println("X POS " + sms.pos.x);
   // println("Y POS " + sms.pos.y);
  }
  println("Love Count " + count);
  println("Total " + total);
}

void showMessages() {
  for (int i = 0; i < messageList.size(); i++) {
    println(messageList.get(i).messageText);
  }
}

