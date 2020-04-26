using System;

namespace fibfinder
{
    class Program
    {
       
        static void Main(string[] args)
        {
            Console.WriteLine("Enter the fibonacci positions to find");
            int fibCount = 0;
            var position = Console.ReadLine();
            
            for (var i = 0; i <= Convert.ToInt32(position); i++)
            {
                fibCount++;
                var value = calculateFibAt(Convert.ToInt32(i));
            
                Console.WriteLine($"Fibonaci number at position: {i} is:  { value } and it took {fibCount} calls to get here");
            }

            Console.ReadKey();
        }

        static int calculateFibAt(int position)
        {
            if (position < 2)
            {
                return position;
            }
            else
            {
                return calculateFibAt(position - 2) + calculateFibAt(position - 1);
            }

        }

        //static int calculateFibFaster(int position)
        //{
           
        //}
    }
}
