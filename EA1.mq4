// Author: kihc


extern double maturity_of_order_in_hours = 1;
extern double lot_size = 0.1;
extern double take_profit_in_pips = 100;
extern double stop_loss_in_pips = 60;

const string version = "EA1 v0.02 "; 


int OnInit()
{
   int ticket;
   double stop_loss, take_profit;
   datetime maturity_of_order = TimeLocal() + maturity_of_order_in_hours * 3600;


   // calulate some values
   double previous_week_high = iHigh(Symbol(), PERIOD_W1, 1);
   double previous_week_low = iLow(Symbol(), PERIOD_W1, 1);
   
   double min_stop_level = MarketInfo(Symbol(), MODE_STOPLEVEL); 
   
   

   
   // print some info
  
   Print(version + "init"); 
   Print(TimeToString(iTime(Symbol(), PERIOD_W1, 1)), " - last_week_high: ", previous_week_high, " - last_week_low: ", previous_week_low);
   
   // open BUY
   
   stop_loss = previous_week_low - stop_loss_in_pips * Point;
   take_profit = previous_week_low + take_profit_in_pips * Point;
   
   Print("BUY_stop_loss: ", stop_loss, " :: take_profit: ", take_profit);
   
   Print("server time: ", TimeToString(TimeCurrent()), " time expire: ", TimeToString(TimeLocal() + maturity_of_order_in_hours * 3600));
   
   
   
   ticket = OrderSend(Symbol(), OP_BUYLIMIT, lot_size, previous_week_low, 3, stop_loss, take_profit, "Test BUY", 123, maturity_of_order, Green);
   
   if(ticket > 0)
   {
      if(OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) 
         Print("BUY order opened : ", OrderOpenPrice());
   }
   else
   { 
      Print("Error opening BUY order : ", GetLastError());
   } 
   
   
   // open SELL
   
   stop_loss = previous_week_high + stop_loss_in_pips * Point;
   take_profit = previous_week_high - take_profit_in_pips * Point;
   
   Print("SELL_stop_loss: ", stop_loss, " :: take_profit: ", take_profit);
   
   Print("server time: ", TimeToString(TimeCurrent()), " time expire: ", TimeToString(TimeLocal() + maturity_of_order_in_hours * 3600));
   
   
   
   ticket = OrderSend(Symbol(), OP_SELLLIMIT, lot_size, previous_week_high, 3, stop_loss, take_profit, "Test SELL", 456, maturity_of_order, Red);
   
   if(ticket > 0)
   {
      if(OrderSelect(ticket, SELECT_BY_TICKET, MODE_TRADES)) 
         Print("BUY order opened : ", OrderOpenPrice());
   }
   else
   { 
      Print("Error opening BUY order : ", GetLastError());
   } 
   

   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
      Print(version + "deinit"); 
}

void OnTick()
{
   // do nothing
}

