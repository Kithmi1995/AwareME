import ballerina.net.http;



service <http> getDirections{
    resource findMe(message s,string lat,string lon){
        message request = {};
        http:ClientConnector googleDirections = create http:ClientConnector("https://maps.googleapis.com/maps/api/directions");
        string getdirection = "/json?origin="+lat+"&destination="+lon+"&key=AIzaSyBSqIQu8X1Z0DkW-R3pORPPJ9u41oQ1ChM";
        message res = http:ClientConnector.get(googleDirections, getdirection, request);
        reply res;


    }
}
