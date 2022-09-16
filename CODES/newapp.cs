using System;

public class HelloWorld
{
    public static void Main(string[] args)
    {
        Console.WriteLine("Start code now");
        Console.Write("Enter number between 1 and 10: ");
        bool repeat=true;
        int num=0,min=1,max=10;        
        do{
            catcher(delegate(){checked{ 
            num = Convert.ToInt32(Console.ReadLine());
            }},repeat);

            repeat = checkRange(num,min,max);
        }while(!repeat);
        inputnum(num);
    }
    //methods
    static bool repeat;
    static bool checkRange(int check, int low, int high){
        repeat = (check < low || check > high) ? false : true;
        if (!repeat) Console.Write("Must be between "+low+" and "+high+"! Try again... ");
        return repeat;
    }
    static void inputnum(int x){
       x=x*2;
       Console.WriteLine("Mult by 2 gives "+x);
    }

    static void catcher(Action func,object p){
        do{
            try {
                func();
                repeat = false;
            } 
            catch(Exception e){
                Console.Write("Required value type is "+Convert.ToString(p.GetType()).Remove(0,7)+"! Try again... ");
                repeat = true;
            }
        }while(repeat);
    }
}
//C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe "C:\Users\Kaffu Chino\Desktop\CODES\newapp.cs" & newapp.exe  
