public class ByteProxy {

    public class Response {
        public String ip {get;set;} 
        public Integer port {get;set;} 
        public String type {get;set;}
        public String anonymity {get;set;} 
        public String country {get;set;} 
        public String country_code {get;set;} 
        public Double load {get;set;} 
        public String checked {get;set;} 

        public Response(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'ip') {
                            ip = parser.getText();
                        } else if (text == 'port') {
                            port = parser.getIntegerValue();
                        } else if (text == 'type') {
                            type = parser.getText();
                        } else if (text == 'anonymity') {
                            anonymity = parser.getText();
                        } else if (text == 'country') {
                            country = parser.getText();
                        } else if (text == 'country_code') {
                            country_code = parser.getText();
                        } else if (text == 'load') {
                            load = parser.getDoubleValue();
                        } else if (text == 'checked') {
                            checked = parser.getText();
                        } else {
                            System.debug(LoggingLevel.WARN, 'Response consuming unrecognized property: '+text);
                            consumeObject(parser);
                        }
                    }
                }
            }
        }
    }
    
    public Boolean success {get;set;} 
    public Response response {get;set;} 

    public ByteProxy(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'success') {
                        success = parser.getBooleanValue();
                    } else if (text == 'response') {
                        response = new Response(parser);
                    } else {
                        System.debug(LoggingLevel.WARN, 'ByteProxy consuming unrecognized property: '+text);
                        consumeObject(parser);
                    }
                }
            }
        }
    }

    public static List<ByteProxy> parse(String json) {
        System.JSONParser parser = System.JSON.createParser(json);
        return arrayOfByteProxy(parser);
    }

    public static void consumeObject(System.JSONParser parser) {
        Integer depth = 0;
        do {
            System.JSONToken curr = parser.getCurrentToken();
            if (curr == System.JSONToken.START_OBJECT || 
                curr == System.JSONToken.START_ARRAY) {
                depth++;
            } else if (curr == System.JSONToken.END_OBJECT ||
                curr == System.JSONToken.END_ARRAY) {
                depth--;
            }
        } while (depth > 0 && parser.nextToken() != null);
    }

    private static List<ByteProxy> arrayOfByteProxy(System.JSONParser p) {
        List<ByteProxy> res = new List<ByteProxy>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new ByteProxy(p));
        }
        return res;
    }
}