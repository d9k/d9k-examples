using System;
using Nancy;

namespace nancy_test_01 {
    public class HomeModule : NancyModule{
        public HomeModule () {
            Get ["/(.*)"] = _ => "Yes it works!";
            Get ["/"] = parameters => "Hello World";
        }
    }
}

