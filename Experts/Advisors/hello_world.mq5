#property copyright "Copyright 2022, Eichi Takaya"
#property link "hoge"
#property version "0.1"

//--- input parameters
input int StopLoss = 30;
input int TakeProfit = 100;
input int ADX_Period = 8;
input int MA_Period = 8;



void OnInit()
{
    maHandle = iMA(_Symbol, _Period, MA_Period, 0, MODE_EMA, PRICE_CLOSE);
    if (maHandle < 0)
    {
        Alert("Error Creating Handles for indicators - error: ", GetLastError(), "!!")
    }
    return;
}

void OnTick()
{
    if (Bars(_Symble, _Period) < 60)
    {
        Aleart("We have less than 60 bars, EA will now exit!!");
        return;
    }

    static datetime Old_Time;
    datetime New_Time[1];
    bool IsNewBar = False;

    int copied = CopyTime(_Symbol, Period, 0, 1, New_Time);
    if (copied > 0)
    {
        if (Old_Time != New_Time[0])
        {
            IsNewBar = true;
            if (MQL5InfoInteger(MQL5_DEBUGGING))
            {
                Print("We have new bar here ", New_Time[0], "old time was ", Old_Time);
                Old_Time = New_Time[0];
            }
        }
    }
    else
    {
        Alert("Error in copying historical times data, error =", GetLastError());
        ResetLastError();
        return;
    }

    if (IsNewBar == false)
    {
        return;
    }

    
}

void OnDeinit(const int reason)
{
    IndicatorRelease(maHandle);
}