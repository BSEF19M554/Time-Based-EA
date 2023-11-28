#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

//Headers
#include <Trade\Trade.mqh>

//Input
input int startTime;
input int endTime;
bool isTradeOpen = false;
CTrade trade;

//Init
int OnInit(){
   if(startTime == endTime){
      Alert("Start and end time are same!");
      return INIT_PARAMETERS_INCORRECT;
   }
   return(INIT_SUCCEEDED);
}

//Deinit
void OnDeinit(const int reason){
   
}

//OnTick
void OnTick(){
   MqlDateTime timeNow;
   TimeToStruct(TimeCurrent(), timeNow);
   
   if(timeNow.hour == startTime && !isTradeOpen){
      trade.PositionOpen(_Symbol, ORDER_TYPE_BUY, 1.0, SymbolInfoDouble(_Symbol, SYMBOL_ASK), 0, 0);
      isTradeOpen = true;
   }
   
   if(timeNow.hour == endTime && isTradeOpen){
      trade.PositionClose(_Symbol);
      isTradeOpen = false;
   }
}