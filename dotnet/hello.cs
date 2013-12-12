using System;
using MyNamespace;

class Program
{
    static void Main()
    {
        Console.WriteLine("Hello World!");
        Calculator calc = new Calculator();
        double answer = calc.Add(5,7);
        Console.WriteLine("5 plus 7 is:{0}", answer);
    }
}
