import ballerina.net.http;
import ballerina.lang.time;


service <http> Controller{

    resource mainHandler(message m,string origin,string destination,int year,int month,int date, int sTimeh,int sTimem) {
        http:ClientConnector google = create http:ClientConnector("http://localhost:9090/Controller");
        message request = {};

        int i = 0;
        while (i<=10) {
            int j = sTimeh+(sTimem*i);
            string mn = "/getDirections?lat="+origin+"&lon="+destination+"&diptime="+<str>j ;
            message response = http:ClientConnector.get(google,mn, request);
            i = i-1;
        }

        reply response;
    }

    resource getDirections(message s,string lat,string lon,string diptime){
        message request = {};
        http:ClientConnector googleDirections = create http:ClientConnector("https://maps.googleapis.com/maps/api/directions");
        string getdirection = "/json?origin="+lat+"&destination="+lon+"&departure_time="+diptime+"&key=AIzaSyBSqIQu8X1Z0DkW-R3pORPPJ9u41oQ1ChM";
        message res = http:ClientConnector.get(googleDirections, getdirection, request);
        reply res;
    }

    resource getWeather(message m,string city) {
        http:ClientConnector google = create http:ClientConnector("http://api.openweathermap.org/data/2.5");
        message request = {};
        string mn = "/forecast?q="+city+",lk&mode=json&APPID=d47b92d5815e14b757875c19523c6805" ;
        message response = http:ClientConnector.get(google,mn, request);
        reply response;
    }
}
