// Carlos Emiliano Castro Trejo 
// Analysis and Design of Algorithms
// 20/04/2019

int numberOfPartitions=4; // Number of divisions in the canvas
int[] linesPosition=new int[numberOfPartitions-1]; // Array that represents the position of X of the multiple lines in the canvas

// List of point to train the perceptron
Trainer[] training = new Trainer[numberOfPartitions*1000];
// A Perceptron object
Perceptron ptron;

// We will train the perceptron with one "Point" object at a time
int count = 0;

// Coordinate space
  int xmin = 0;
  int ymin = 0;
  int xmax =0;
  int ymax =0;


// The function to describe a line 
float f(float x) {
  return 0.4*x+1;
}

void setup() 
{
  xmin = 0;
  ymin = 0;
  xmax =width;
  ymax =height;
  
  size(840, 560);
  int division=width/numberOfPartitions;


  linesPosition[0]=division;
  if(numberOfPartitions>2)
  {
    for(int x=1;x<linesPosition.length;x++)
    {
     linesPosition[x]=linesPosition[x-1]+division;
    }
  }
  
  
 
  
  // The perceptron has 3 inputs -- x, y, and bias
  // Second value is "Learning = new Perceptron(3, 0.00001,numberOfPartitions);  // Learning Constant is low just b/c it's fun to watch, this is not necessarily optimal
  ptron = new Perceptron(3, 0.00001,numberOfPartitions);  // Learning Constant is low just b/c it's fun to watch, this is not necessarily optimal

  // Create a random set of training points and calculate the "known" answer
  for (int i = 0; i < training.length; i++) 
  {
    float x = random(xmin,xmax);
    float y = random(ymin,ymax);
    int answer = 0;
   
   if(numberOfPartitions==2)
   {
     if(x<=division)
     {
       answer=0;
     }else
     {
       answer=1;
     }
   }else
   {
     if(x>linesPosition[linesPosition.length-1])
     {
       answer=linesPosition.length-2;
     } else
     {
       while(x>=linesPosition[answer])
       {
         answer++;
       }
     }
     
   
   }
    training[i] = new Trainer(x, y, answer+1);
  }
  smooth();
}


void draw() {
  background(255);
  strokeWeight(3);
  for(int x=0;x<linesPosition.length;x++)
  {
    line(linesPosition[x],0,linesPosition[x],height);
  }
  
 /* strokeWeight(1);
  for (int i = 0; i < training.length; i++) 
  {
    
    ellipse(training[i].inputs[0], training[i].inputs[1], 8, 8);
    
  }*/
  
 


  // Train the Perceptron with one "training" point at a time
  ptron.train(training[count].inputs, training[count].answer,numberOfPartitions);

  count = (count + 1) % training.length;

  // Draw all the points based on what the Perceptron would "guess"
  // Does not use the "known" correct answer
  
  for (int i = 0; i < count; i++) 
  {
    stroke(0);
    strokeWeight(1);
   
    int guess = ptron.feedforward(training[i].inputs,numberOfPartitions);
    fill(guess*100,guess*45,guess*62);
    ellipse(training[i].inputs[0], training[i].inputs[1], 8, 8);
  }
    
}
