class Perceptron 
{
  float[] weights;  // Array of weights
  float learningConstant;          // Learning constant

  // Constructor
  Perceptron(int n, float c_) 
  {
    weights = new float[n];
    // Initialize the weights randomly
    for (int i = 0; i < weights.length; i++) 
    {
      weights[i] = random(-1,1); 
    }
    learningConstant = c_;
  }
  
  // Funcion para entrenar la red
  void train(float[] inputs, int desired) 
  {
      // Adivinia el resultado - (Suma los pesos*inputs)
      int guess = feedforward(inputs);
      
      float error = desired - guess;
      
      // Adjust weights based on weightChange * input
      for (int i = 0; i < weights.length; i++) 
      {
          weights[i] += learningConstant * error * inputs[i];         
      }
  }

 
  int feedforward(float[] inputs) 
  {
      // Sum all values
      float sum = 0;
      for (int i = 0; i < weights.length; i++) 
      {
        sum += inputs[i]*weights[i];
      }
      // Result is sign of the sum, -1 or 1
      return activate(sum);
  }
  
  // The activation function - This is the main function in order to take a specific decision
  int activate(float sum) 
  {
    if (sum > 0)
    {
      return 1;
    } 
    else
    {
      return -1; 
    } 
  }
  
  // Return weights
  float[] getWeights() 
  {
    return weights; 
  }
}
