public class GimmeProxy {

	public Boolean supportsHttps {get;set;} 
	public String protocol {get;set;} 
	public String ip {get;set;} 
	public String port {get;set;} 
	public Boolean get {get;set;} 
	public Boolean post {get;set;} 
	public Boolean cookies {get;set;} 
	public Boolean referer {get;set;} 
	public Boolean user_agent {get;set;} // in json: user-agent
	public Integer anonymityLevel {get;set;} 
	public String country {get;set;} 
	public Long unixTimestampMs {get;set;} 
	public Integer tsChecked {get;set;} 
	public Integer unixTimestamp {get;set;} 
	public String curl {get;set;} 
	public String ipPort {get;set;} 
	public String type_Z {get;set;} // in json: type
	public Double speed {get;set;} 
	public Integer verifiedSecondsAgo {get;set;} 

    public static GimmeProxy parse(String json){
		return (GimmeProxy) System.JSON.deserialize(json, GimmeProxy.class);
	}

}