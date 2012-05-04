/***************************************************************************
 
 DATA REP FINAL PROJECT SPRING 2012
 
 " SMS Exploration "
 
 Courtney Mitchell
 
 ****************************************************************************/

// declare variables and objects
Table myTable;
ArrayList<MessageObject> messageList = new ArrayList();
SimpleDateFormat sdf;
PVector boundary; // declare boundary vector
HashMap<String, MessageBin> messageHash = new HashMap();
String[] words = {
  "[Heart]", "love", "home", "miss you", "kiss"
};

float globalTime = 0;
float timeSpeed = 0.005;

long startTime;
long endTime;
long totalTime;

//create user login buttons
UserButton user;
UserButton nonuser;
Reset reset;
OptionPanel options; //option panel
Exit x; //exit button
MessageObject sms;

PFont myFont;

PImage userButton; //image for button
PImage userButtonr; //image for button in mouseover state
PImage guestButton; //image for guest button
PImage guestButtonr; //image for buest button in mouseover state
PImage bb; //image for reset button
PImage chaosImg; //image for chaos option
PImage rchaosImg; //rollover
PImage timelineImg; //image for timeline option
PImage rtimelineImg; //rollover
PImage searchImg; //image for search option
PImage rsearchImg; //rollover
PImage heart; //image for heart
PImage redheart; //image for red heart
PImage note; //image for note background
PImage xImg; //image for exit button
PImage header; //image for header
PImage footer; //image for footer
PImage graph; //image of graph


boolean movingHearts; //initialize moving hearts to true
boolean on; //is the sketch running?
boolean hidden; //are the options hidden?
boolean nutbrown; //is the user a nutbrown?
boolean guest; // is the user a guest?
boolean chaos; //did the user choose chaos?
boolean timeline; //did the user choose timeline?
boolean search; //did the user choose search?
boolean popup; //show the text box

//declare timer
Timer timer;



//------------------------------ RESET STARTS HERE ---------------------------------//
void reset() { 
  on = false; //is the sketch running?
  hidden = false; //are the options hidden?
  nutbrown = false; //is the user a nutbrown?
  guest = false; // is the user a guest?
  chaos = false;
  timeline = false;
  search = false; 
  movingHearts = false;
  popup = false;

  user = new UserButton(userButton, userButtonr, width/3, height/2, 370, 340);
  nonuser = new UserButton(guestButton, guestButtonr, 2*width/3, height/2, 370, 340);
  reset = new Reset();
  options = new OptionPanel(chaosImg, timelineImg, searchImg, rchaosImg, rtimelineImg, rsearchImg);
  x = new Exit();
  // create new timer for 10 seconds
  timer = new Timer(10000);
  //timer.start();
}

//------------------------------ SETUP STARTS HERE ---------------------------------//

void setup() {
  size(screenWidth, screenHeight);
  smooth();
  noStroke();
  background(255);
  frameRate(30);

  myFont = createFont("helvetica", 8);
  textFont(myFont);
  boundary = new PVector(width, height);

  // load button images
  userButton = loadImage("hare1.png");
  userButtonr = loadImage("rhare.png");
  guestButton = loadImage("lorax1.png");
  guestButtonr = loadImage("rlorax.png");
  bb = loadImage("home_white.png");
  chaosImg = loadImage("shuffle.png");
  rchaosImg = loadImage("rshuffle.png");
  timelineImg = loadImage("timeline.png");
  rtimelineImg = loadImage("rtimeline.png");
  searchImg = loadImage("graph.png");
  rsearchImg = loadImage("rgraph.png");
  heart = loadImage("hrt.png");
  redheart = loadImage("rhrt.png");
  note = loadImage("note.png");
  xImg = loadImage("exit.png");
  header = loadImage("Header.png");
  footer = loadImage("Footer.png");
  graph = loadImage("NB_LoveGraph.png");

  //date format: 2010-08-23 19:56:22
  sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

  myTable = new Table(this, "SMS_byDate.csv"); //upload data into table
  reset();
  loadData();  
  createHashMap();

  startTime = messageList.get(0).theDate.getTime();
  endTime = messageList.get(messageList.size() - 1).theDate.getTime();
  //float totalTime = endTime - startTime;

  println("start " + startTime + "; end " + endTime);
  for (int i = 0; i < messageList.size(); i++) {
    MessageObject sms = messageList.get(i);
    float b = sms.theDate.getTime();
    float diff = b - startTime;
    // sms.birthtime = float(((int)sms.theDate.getTime() - (int)startTime)/(55148000.0));
    sms.birthtime = diff/(endTime - startTime);
    //println(sms.birthtime);
  }
}

//-------------------------------Draw -------------------------------------------//

void draw() {
  if (!on) {
    background(255);
    image(header, width/2, 100);
    image(footer, width/2, height - 100);
    user.display();
    user.hover();
    nonuser.display();
    nonuser.hover();
    hidden = false;
  }
  else if (on) {

    if (nutbrown) {
      //run nutbrown code
      background(0);
      reset.display();
      //display options for nutbrown
      options.display();
    }
    else if (guest) {
      //run guest code
      background(0);
      reset.display();
      // display options for guest      
      options.display();
    }
    if (chaos) {
      renderChaos();
      //println("Total messages = " + k);
    }
    if (popup) {
      renderText();
    }
    if (timeline) {
      globalTime += timeSpeed;
      if (globalTime > 1) globalTime = 0; //loop through time
      fill(255);
      textSize(18);
      text(globalTime, 100, 30);

      renderTimeline();
    }
    if (search) {
      imageMode(CENTER);
      image(graph, width/2, height/2);
    }
  }
}

//-------------------------------Load Data-------------------------------------------//

void loadData() {
  //start iterating through table at 1 as first row (row 0) is headers
  for (int i = 1; i < myTable.getRowCount()-1; i++) {
    String dateString = myTable.getString(i, 1);
    String messageText = myTable.getString(i, 2);
    String messageDirection = myTable.getString(i, 3); 
    if (messageDirection != null) {
      try {
        sms = new MessageObject();
        sms.dateString = dateString;
        sms.theDate = sdf.parse(sms.dateString);
        sms.messageText = messageText;
        sms.messageDirection = messageDirection; 
        if (sms.messageDirection.equals("in")) sms.pos = new PVector(width, 0);
        sms.tpos.x = random(10, boundary.x);
        sms.tpos.y = random(10, boundary.y - 10);
        int d = sms.theDate.getDay();
        sms.weekend = (d == 0 || d == 6);
        for (int j = 0; j < words.length; j++) {
          if (messageText.contains(words[j])) messageList.add(sms);
        }
      } 
      catch (Exception e) {
        //println("ERROR " + e);
      }
    }
  }
}

//-------------------------------Create Hashmap-------------------------------------------//

void createHashMap() {
  for (int i = 0; i < words.length; i++) {
    MessageBin bin = new MessageBin();
    bin.label = words[i];
    for (MessageObject sms:messageList) {
      if (sms.messageText.contains(words[i])) {
        try {
          //println(sms.messageText);
          bin.messageList.add(sms);
          bin.count++;
        } 
        catch (Exception e) {
          println("EXCEPTION " + e);
        }
      }
    }
    messageHash.put(words[i], bin);
    // println(messageHash.get(words[i]).label + " = " + messageHash.get(words[i]).count);
  }  
  int total = 0;
  for (int j = 0; j < messageHash.size(); j++) {
    MessageBin bin = messageHash.get(words[j]);
    total += bin.count;
    //println("MessageBin " + bin.label + " size = " + bin.count);
  }
  println("Total = " + total);
  println("messageList size= " + messageList.size());
  println("messageHash size= " + messageHash.size());
}

//-------------------------------Render Chaos-------------------------------------------//

void renderChaos() {
  for (MessageObject sms:messageList) {
    sms.update();   
    sms.render();
    sms.wiggle();
  }
}

//-------------------------------Render Text-------------------------------------------//

void renderText() {
  fill(255);
  //rect(width/3, height/3, 550, 350);
  image(note, width/3, height/3, 600, 400);
  x.render();
  String messageString = "";
  Date d = new Date();

  //for (MessageObject sms:messageList) {
  for (int i = 0; i < messageHash.size(); i++) {
    MessageBin bin = messageHash.get(words[i]);
    for (MessageObject sms:bin.messageList) {
      if (nutbrown && sms.clicked) {
        messageString = sms.messageText; //sms.showText();
        d = sms.theDate;
      }
      else if (guest && sms.clicked) {
        messageString = bin.label;
      }
    }
  }

  textFont(myFont);
  textSize(24);
  fill(0);
  text(messageString, width/3 + 50, height/3 + 125, 450, 350);
  textSize(14);
  //text(d.getDay(), width/3 + 200, height/2 + 350);
  //println(d);
}

//-------------------------------Render Timeline-------------------------------------------//
void renderTimeline() {
  for (int i = 0; i < messageList.size(); i++) {
    MessageObject sms = messageList.get(i);
    float stime = sms.theDate.getTime();
    if (sms.messageDirection.equals("out")) sms.tpos.x = map(stime, startTime, endTime, 50, width - 10);
    if (sms.messageDirection.equals("in")) {
      //sms.tpos.x = width - map(stime, startTime, endTime, 50, width - 10);
      sms.tpos.x =  map(stime, startTime, endTime, 50, width - 10);
     // println(sms.tpos.x);
    }
    if (sms.messageDirection.equals("out")) sms.tpos.y = height/2 + random(0,50);
    if (sms.messageDirection.equals("in")) sms.tpos.y = height/2 - random(0, 50);
    //sms.tpos.y = height/2 + random(-50, 50);
    sms.updateTimeline();
    sms.render();
  }
  fill(255);
  textSize(24);
  text("Incoming", width - 100, 70);
  text("Outgoing", 50, 70);
}

//-------------------------------Scatter Hearts-------------------------------------------//

void scatterHearts() {
  boundary.x = width - 10;
  for (MessageObject sms:messageList) {
    sms.tpos.x = random(10, boundary.x);
  }
}

//-------------------------------Focus Hearts-------------------------------------------//

void focusHearts() {
  boundary.x = 300;
  for (MessageObject sms:messageList) {
    sms.tpos.x = random(10, boundary.x);
  }
}

//-------------------------------Mouse Clicked-------------------------------------------//

void mouseClicked() {

  if (user.overButton) {
    println("nutbrown clicked");
    user.mouseClicked();
    nutbrown = true;
    user.overButton = !user.overButton;
  } 
  else if (nonuser.overButton) {
    println("guest clicked");
    nonuser.mouseClicked();
    guest = true;
    nutbrown = false;
    nonuser.overButton = !nonuser.overButton;
  }
  // if hit back button
  else if (reset.overButton()) {
    println("Back button clicked");
    reset.mouseClicked();
  }
  //if click option button
  else if (!hidden && options.overButton()) {
    println("option button clicked");
    options.mouseClicked();
  }
  if (chaos) {
    println("Chaos button clicked");

    for (MessageObject sms:messageList) {
      if (sms.mouseOver()) {
        focusHearts();
        movingHearts = false;
        sms.mouseClicked();
      }
    }
    if (x.overX()) {
      for (MessageObject sms:messageList) {
        sms.clicked = false;
      }
      popup = false;
      scatterHearts();
      movingHearts = true;
      x.mouseClicked();   
      println("EXIT");
    }
  }
  println("On " + on);
  println("chaos " + chaos);
  println("movingHearts " + movingHearts);
  println();
}

