package main.startup;

import java.util.ArrayList;
import java.util.List;

import org.springframework.boot.context.properties.ConfigurationProperties;


@ConfigurationProperties(prefix="oauth",locations="classpath:Properties/Action.properties")
public class ConfigInfo {
	
	public String casServerUrlPrefix;
	
	public String serverName;
	
	public String authServerName;
	
	public String casServerLoginUrl;
	
	public String clientId;
	
	public String secret;

	private String redirectAfterValidation;
	
	public String getRedirectAfterValidation() {
		return redirectAfterValidation;
	}

	public void setRedirectAfterValidation(String redirectAfterValidation) {
		this.redirectAfterValidation = redirectAfterValidation;
	}

	List<String> urlPatterns = new ArrayList<String>();
	
	
	public String getAuthServerName() {
		return authServerName;
	}

	public void setAuthServerName(String authServerName) {
		this.authServerName = authServerName;
	}


	public List<String> getUrlPatterns() {
		return urlPatterns;
	}

	public void setUrlPatterns(List<String> urlPatterns) {
		this.urlPatterns = urlPatterns;
	}
	
	public String getCasServerUrlPrefix() {
		return casServerUrlPrefix;
	}

	public void setCasServerUrlPrefix(String casServerUrlPrefix) {
		this.casServerUrlPrefix = casServerUrlPrefix;
	}

	public String getServerName() {
		return serverName;
	}

	public void setServerName(String serverName) {
		this.serverName = serverName;
	}

	public String getCasServerLoginUrl() {
		return casServerLoginUrl;
	}

	public void setCasServerLoginUrl(String casServerLoginUrl) {
		this.casServerLoginUrl = casServerLoginUrl;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getSecret() {
		return secret;
	}

	public void setSecret(String secret) {
		this.secret = com.hjd.util.Base64Util.encode(secret.getBytes());
	}

	

}
