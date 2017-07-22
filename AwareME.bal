import ballerina.net.http;
import ballerina.lang.files;
import ballerina.lang.blobs;
import ballerina.lang.messages;


service<http> main {

    @http:GET {}
    resource Resource (message m) {

        m = {};

        files:File target = {path:"/home/anjana/Documents/Anjana/MyProjects/AwareME/views/index.html"};

        files:open(target, "r");
        var content, n = files:read(target, 100000);
        string s = blobs:toString(content, "utf-8");
        message res = messages:setStringPayload(m, s);
        files:close(target);
        reply m;
    }
}
