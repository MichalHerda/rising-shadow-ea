//**********************************************************************************************************************
#property strict
//**********************************************************************************************************************
input ENUM_TIMEFRAMES timeFrame = PERIOD_M1;
input int maPeriod = 10;
ENUM_MA_METHOD maMethod = MODE_SMA;
ENUM_APPLIED_PRICE maPrice = PRICE_CLOSE;
//**********************************************************************************************************************
bool isHammerBar(double open, double close, double low, double high)
   {
      if(open <= close &&
        (open - low) > (close - open) * 2 &&
        (open - low) > (high - close) * 2) {
         return true;
      }
      else {
         return false;
      }              
   }
//**********************************************************************************************************************
int countOpenPositionsForSymbol(string symbol)
{
    int count = 0;
    
    for (int i = 0; i < OrdersTotal(); i++)
    {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
            if (OrderSymbol() == symbol)
            {
                count++;
            }
        }
    }    
    return count;
}  
//**********************************************************************************************************************
bool isBarBelowMovingAverage(ENUM_TIMEFRAMES tf, int period, int barIdx)
   {
      double movAve = iMA(Symbol(), tf, period, barIdx, maMethod, maPrice, 0);
      double highPrice = iHigh(Symbol(), tf, barIdx);
      
      return highPrice <= movAve;
   }
//**********************************************************************************************************************
bool isValidSetup(ENUM_TIMEFRAMES tf, int period, int barIdx)
   {
      double open  = iOpen(Symbol(), tf, barIdx);
      double close = iClose(Symbol(), tf, barIdx);
      double low   = iLow(Symbol(), tf, barIdx);
      double high  = iHigh(Symbol(), tf, barIdx);
      
      if(isBarBelowMovingAverage(tf, period, barIdx) &&
         isHammerBar(open, close, low, high) ) {
            return true;
         }
         else {
            return false;
         }  
      
   }
//**********************************************************************************************************************
int OnInit()
  {
   //EventSetTimer(60);
   return(INIT_SUCCEEDED);
  }
//**********************************************************************************************************************
void OnDeinit(const int reason)
  {
   //EventKillTimer();   
  }
//**********************************************************************************************************************
void OnTick()
  {
      
   
  }
//**********************************************************************************************************************
void OnTimer()
  {

   
  }
//**********************************************************************************************************************
