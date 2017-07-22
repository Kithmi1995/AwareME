import ballerina.net.http;
import ballerina.lang.messages;
import ballerina.net.uri;




service <http> Controller{

    resource mainHandler(message m,string origin,string destination, int sTimeh,int sTimem) {


        http:ClientConnector google = create http:ClientConnector("http://localhost:9090/Controller");
        message request = {};


            int jw = sTimeh+(sTimem*3);
            string mn = "/getDirections?lat="+origin+"&lon="+destination+"&diptime="+<string>jw ;
            message response = http:ClientConnector.get(google,mn, request);
            json j = messages:getJsonPayload(response);
            json value = j.routes[2][2].value;
            messages:setJsonPayload(response,value);
        


        reply response;
    }

    resource getDirections(message s,string lat,string lon,string diptime){
        message request = {};
        http:ClientConnector googleDirections = create http:ClientConnector("https://maps.googleapis.com/maps/api/directions");
        string getdirection = "/json?origin="+uri:encode(lat)+"&destination="+uri:encode(lon)+"&departure_time="+diptime+"&key=AIzaSyBSqIQu8X1Z0DkW-R3pORPPJ9u41oQ1ChM";
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
