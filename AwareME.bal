import ballerina.net.http;
import ballerina.lang.messages;

service<http> main {

    @http:GET {}
    resource Resource (message m) {
        message response = {};
        messages:setStringPayload(response, "Hello, World!"+m);
        reply response;
    }
}
