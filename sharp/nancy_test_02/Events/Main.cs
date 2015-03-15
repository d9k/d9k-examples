using System;
using Nancy.Hosting.Self;
using Nancy;
using System.Diagnostics;

namespace Events
{
	class MainClass
	{
		public static void Main (string[] args)
		{
			var nancyHost = new NancyHost(
//                new Uri("http://localhost:8888/"), 
//                new Uri("http://127.0.0.1:8888/"), 
//                new Uri("http://localhost:8889/"));, 
				new Uri("http://127.0.0.1:10888/"));           

//            StaticConfiguration.DisableErrorTraces = false;

			nancyHost.Start();
			
			Console.WriteLine("Nancy now listening - navigating to http://localhost:8888/. Press enter to stop");
//			Process.Start("http://localhost:8888/");
            Process.Start("http://127.0.0.1:10888/");
			Console.ReadKey();
			
			nancyHost.Stop();
			
			Console.WriteLine("Stopped. Good bye!");
		}
	}
}
