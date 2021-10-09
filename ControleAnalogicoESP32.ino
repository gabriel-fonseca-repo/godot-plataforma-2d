void setup() {
  
Serial.begin(9600);

}

void loop() {
  
  int eixox = analogRead(34);// eixo x
  int eixoy = analogRead(35);// eixo y
  int botao = digitalRead(22);

  //Serial.print("Eixo X: ");
  //Serial.println(eixox);
  //Serial.print("Eixo Y: ");
  //Serial.println(eixoy);
  //Serial.println("");

  Serial.println(botao);

}
