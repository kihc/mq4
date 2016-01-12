
#property copyright "Miha Sedej"
#property link      "blabla"
#property version   "1.00"
#property strict

extern double maturity_of_order_in_hours = 1;
extern double lot_size = 0.1;
extern double take_profit_in_pips = 60;
extern double stop_loss_in_pips = 60;
extern int zaporedne_spremembe = 5;


const string version = "v0.01 "; 

int OnInit()
{
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  
  int ticket = 0;
  double stop_loss, take_profit;
  
  
  
  datetime maturity_of_order = 0;
  
  if(zaporedne_rasti() > zaporedne_spremembe)
  {
      //Print("Zaporedne rasti: ", zaporedne_rasti());
      
      stop_loss = Bid + stop_loss_in_pips * Point;
      //take_profit = Bid - take_profit_in_pips * Point;
      
      take_profit = Close[zaporedne_spremembe] + (Close[0] - Close[zaporedne_spremembe])/2;
      
      ticket = OrderSend(Symbol(), OP_SELL, lot_size, Bid, 2, stop_loss, take_profit, "Test SELL", 123, maturity_of_order, Red);
      
  }
  
  if(zaporedni_padci() > zaporedne_spremembe)
  {
      //Print("Zaporedni padci: ", zaporedni_padci());
      
      
      
      stop_loss = Ask - stop_loss_in_pips * Point;
      //take_profit = Ask + take_profit_in_pips * Point;
      
      take_profit = Close[0] + (Close[zaporedne_spremembe] - Close[0])/2;
      
      ticket = OrderSend(Symbol(), OP_BUY, lot_size, Ask, 2, stop_loss, take_profit, "Test BUY", 123, maturity_of_order, Green);
  }

   
  }
  
int zaporedne_rasti()
 {
   int i = 0;
   
   double razlika;
   
   while(true)
   {
      razlika = Close[i] - Close[i + 1];
      
      if(razlika >= 0)
      {
         i++;
      }
      else
      {
         break;
      }
   }
   
   return i;
 }
 
 int zaporedni_padci()
 {
   int i = 0;
   
   double razlika;
   
   while(true)
   {
      razlika = Close[i] - Close[i + 1];
      
      if(razlika <= 0)
      {
         i++;
      }
      else
      {
         break;
      }
   }
   
   return i;
 }