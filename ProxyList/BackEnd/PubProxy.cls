public class PubProxy {

	public class Support {
		public Integer https {get;set;} 
		public Integer get {get;set;} 
		public Integer post {get;set;} 
		public Integer cookies {get;set;} 
		public Integer referer {get;set;} 
		public Integer user_agent {get;set;} 
		public Integer google {get;set;} 

		public Support(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'https') {
							https = parser.getIntegerValue();
						} else if (text == 'get') {
							get = parser.getIntegerValue();
						} else if (text == 'post') {
							post = parser.getIntegerValue();
						} else if (text == 'cookies') {
							cookies = parser.getIntegerValue();
						} else if (text == 'referer') {
							referer = parser.getIntegerValue();
						} else if (text == 'user_agent') {
							user_agent = parser.getIntegerValue();
						} else if (text == 'google') {
							google = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Support consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Data {
		public String ipPort {get;set;} 
		public String ip {get;set;} 
		public String port {get;set;} 
		public String country {get;set;} 
		public String last_checked {get;set;} 
		public String proxy_level {get;set;} 
		public String type_Z {get;set;} // in json: type
		public String speed {get;set;} 
		public Support support {get;set;} 

		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'ipPort') {
							ipPort = parser.getText();
						} else if (text == 'ip') {
							ip = parser.getText();
						} else if (text == 'port') {
							port = parser.getText();
						} else if (text == 'country') {
							country = parser.getText();
						} else if (text == 'last_checked') {
							last_checked = parser.getText();
						} else if (text == 'proxy_level') {
							proxy_level = parser.getText();
						} else if (text == 'type') {
							type_Z = parser.getText();
						} else if (text == 'speed') {
							speed = parser.getText();
						} else if (text == 'support') {
							support = new Support(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public List<Data> data {get;set;} 
	public Integer count {get;set;} 

	public PubProxy(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'data') {
						data = arrayOfData(parser);
					} else if (text == 'count') {
						count = parser.getIntegerValue();
					} else {
						System.debug(LoggingLevel.WARN, 'PubProxy consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	
	public static PubProxy parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new PubProxy(parser);
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

    private static List<Data> arrayOfData(System.JSONParser p) {
        List<Data> res = new List<Data>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Data(p));
        }
        return res;
    }
}