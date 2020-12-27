public class Proxy11 {

	public List<Data> data {get;set;} 

	public Proxy11(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'data') {
						data = arrayOfData(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'Proxy11 consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Data {
		public String country {get;set;} 
		public String country_code {get;set;} 
		public String createdAt {get;set;} 
		public Integer google {get;set;} 
		public String ip {get;set;} 
		public String port {get;set;} 
		public Double time_z {get;set;} // in json: time
		public Integer type_Z {get;set;} // in json: type
		public String updatedAt {get;set;} 

		public Data(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'country') {
							country = parser.getText();
						} else if (text == 'country_code') {
							country_code = parser.getText();
						} else if (text == 'createdAt') {
							createdAt = parser.getText();
						} else if (text == 'google') {
							google = parser.getIntegerValue();
						} else if (text == 'ip') {
							ip = parser.getText();
						} else if (text == 'port') {
							port = parser.getText();
						} else if (text == 'time_z') {
							time_z = parser.getDoubleValue();
						} else if (text == 'type') {
							type_Z = parser.getIntegerValue();
						} else if (text == 'updatedAt') {
							updatedAt = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static Proxy11 parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new Proxy11(parser);
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